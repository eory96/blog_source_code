import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_todo/models/todo_model.dart';

@immutable
abstract class TodoListEvent extends Equatable {
  TodoListEvent([List props = const []]) : super(props);
}

class TodoPageLoaded extends TodoListEvent {
  @override
  String toString() {
    // TODO: implement toString
    return "TodoPageLoaded";
  }
}

class TodoListCheck extends TodoListEvent {
  final int index;
  final Todo todo;

  TodoListCheck({@required this.index, @required this.todo});

  @override
  String toString() {
    // TODO: implement toString
    return "TodoListCheck";
  }
}

class AddPopPressed extends TodoListEvent {
  @override
  String toString() {
    return "AddPopPressed";
  }
}

class AddDateChanged extends TodoListEvent {
  final String date;

  AddDateChanged({@required this.date});
  @override
  String toString() {
    return "AddDateChanged {date : $date}";
  }
}

class TodoAddPressed extends TodoListEvent {
  final String id;
  final String todoId;
  final String todo;
  final String date;
  final String desc;
  final DateTime dateTime;

  TodoAddPressed({
    @required this.id,
    @required this.todoId,
    @required this.todo,
    @required this.date,
    @required this.desc,
    @required this.dateTime,
  });

  @override
  String toString() {
    // TODO: implement toString
    return "TodoListCheck {id : $id, todo : $todo, datd : $date, desc : $desc}";
  }
}

class TodoIdChanged extends TodoListEvent {
  final String id;

  TodoIdChanged({
    @required this.id,
  });

  @override
  String toString() {
    // TODO: implement toString
    return "TodoIdChanged {id : $id}";
  }
}

class CalendarDateChanged extends TodoListEvent {
  final DateTime dateTime;

  CalendarDateChanged({
    @required this.dateTime,
  });

  @override
  String toString() {
    // TODO: implement toString
    return "CalendarDateChanged {dateTime : $dateTime}";
  }
}

class TagColorChanged extends TodoListEvent {
  final String id;
  final Color color;
  final String tagName;

  TagColorChanged({
    @required this.id,
    @required this.color,
    @required this.tagName,
  });

  @override
  String toString() {
    // TODO: implement toString
    return "TagColorChanged {id : $id, color : $color, tagName : $tagName}";
  }
}

class TagColorCompleted extends TodoListEvent {
  final String id;
  final List<int> color;
  final String tagName;

  TagColorCompleted(
      {@required this.id, @required this.color, @required this.tagName});

  @override
  String toString() {
    // TODO: implement toString
    return "TagColorCompleted";
  }
}

///tag Delete분 부
class TagDeleted extends TodoListEvent {
  final String id;

  TagDeleted({@required this.id});

  @override
  String toString() {
    return "TagDeleted";
  }
}

class TagDeleteDone extends TodoListEvent {
  @override
  String toString() {
    // TODO: implement toString
    return "TagDeleteDone";
  }
}

class TagPagePop extends TodoListEvent {
  @override
  String toString() {
    // TODO: implement toString
    return "TagPagePop";
  }
}

///tag clear 부분(초기화)
class TodoListClear extends TodoListEvent {
  String toString() {
    // TODO: implement toString
    return "TodoListClear";
  }
}

///tag edit 부분
class TagEditComplete extends TodoListEvent {
  final String id;
  final List<int> color;
  final String tagName;
  final int index;

  TagEditComplete(
      {@required this.id,
      @required this.color,
      @required this.tagName,
      @required this.index});

  @override
  String toString() {
    // TODO: implement toString
    return "TagEditComplete";
  }
}

///투두 수정 부분
class TodoEditCompletePressed extends TodoListEvent {
  final DateTime preDateTime;
  final String preTodo;
  final String preDate;
  final String id;
  final String todoId;
  final String todo;
  final String date;
  final String desc;
  final DateTime dateTime;
  final String preTodoId;

  TodoEditCompletePressed({
    @required this.preDateTime,
    @required this.preTodo,
    @required this.preDate,
    @required this.id,
    @required this.todoId,
    @required this.todo,
    @required this.date,
    @required this.desc,
    @required this.dateTime,
    @required this.preTodoId,
  });

  @override
  String toString() {
    // TODO: implement toString
    return "TodoEditCompletePressed {id : $id, todo : $todo, datd : $date, desc : $desc}";
  }
}

class EditBtnPressed extends TodoListEvent {
  @override
  String toString() {
    // TODO: implement toString
    return "EditBtnPressed";
  }
}

class AddDoneToFalse extends TodoListEvent {
  @override
  String toString() {
    // TODO: implement toString
    return "AddDoneToFalse";
  }
}

class TodoDelete extends TodoListEvent {
  final todoId;
  TodoDelete({@required this.todoId});
}
