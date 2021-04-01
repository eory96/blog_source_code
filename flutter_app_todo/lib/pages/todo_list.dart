import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_todo/blocs/todoBloc/bloc.dart';
import 'package:flutter_app_todo/pages/settings/tag_delete.dart';
import 'package:flutter_app_todo/pages/todo_add.dart';
import 'package:flutter_app_todo/utils/holidays.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:table_calendar/table_calendar.dart';

class TodoList extends StatefulWidget {
  _TodoList createState() => _TodoList();
}

class _TodoList extends State<TodoList> {
  TodoBloc _todoBloc;
  CalendarController _calendarController;
  bool switchOn = false;
  int calendarMonth = DateTime.now().month;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _todoBloc = BlocProvider.of<TodoBloc>(context);
//    _todoBloc.add(TodoPageLoaded());

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('ic_launcher');
    var ios = IOSInitializationSettings();
    var initSetting = InitializationSettings(android, ios);

    flutterLocalNotificationsPlugin.initialize(initSetting,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    debugPrint("payload : $payload");
  }

  ///local notification 매일 날리기
  showNotificationRepeat() async {
    var android = AndroidNotificationDetails(
        'channel id', 'channel name', 'channel description',
        priority: Priority.High, importance: Importance.Max);
    var ios = IOSNotificationDetails();

    var platform = NotificationDetails(android, ios);
    var time = Time(8, 30, 0);

    await flutterLocalNotificationsPlugin.showDailyAtTime(
      1,
      '오늘도 행복한 하루!',
      '오늘의 계획을 확인해 보세요!',
      time,
      platform,
      payload: 'Hello Flutter',
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocListener(
      bloc: _todoBloc,
      listener: (BuildContext context, TodoState state) {
        if (state.addDone) {
          _calendarController.setSelectedDay(state.calendarDateTime);
          _todoBloc.add(AddDoneToFalse());
        }
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 1.3,
            centerTitle: true,
            title: Text("Todo List"),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                BlocProvider.value(
                                    value: _todoBloc, child: TodoAdd())));
                  })
            ],
          ),
          drawer: Drawer(
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.delete_outline),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          '태그 삭제하기',
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                    value: _todoBloc,
                                    child: TagDelete(),
                                  )));
                    },
                  ),
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.replay),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          '초기화하기',
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    onTap: () {
                      _showClearDialog('초기화 하시겠습니까?');
                    },
                  ),
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.notifications_active),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          '알림켜기',
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    onTap: () {
                      showNotificationRepeat();
                      _showAlramDialog('알람이 켜졌습니다.');
                    },
                  ),
                  ListTile(
                      title: Row(
                        children: <Widget>[
                          Icon(Icons.notifications_off),
                          SizedBox(
                            width: 17,
                          ),
                          Text(
                            '알림끄기',
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
//                    trailing: Icon(Icons.notifications_off),
                      onTap: () {
                        flutterLocalNotificationsPlugin.cancelAll();
                        _showNoAlramDialog('알람 끄기');
                      }),
                ],
              ),
            ),
          ),
          body: BlocBuilder(
              bloc: _todoBloc,
              builder: (context, TodoState state) {
                return Column(
                  children: <Widget>[
                    _buildTableCalendar(state),
//                    state.calendarDateTime.month == calendarMonth
//                        ? Container()
//                        : Text(
//                            state.calendarDateTime.toString().substring(0, 10)),
                    state.selectedList.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                                itemCount: state.selectedList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    title: Row(
                                      children: <Widget>[
                                        _tagClassify(
                                            state.selectedList[index].id,
                                            state),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Flexible(
                                          child: Text(
                                            state.selectedList[index].todo,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      _showDialog(
                                          state,
                                          index,
                                          state.selectedList[index].todo,
                                          state.selectedList[index].desc);
                                    },
                                    trailing: Checkbox(
                                      value: state.selectedList[index].checked,
                                      onChanged: (bool newValue) {
                                        _todoBloc.add(TodoListCheck(
                                            index: index,
                                            todo: state.selectedList[index]));
                                      },
                                    ),
                                  );
                                }),
                          )
                        : Container(),
                  ],
                );
              })),
    );
  }

  Widget _buildTableCalendar(TodoState state) {
    return TableCalendar(
      initialSelectedDay: DateTime.parse(state.selectedDateStr),
      availableGestures: AvailableGestures.horizontalSwipe,
      calendarController: _calendarController,
      events: state.events,
      holidays: holidays,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      calendarStyle: CalendarStyle(
        selectedColor: Color(0xFF2650BB),
        todayColor: Color(0xFF9AA7DB),
        markersColor: Color(0xFF7FC7C6),
        outsideDaysVisible: true,
      ),
      headerStyle: HeaderStyle(
          centerHeaderTitle: true,
          formatButtonVisible: false,
          headerMargin: EdgeInsets.only(bottom: 10),
          titleTextBuilder: (date, locale) {
            calendarMonth = date.month;
            return "${date.year}년 ${date.month}월";
          }),
      onDaySelected: (dateTime, event) {
        _todoBloc.add(CalendarDateChanged(dateTime: dateTime));
      },
      onVisibleDaysChanged: (firstDay, lastDay, format) {
        print('CALLBACK: _onVisibleDaysChanged : $firstDay');
      },
    );
  }

  Widget _tagClassify(String id, TodoState state) {
    Color color;

    for (int i = 0; i < state.tagList.length; i++) {
      if (state.tagList[i].id == id) {
        color = state.tagColors[i];
        print("id : " + id.toString());
        print("i : " + i.toString());
        break;
      }
    }

    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 50),
      height: 13,
      width: 13,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  //눌렀을때 부가적인 설명에 대한 dialog가 나올수 있도록 하기 위한 작업이다.
  //일단은 해야할것의 제목, 부가적인 설명을 받아 다이얼로그 페이지에 보일수 있도록 해두었다.
  void _showDialog(
      TodoState state, int index, String title, String description) async {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: description.isNotEmpty
              ? Container(
                  height: 150,
                  width: double.maxFinite,
                  child: ListView(
                    children: <Widget>[
                      Text(description),
                    ],
                  ),
                )
              : Text("부가적인 설명을 적지 않았습니다."),
          actions: <Widget>[
            FlatButton(
              child: Text('수정하기'),
              onPressed: () {
                Navigator.pop(context, "OK");
                _todoBloc.add(EditBtnPressed());
                _todoBloc.add(TodoIdChanged(id: state.selectedList[index].id));

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => BlocProvider.value(
                            value: _todoBloc,
                            child: TodoAdd(
                              editTodo: title,
                              editDesc: description,
                              editDate: state.selectedList[index].date,
                              editDateTime: DateTime.parse(
                                  state.selectedList[index].date),
                              editTag: state.selectedList[index].id,
                              editTodoId: state.selectedList[index].todoId,
                            ))));
              },
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context, "OK");
              },
            ),
          ],
        );
      },
    );
  }

  void _showClearDialog(String title) async {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text('저장된 모든 내용이사라집니다.\n정말 초기화 하시겠습니까?'),
          actions: <Widget>[
            FlatButton(
              child: Text('아니요'),
              onPressed: () {
                Navigator.pop(context, "NO");
              },
            ),
            FlatButton(
              child: Text('네'),
              onPressed: () {
                _todoBloc.add(TodoListClear());
                Navigator.pop(context, "OK");
              },
            ),
          ],
        );
      },
    );
  }

  void _showAlramDialog(String title) async {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('매일 08시 30분에 알림이 울립니다.'),
          actions: <Widget>[
            FlatButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.pop(context, "OK");
              },
            ),
          ],
        );
      },
    );
  }

  void _showNoAlramDialog(String title) async {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('매일 08시 30분에 알림이 울리지 않습니다.'),
          actions: <Widget>[
            FlatButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.pop(context, "OK");
              },
            ),
          ],
        );
      },
    );
  }
}
