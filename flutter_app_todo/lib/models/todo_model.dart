import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Todo extends Equatable {
  final String id;
  final String todoId;
  final String todo;
  final String date;
  final String desc;
  bool checked;

  Todo({
    @required this.id,
    @required this.todoId,
    @required this.todo,
    @required this.date,
    @required this.desc,
    @required this.checked,
  });

  factory Todo.fromJson(Map<String, dynamic> data) {
    return Todo(
      id: data['id'],
      todoId: data['todoId'],
      todo: data['todo'],
      date: data['date'],
      desc: data['desc'],
      checked: data['checked'],
    );
  }

  Map<String, dynamic> toJson(String id, String todoId, String todo,
      String date, String desc, bool checked) {
    Map<String, dynamic> a = {
      'id': id,
      'todoId': todoId,
      'todo': todo,
      'date': date,
      'desc': desc,
      'checked': checked,
    };
    return a;
  }
}
