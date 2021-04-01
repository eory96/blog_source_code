import 'package:flutter/material.dart';
import 'package:flutter_app_todo/pages/todo_add.dart';
import 'package:flutter_app_todo/pages/todo_list.dart';
import 'package:flutter_app_todo/splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authenticationBloc/bloc.dart';
import 'blocs/todoBloc/bloc.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  // ignore: close_sinks
  final AuthenticationBloc _authenticationBloc = AuthenticationBloc();
  final TodoBloc _todoBloc = TodoBloc();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) => _authenticationBloc,
        ),
        BlocProvider<TodoBloc>(
          create: (BuildContext context) => _todoBloc,
        ),
      ],
      child: MaterialApp(
          title: 'Todo',
          theme: ThemeData(
              textTheme: TextTheme(
                  display1: TextStyle(
                fontSize: 20,
                letterSpacing: -0.015,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(51, 51, 51, 1),
              )),
              primaryColor: Color(0xFFF8F8F8),
              backgroundColor: Color(0xFFF8F8F8),
              scaffoldBackgroundColor: Color(0xFFF8F8F8),
              accentColor: Color(0xFF1E8E89)),
          home: BlocBuilder(
            bloc: _todoBloc,
            builder: (BuildContext context, TodoState state) {
              if (state.loadDone == true)
                return TodoList();
              else
                return SplashScreen();
            },
          ),
          routes: {
            "/todoList": (BuildContext context) => TodoList(),
            "/todoAdd": (BuildContext context) => TodoAdd(),
            "/splash": (BuildContext context) => SplashScreen(),
          },
          debugShowCheckedModeBanner: false),
    );
  }
}
