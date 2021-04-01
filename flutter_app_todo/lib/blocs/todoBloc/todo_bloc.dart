import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_todo/blocs/todoBloc/bloc.dart';
import 'package:flutter_app_todo/models/tag_model.dart';
import 'package:flutter_app_todo/models/todo_model.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class TodoBloc extends Bloc<TodoListEvent, TodoState> {
  File jsonFile;
  Directory dir;
  String fileName = "todoJsonFile9.json";
  bool fileExists = false;

  File tagJsonFile;
  Directory tagDir;
  String tagFileName = "todoTagJsonFile9.json";
  bool tagFileExists = false;

  File notificationFile;
  Directory notificationDir;
  String notificationFileName = "notoficationJsonFile9.json";
  bool notificationExits = false;

  @override
  // TODO: implement initialState
  TodoState get initialState => TodoState.empty();

  @override
  Stream<TodoState> mapEventToState(TodoListEvent event) async* {
    // TODO: implement mapEventToState
    if (event is TodoPageLoaded) {
      yield* _mapTodoPageLoadedToState();
    } else if (event is TodoListCheck) {
      yield* _mapTodoListCheckToState(event.index, event.todo);
    } else if (event is AddPopPressed) {
      yield* _mapAddPopPressedToState();
    } else if (event is AddDateChanged) {
      yield* _mapAddDateChangedToState(event.date);
    } else if (event is TodoAddPressed) {
      yield* _mapTodoAddPressedToState(event.id, event.todoId, event.todo,
          event.date, event.desc, event.dateTime);
    } else if (event is TodoIdChanged) {
      yield* _mapTodoIdChangedToState(event.id);
    } else if (event is CalendarDateChanged) {
      yield* _mapCalendarDateChangedToState(event.dateTime);
    } else if (event is TagColorChanged) {
      yield* _mapTagColorChangedToState(event.id, event.color, event.tagName);
    } else if (event is TagColorCompleted) {
      yield* _mapTagColorCompletedToState(event.id, event.color, event.tagName);
    } else if (event is TagDeleted) {
      yield* _mapTagDeletedToState(event.id);
    } else if (event is TodoListClear) {
      yield* _mapTodoListClearToState();
    } else if (event is TagEditComplete) {
      yield* _mapTagEditCompleteToState(
          event.id, event.color, event.tagName, event.index);
    } else if (event is TodoEditCompletePressed) {
      yield* _mapTodoEditCompletePressedToState(
          event.preDateTime,
          event.preTodo,
          event.preDate,
          event.preTodoId,
          event.id,
          event.todoId,
          event.todo,
          event.date,
          event.desc,
          event.dateTime);
    } else if (event is EditBtnPressed) {
      yield* _mapEditBtnPressedToState();
    } else if (event is AddDoneToFalse) {
      yield* _mapAddDoneToFalseToState();
    } else if (event is TodoDelete) {
      yield* _mapTodoDeleteToState(event.todoId);
    }
  }

  Stream<TodoState> _mapTodoPageLoadedToState() async* {
    List<Todo> currentData = [];
    List<Todo> todayData = [];
    List<Tag> tagData = [];

    List<DateTime> eventDateTime = [];
    List<Color> color = [];
    String tagId = "";

    List<Map<String, dynamic>> content = [
      {
        "id": "0",
        "todo": "",
        "date": "1700-01-01",
        "desc": "",
        "checked": false
      }
    ];

    List<Map<String, dynamic>> tag = [];

    Map<DateTime, List> events = {};

    await getApplicationDocumentsDirectory().then((Directory directory) async {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);

      fileExists = jsonFile.existsSync();
      if (fileExists) {
        String data = await jsonFile.readAsString();

        json.decode(data).forEach((dynamic data) {
          currentData.add(Todo.fromJson(data));
          if (data['date'] == DateFormat('yyyy-MM-dd').format(DateTime.now())) {
//            print(data['date']);
//            print(data);
            todayData.add(Todo.fromJson(data));
          }

          DateTime dateTime = DateTime.parse(data['date']);

          if (!eventDateTime.contains(dateTime)) {
            eventDateTime.add(dateTime);
            events.addAll({dateTime: []});
            events[dateTime].add(data['todo']);
//            print(events[dateTime]);
          } else {
            events[dateTime].add(data['todo']);
//            print(events[dateTime]);
          }
        });
        print("여기는 첫번째 부분이고1");
      } else {
        createFile(content, dir, fileName);
      }
    });

    await getApplicationDocumentsDirectory().then((Directory directory) async {
      tagDir = directory;
      tagJsonFile = new File(tagDir.path + "/" + tagFileName);

      tagFileExists = tagJsonFile.existsSync();
      if (tagFileExists) {
        String data = await tagJsonFile.readAsString();
//        print(data);
//        print("json 파일 있는디요??");

        try {
//          print(json.decode(data));

          json.decode(data).forEach((dynamic data) {
            tagData.add(Tag.fromJson(data));
            tagId = Tag.fromJson((data)).id;
            color.add(Color.fromARGB(
              Tag.fromJson((data)).color[3],
              Tag.fromJson((data)).color[0],
              Tag.fromJson((data)).color[1],
              Tag.fromJson((data)).color[2],
            ));
          });
          print("여기는 두번째 부분이고1");
        } catch (e) {
//          print("no data");
//          print(e);
        }
      } else {
        createFile(tag, tagDir, tagFileName);
      }
    });

    print("여기가 마지막 부분임 원래");

    yield state.update(
      tagColors: color,
      events: events,
      todoList: currentData,
      selectedList: todayData,
      tagList: tagData,
      tagLastId: 0,
      loadDone: true,
      addDone: true,
    );
  }

  Stream<TodoState> _mapTodoListCheckToState(int index, Todo todo) async* {
    Todo currentTodo = Todo(
        id: state.selectedList[index].id,
        todoId: state.selectedList[index].todoId,
        desc: state.selectedList[index].desc,
        todo: state.selectedList[index].todo,
        date: state.selectedList[index].date,
        checked: state.selectedList[index].checked == true ? false : true);

    List<Todo> totalTodo = state.todoList;

    for (int i = 0; i < totalTodo.length; i++) {
      if (totalTodo[i].todoId == currentTodo.todoId) {
        if (totalTodo[i].checked == true) {
          totalTodo[i].checked = false;
        } else {
          totalTodo[i].checked = true;
        }
        break;
      }
    }

    List<Todo> cTodoList = state.selectedList;
    cTodoList[index] = currentTodo;
    writeToFile(totalTodo);
    yield state.update(
        selectedList: cTodoList,
        selectedDateStr: state.selectedDateStr,
        calendarDateTime: state.calendarDateTime);
  }

  Stream<TodoState> _mapAddPopPressedToState() async* {
    yield state.update(forEdit: false);
  }

  Stream<TodoState> _mapAddDateChangedToState(String date) async* {
    yield state.update(date: date);
  }

  Stream<TodoState> _mapTodoAddPressedToState(String id, String todoId,
      String todo, String date, String desc, DateTime dateTime) async* {
    Todo newTodo = Todo(
        id: id,
        todoId: todoId,
        todo: todo,
        date: date,
        desc: desc,
        checked: false);

    List<Todo> totalTodo = state.todoList;
    List<Todo> selectedTodo = state.selectedList;
    Map<DateTime, List> updateEventSet = state.events;

    if (updateEventSet.keys.toList().contains(DateTime.parse(date)))
      updateEventSet[dateTime].add(todo);
    else
      updateEventSet.addAll({
        dateTime: [todo]
      });
    totalTodo.add(newTodo);

    writeToFile(totalTodo);
    if (date == DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()) {
      selectedTodo.add(newTodo);

      yield state.update(
          todoList: totalTodo,
          selectedList: state.selectedList,
          id: "",
          events: updateEventSet);
    } else {
      selectedTodo = [];
      for (int i = 0; i < totalTodo.length; i++) {
        if (totalTodo[i].date ==
            DateFormat('yyyy-MM-dd').format(dateTime).toString()) {
          selectedTodo.add(totalTodo[i]);
        }
      }

      yield state.update(
        todoList: totalTodo,
        selectedList: selectedTodo,
        selectedDateStr: date,
        calendarDateTime: dateTime,
        events: updateEventSet,
      );
    }
  }

  Stream<TodoState> _mapTodoIdChangedToState(String id) async* {
    yield state.update(id: id);
  }

  Stream<TodoState> _mapCalendarDateChangedToState(DateTime time) async* {
    List<Todo> totalTodo = state.todoList;
    List<Todo> selectedDateTdo = [];
    String selectedDate = DateFormat('yyyy-MM-dd').format(time).toString();

    totalTodo.forEach((data) {
      if (data.date == selectedDate) {
        selectedDateTdo.add(data);
      }
    });

    yield state.update(
        calendarDateTime: time,
        selectedDateStr: selectedDate,
        selectedList: selectedDateTdo);
  }

  ///Tag Add Page 관련 부
  Stream<TodoState> _mapTagColorChangedToState(
      String id, Color color, String tagName) async* {
    List<Tag> tagList = state.tagList;
  }

  Stream<TodoState> _mapTagColorCompletedToState(
      String id, List<int> color, String tagName) async* {
    List<Color> colors = state.tagColors;
    colors.add(Color.fromARGB(color[3], color[0], color[1], color[2]));

    List<Tag> tagList = state.tagList ?? [];
    Tag newTag = Tag(id: id, color: color, tagName: tagName);

    tagList.add(newTag);
    tagWriteToFile(tagList);
    yield state.update(
      id: id,
      tagList: tagList,
      tagLastId: 0,
      tagColors: colors,
    );
  }

  ///태그 삭제 관련 부분
  Stream<TodoState> _mapTagDeletedToState(String id) async* {
    List<Todo> changedTodoList = [];
    List<Tag> changedTagList = [];
    List<Todo> changedSelectedList = [];

    changedTodoList.addAll(state.todoList);
    changedTagList.addAll(state.tagList);
    changedSelectedList.addAll(state.selectedList);

    for (int i = 0; i < changedTodoList.length; i++) {
      if (changedTodoList[i].id == id) {
//        print(
//            changedTodoList[i].id.toString() + " : " + changedTodoList[i].desc);
        changedTodoList.removeAt(i);
        i--;
      }
    }
    print("===============");
    print(changedTodoList);
    for (int i = 0; i < changedTagList.length; i++) {
      if (changedTagList[i].id == id) {
        changedTagList.removeAt(i);
        i--;
      }
    }

    for (int i = 0; i < changedSelectedList.length; i++) {
      if (changedSelectedList[i].id == id) {
        changedSelectedList.removeAt(i);
        i--;
      }
    }

    writeToFile(changedTodoList);
    tagWriteToFile(changedTagList);

    List<DateTime> eventDateTime = [];
    Map<DateTime, List> events = {};

    for (int i = 0; i < changedTodoList.length; i++) {
      if (!eventDateTime.contains(DateTime.parse(changedTodoList[i].date))) {
        eventDateTime.add(DateTime.parse(changedTodoList[i].date));
        events.addAll({DateTime.parse(changedTodoList[i].date): []});
        events[DateTime.parse(changedTodoList[i].date)]
            .add(changedTodoList[i].todo);
//            print(events[dateTime]);
      } else {
        events[DateTime.parse(changedTodoList[i].date)]
            .add(changedTodoList[i].todo);
//            print(events[dateTime]);
      }
    }

    yield state.update(
      selectedList: changedSelectedList,
      todoList: changedTodoList,
      tagList: changedTagList,
      events: events,
    );
  }

  ///todo list 전체 초기화
  Stream<TodoState> _mapTodoListClearToState() async* {
    tagJsonFile.deleteSync(recursive: true);
    jsonFile.deleteSync(recursive: true);

    List<Map<String, dynamic>> content = [
      {
        "id": "0",
        "todo": "",
        "date": "1700-01-01",
        "desc": "",
        "checked": false
      }
    ];

    List<Map<String, dynamic>> tag = [];

    createFile(content, dir, fileName);
    createFile(tag, tagDir, tagFileName);

    yield state.update(
      selectedList: [],
      todoList: [],
      tagColors: [],
      tagList: [],
      events: {},
    );
  }

  ///tag edit 완료시
  Stream<TodoState> _mapTagEditCompleteToState(
      String id, List<int> color, String tagName, int index) async* {
    List<Color> editTagColors = state.tagColors;
    List<Tag> editTagList = state.tagList;
    Tag editTag = Tag(id: id, color: color, tagName: tagName);

    editTagColors[index] =
        Color.fromARGB(color[3], color[0], color[1], color[2]);
    editTagList[index] = editTag;

    tagWriteToFile(editTagList);

    yield state.update(
      tagList: editTagList,
      tagColors: editTagColors,
    );
  }

  ///투두 수정 페이지
  Stream<TodoState> _mapTodoEditCompletePressedToState(
      DateTime preDateTime,
      String preTodo,
      String preDate,
      String preTodoId,
      String id,
      String todoId,
      String todo,
      String date,
      String desc,
      DateTime dateTime) async* {
    Todo newTodo = Todo(
        id: id,
        todoId: preTodoId,
        todo: todo,
        date: date,
        desc: desc,
        checked: false);

    List<Todo> totalTodo = state.todoList;
    List<Todo> selectedTodo = state.selectedList;
    Map<DateTime, List> updateEventSet = state.events;

    for (int i = 0; i < totalTodo.length; i++) {
      if (totalTodo[i].todoId == preTodoId) {
        totalTodo[i] = newTodo;
        break;
      }
    }

    for (int i = 0; i < selectedTodo.length; i++) {
      if (selectedTodo[i].todoId == preTodoId) {
        selectedTodo[i] = newTodo;
        break;
      }
    }
    updateEventSet[preDateTime].remove(preTodo);
    if (updateEventSet.keys.toList().contains(DateTime.parse(date))) {
      updateEventSet[dateTime].add(todo);
    } else
      updateEventSet.addAll({
        dateTime: [todo]
      });

    writeToFile(totalTodo);
    if (date == DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()) {
      yield state.update(
          todoList: totalTodo,
          selectedList: selectedTodo,
          id: "",
          events: updateEventSet);
    } else {
      selectedTodo = [];
      for (int i = 0; i < totalTodo.length; i++) {
        if (totalTodo[i].date ==
            DateFormat('yyyy-MM-dd').format(dateTime).toString()) {
          selectedTodo.add(totalTodo[i]);
        }
      }

      yield state.update(
        todoList: totalTodo,
        selectedList: selectedTodo,
        selectedDateStr: date,
        calendarDateTime: dateTime,
        events: updateEventSet,
        id: "",
        forEdit: false,
        addDone: true,
      );
    }
  }

  Stream<TodoState> _mapAddDoneToFalseToState() async* {
    state.update(addDone: false);
  }

  Stream<TodoState> _mapEditBtnPressedToState() async* {
    yield state.update(forEdit: true);
  }

  Stream<TodoState> _mapTodoDeleteToState(String todoId) async* {
    List<Todo> totalTodo = state.todoList;
    List<Todo> selectedTodo = state.selectedList;
    Map<DateTime, List> updateEventSet = state.events;
    String removeTodo;
    DateTime removeAtDateTime;

    for (int i = 0; i < totalTodo.length; i++) {
      if (totalTodo[i].todoId == todoId) {
        removeTodo = totalTodo[i].todo;
        removeAtDateTime = DateTime.parse(totalTodo[i].date);
        totalTodo.removeAt(i);
        break;
      }
    }

    for (int i = 0; i < selectedTodo.length; i++) {
      if (selectedTodo[i].todoId == todoId) {
        selectedTodo.removeAt(i);
        break;
      }
    }
    updateEventSet[removeAtDateTime].remove(removeTodo);
    writeToFile(totalTodo);

    yield state.update(
      todoList: totalTodo,
      selectedList: selectedTodo,
      events: updateEventSet,
      forEdit: false,
      addDone: true,
    );
  }

  ///파일 생성, 리드 관련 부분
  void createFile(
      List<Map<String, dynamic>> content, Directory dir, String fileName) {
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
    fileExists = true;
    tagFileExists = true;
    file.writeAsStringSync(json.encode(content));
  }

  void createFile2(List<Todo> content, Directory dir, String fileName) {
    List<Map<String, dynamic>> currentData = [];
    content.forEach((Todo data) {
      Map<String, dynamic> a = {
        "id": data.id,
        "todoId": data.todoId,
        "todo": data.todo,
        "date": data.date,
        "desc": data.desc,
        "checked": data.checked,
      };
      currentData.add(a);
    });
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(json.encode(currentData));
  }

  void tagCreateFile(List<Tag> content, Directory dir, String fileName) {
//    print("Creating file!");
    List<Map<String, dynamic>> currentData = [];
    content.forEach((Tag data) {
//      print(data.tagName);
      Map<String, dynamic> a = {
        "id": data.id,
        "color": data.color,
        "tagName": data.tagName,
      };
      currentData.add(a);
    });
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(json.encode(currentData));
//    print("asdfasdfa");
  }

  Future<void> writeToFile(List<Todo> list) async {
//    print("Writing to file!");
    if (jsonFile.existsSync()) {
      jsonFile.deleteSync(recursive: true);
      createFile2(list, dir, fileName);
    } else {
//      print("File does not exist!");
      createFile([], dir, fileName);
    }
  }

  Future<void> tagWriteToFile(List<Tag> list) async {
//    print("Writing to file!");
    if (tagJsonFile.existsSync()) {
      tagJsonFile.deleteSync(recursive: true);
      tagCreateFile(list, tagDir, tagFileName);
    } else {
//      print("File does not exist!");
      createFile([], tagDir, tagFileName);
    }
  }
}
