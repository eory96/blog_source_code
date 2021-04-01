import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_todo/blocs/todoBloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/todoBloc/todo_bloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  TodoBloc _todoBloc;

  @override
  void initState() {
    super.initState();
    _todoBloc = BlocProvider.of(context);

    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                Color(0xFF4F588F),
                Color(0xff747DAD),
                Color(0xffA6B2E1),
                Color(0xffDDD7F8),
                Color(0xffE7D9FE),
                Color(0xffECD0E1),
                Color(0xffEAD9C7)
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.0, 1.0),
              stops: [0.0, 0.24, 0.44, 0.56, 0.74, 0.84, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: 1,
            ),
            Column(
              children: <Widget>[
                Image.asset(
                  'assets/top.png',
                  width: MediaQuery.of(context).size.width * 0.45,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                )
              ],
            ),
            Column(
              children: <Widget>[
                Image.asset(
                  'assets/bottom.png',
                  width: MediaQuery.of(context).size.width * 0.30,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<Timer> startTime() async {
    var _duration = new Duration(seconds: 2);
    return Timer(_duration, () => _todoBloc.add(TodoPageLoaded()));
  }
}
