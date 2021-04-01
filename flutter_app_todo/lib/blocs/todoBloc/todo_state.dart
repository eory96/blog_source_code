import 'dart:ui';

import 'package:flutter_app_todo/models/tag_model.dart';
import 'package:flutter_app_todo/models/todo_model.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class TodoState {
  final List<Todo> todoList;
  final String id;
  final String date;
  final bool loadDone;
  final bool addDone;

  ///선택된 날의 data만 받아오는 List;
  final DateTime calendarDateTime;
  final List<Todo> selectedList;
  final String selectedDateStr;

  ///caledar event 있는거 표시하기 위한 리스트
  final Map<DateTime, List> events;

  ///calendar tag 색깔 선정하기
  final List<Color> tagColors;
  final List<Tag> tagList;
  final int tagLastId;

  ///notification judge
  final bool notification;

  ///투두 수정!
  final bool forEdit;

  TodoState({
    @required this.todoList,
    @required this.id,
    @required this.date,
    @required this.loadDone,
    @required this.addDone,

    ///선택된 날의 data만 받아오는 List;
    @required this.calendarDateTime,
    @required this.selectedList,
    @required this.selectedDateStr,

    ///caledar event 있는거 표시하기 위한 리스트
    @required this.events,

    ///calendar tag 색깔 선정하기
    @required this.tagColors,
    @required this.tagList,
    @required this.tagLastId,

    ///notification judge
    @required this.notification,

    ///투두 수정!
    @required this.forEdit,
  });

  factory TodoState.empty() {
    return TodoState(
      todoList: [],
      id: "",
      date: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
      loadDone: false,
      addDone: false,

      ///선택된 날의 data만 받아오는 List;
      calendarDateTime: DateTime.now(),
      selectedList: [],
      selectedDateStr:
          DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),

      ///caledar event 있는거 표시하기 위한 리스트
      events: {},

      ///calendar tag 색깔 선정하기
      tagColors: [],
      tagList: [],
      tagLastId: 0,

      ///notification judge
      notification: false,

      ///투두수정
      forEdit: false,
    );
  }

  TodoState update({
    List<Todo> todoList,
    String id,
    String date,
    bool loadDone,
    bool addDone,

    ///선택된 날의 data만 받아오는 List;
    DateTime calendarDateTime,
    List<Todo> selectedList,
    String selectedDateStr,

    ///caledar event 있는거 표시하기 위한 리스트
    Map<DateTime, List> events,

    ///calendar tag 색깔 선정하기
    List<Color> tagColors,
    List<Tag> tagList,
    int tagLastId,

    ///notification judge
    bool notification,

    ///투두 수정
    bool forEdit,
  }) {
    return copyWith(
      todoList: todoList,
      id: id,
      date: date,
      loadDone: loadDone,
      addDone: addDone,

      ///선택된 날의 data만 받아오는 List;
      calendarDateTime: calendarDateTime,
      selectedList: selectedList,
      selectedDateStr: selectedDateStr,

      ///caledar event 있는거 표시하기 위한 리스트
      events: events,

      ///calendar tag 색깔 선정하기
      tagColors: tagColors,
      tagList: tagList,
      tagLastId: tagLastId,

      ///notification judge
      notification: notification,

      ///투두수정
      forEdit: forEdit,
    );
  }

  TodoState copyWith({
    List<Todo> todoList,
    String id,
    String date,
    bool loadDone,
    bool addDone,

    ///선택된 날의 data만 받아오는 List;
    DateTime calendarDateTime,
    List<Todo> selectedList,
    String selectedDateStr,

    ///caledar event 있는거 표시하기 위한 리스트
    Map<DateTime, List> events,

    ///calendar tag 색깔 선정하기
    List<Color> tagColors,
    List<Tag> tagList,
    int tagLastId,

    ///notification judge
    bool notification,

    ///투두 수정
    bool forEdit,
  }) {
    return TodoState(
      todoList: todoList ?? this.todoList,
      id: id ?? this.id,
      date: date ?? this.date,
      loadDone: loadDone ?? this.loadDone,
      addDone: addDone ?? this.addDone,

      ///선택된 날의 data만 받아오는 List;
      calendarDateTime: calendarDateTime ?? this.calendarDateTime,
      selectedList: selectedList ?? this.selectedList,
      selectedDateStr: selectedDateStr ?? this.selectedDateStr,

      ///caledar event 있는거 표시하기 위한 리스트
      events: events ?? this.events,

      ///calendar tag 색깔 선정하기
      tagColors: tagColors ?? this.tagColors,
      tagList: tagList ?? this.tagList,
      tagLastId: tagLastId ?? this.tagLastId,

      ///notification judge
      notification: notification ?? this.notification,

      ///투두수정
      forEdit: forEdit ?? this.forEdit,
    );
  }
}
