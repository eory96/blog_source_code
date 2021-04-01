import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';

import '../blocs/todoBloc/bloc.dart';

class TodoAdd extends StatefulWidget {
  final String editTodo;
  final String editDesc;
  final String editDate;
  final DateTime editDateTime;
  final String editTag;
  final String editTodoId;

  const TodoAdd({
    Key key,
    this.editTodo,
    this.editDesc,
    this.editDate,
    this.editDateTime,
    this.editTag,
    this.editTodoId,
  }) : super(key: key);

  _TodoAdd createState() {
    if (this.editTodo == null) {
      return _TodoAdd();
    } else {
      return _TodoAdd(
        editTodo: editTodo,
        editDesc: editDesc,
        editDate: editDate,
        editDateTime: editDateTime,
        editTag: editTag,
        editTodoId: editTodoId,
      );
    }
  }
}

class _TodoAdd extends State<TodoAdd> {
  final String editTodo;
  final String editDesc;
  final String editDate;
  final DateTime editDateTime;
  final String editTag;
  final String editTodoId;

  // ignore: close_sinks
  TodoBloc _todoBloc;

  TextEditingController todo = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController newTag = TextEditingController();
  String selectDate = "";

  String formattedDate = DateFormat('yyyy년 MM월 dd일').format(DateTime.now());
  DateTime dateTime =
      DateTime.parse(DateTime.now().toString().substring(0, 10));
  bool calendarChange = false;

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  _TodoAdd({
    this.editTodo,
    this.editDesc,
    this.editDate,
    this.editDateTime,
    this.editTag,
    this.editTodoId,
  });

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _todoBloc = BlocProvider.of<TodoBloc>(context);
    if (editTodo != null) {
      todo = TextEditingController(text: editTodo);
      description = TextEditingController(text: editDesc);
      dateTime = editDateTime;
      formattedDate = editDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocListener(
      bloc: _todoBloc,
      listener: (BuildContext context, TodoState state) {},
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 1.3,
            centerTitle: true,
            title: Text("Todo Add"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
                _todoBloc.add(AddPopPressed());
              },
            ),
          ),
          body: BlocBuilder(
              bloc: _todoBloc,
              builder: (BuildContext context, TodoState state) {
                return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: ListView(
//                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            height: 30,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '할 일',
                              style: Theme.of(context).textTheme.display1,
                            )),
                        TextField(
                          decoration: InputDecoration(hintText: '무엇을 하실건가요'),
                          controller: todo,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40, bottom: 10),
                          child: Text(
                            '메모',
                            style: Theme.of(context).textTheme.display1,
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.7,
                            ),
                          ),
                          child: TextField(
                            textInputAction: TextInputAction.newline,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: description,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            '날짜',
                            style: Theme.of(context).textTheme.display1,
                          ),
                        ),
                        OutlineButton(
                          child: Container(
                            height: 50,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(),
                                ),
                                Icon(Icons.calendar_today),
                                Container(
                                  width: 15,
                                ),
                                Text(calendarChange == false
                                    ? state.selectedDateStr
                                    : state.date),
                                Expanded(
                                  child: Container(),
                                ),
                              ],
                            ),
                          ),
                          onPressed: () {
                            _selectDate(context, state);
                          },
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            '태그',
                            style: Theme.of(context).textTheme.display1,
                          ),
                        ),
                        Container(
                          height: 55,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.tagList.length + 1,
                            itemBuilder: (BuildContext context, int index) {
                              print(state.tagList);
                              if (state.tagList.length != 0) {
                                if (index < state.tagList.length) {
                                  print(state.tagList[index].id);
                                  return _circleTag(
                                      state,
                                      Color.fromARGB(
                                        state.tagList[index].color[3],
                                        state.tagList[index].color[0],
                                        state.tagList[index].color[1],
                                        state.tagList[index].color[2],
                                      ),
                                      state.tagList[index].id);
                                } else {
                                  return _addTag(state);
                                }
                              } else {
                                return _addTag(state);
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Center(
                            child: OutlineButton(
                              borderSide: BorderSide(
                                color: Color(0xFF2650BB),
                              ),
                              color: Colors.white,
                              onPressed: () {
                                if (todo.text.isNotEmpty) {
                                  if (state.forEdit == false) {
                                    _todoBloc.add(
                                      TodoAddPressed(
                                          todoId: DateTime.now()
                                              .millisecondsSinceEpoch
                                              .toString(),
                                          id: state.id,
                                          todo: todo.text,
                                          desc: description.text,
                                          date: calendarChange == false
                                              ? state.selectedDateStr
                                              : state.date,
                                          dateTime: calendarChange == false
                                              ? DateTime.parse(
                                                  state.selectedDateStr)
                                              : dateTime),
                                    );
                                  } else {
                                    _todoBloc.add(
                                      TodoEditCompletePressed(
                                          preDateTime: editDateTime,
                                          preTodo: editTodo,
                                          preDate: editDate,
                                          preTodoId: editTodoId,
                                          id: state.id,
                                          todo: todo.text,
                                          desc: description.text,
                                          date: calendarChange == false
                                              ? state.selectedDateStr
                                              : state.date,
                                          dateTime: calendarChange == false
                                              ? DateTime.parse(
                                                  state.selectedDateStr)
                                              : dateTime),
                                    );
                                  }

                                  Navigator.pop(context);
                                } else {
                                  _showDialog();
                                }
                              },
                              child: Container(
                                height: 55,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(),
                                    ),
                                    Icon(Icons.add),
                                    Container(
                                      width: 10,
                                    ),
                                    Text(
                                      state.forEdit == false
                                          ? '새로운 일정 추가하기'
                                          : '수정 완료',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    Expanded(
                                      child: Container(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        state.forEdit == false
                            ? Container()
                            : Padding(
                                padding: EdgeInsets.only(bottom: 40, top: 20),
                                child: OutlineButton(
                                  child: Container(
                                    height: 55,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(),
                                        ),
                                        Icon(Icons.delete),
                                        Container(
                                          width: 10,
                                        ),
                                        Text(
                                          '삭제하기',
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        Expanded(
                                          child: Container(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  borderSide:
                                      BorderSide(color: Color(0xFF2650BB)),
                                  onPressed: () {
                                    _showDeleteDialog();
                                  },
                                ),
                              )
                      ],
                    ),
                  ),
                );
              })),
    );
  }

  Future<void> _selectDate(BuildContext context, TodoState state) async {
    FocusScope.of(context).requestFocus(FocusNode());
    DateTime d = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(state.selectedDateStr),
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );

    dateTime = d;

    selectDate = DateFormat('yyyy-MM-dd').format(d);
    _todoBloc.add(AddDateChanged(date: selectDate));
    calendarChange = true;
  }

  Widget _circleTag(TodoState state, Color color, String id) {
    return Container(
      padding: EdgeInsets.only(right: 20),
      child: InkResponse(
        onTap: () {
          _todoBloc.add(TodoIdChanged(id: id));
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: state.id == id
              ? Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 35,
                )
              : null,
        ),
      ),
    );
  }

  Widget _addTag(TodoState state) {
    return Container(
      padding: EdgeInsets.only(right: 20),
      child: InkResponse(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          _tagAddDialog(state);
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              shape: BoxShape.circle, border: Border.all(color: Colors.grey)),
          child: Icon(
            Icons.add,
            color: Colors.grey,
            size: 35,
          ),
        ),
      ),
    );
  }

  void _showDialog() async {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("필수 요소를 적으셨나요?"),
          content: Text("할 일 부분을 반드시 적어 주세요!!"),
          actions: <Widget>[
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

  void _tagAddDialog(TodoState state) async {
    showDialog(
      context: context,
      child: ClipRect(
        child: AlertDialog(
          title: const Text('태그 추가하기'),
          content: Container(
            height: 380,
            width: double.maxFinite,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: TextField(
                        decoration: InputDecoration(hintText: '태그의 이름을 설정해주세요'),
                        controller: newTag,
                      ),
                    ),
                    SingleChildScrollView(
                      child: ColorPicker(
                        pickerColor: pickerColor,
                        onColorChanged: changeColor,
                        showLabel: false,
                        pickerAreaHeightPercent: 0.8,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text(
                '취소하기',
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text('추가하기'),
              onPressed: () {
                setState(() => currentColor = pickerColor);
                _todoBloc.add(TagColorCompleted(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  color: [
                    pickerColor.red,
                    pickerColor.green,
                    pickerColor.blue,
                    pickerColor.alpha,
                  ],
                  tagName: newTag.text == "" ? "무제" : newTag.text,
                ));
                newTag = TextEditingController();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog() async {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("해당 할일을 삭제하시겠습니까?"),
          content: Text("삭제하시면 다시 복구할수가 없습니다."),
          actions: <Widget>[
            FlatButton(
              child: Text('아니요'),
              onPressed: () {
                Navigator.pop(context, "OK");
              },
            ),
            FlatButton(
              child: Text('삭제하기'),
              onPressed: () {
                _todoBloc.add(TodoDelete(todoId: editTodoId));
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
