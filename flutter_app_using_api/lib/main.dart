import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'weather_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Weather Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Weather> getWeather() async {
    String apiAddr =
        "https://api.openweathermap.org/data/2.5/weather?q=seoul&appid=fc61bef11fb886fb7b1dfdc01728610a&units=metric";
    http.Response response;
    var data1;
    Weather weather;
    try {
      response = await http.get(apiAddr);
      data1 = json.decode(response.body);
      weather = Weather(
          temp: data1["main"]["temp"],
          tempMax: data1["main"]["temp_max"],
          tempMin: data1["main"]["temp_min"],
          weatherMain: data1["weather"][0]["main"],
          code: data1["weather"][0]["id"]);
      print(weather.tempMin);
    } catch (e) {
      print(e);
    }

    return weather;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: FutureBuilder(
              future: getWeather(),
              builder: (context, AsyncSnapshot<Weather> snapshot) {
                if (snapshot.hasData == false) {
                  return CircularProgressIndicator();
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('현재 온도 : ${snapshot.data.temp.toString()}'),
                    Text('최저 온도 : ${snapshot.data.tempMin.toString()}'),
                    Text('최고 온도 : ${snapshot.data.tempMax.toString()}'),
                    snapshot.data.code == 800
                        ? Icon(Icons.wb_sunny)
                        : snapshot.data.code / 100 == 8 ||
                                snapshot.data.code / 100 == 2
                            ? Icon(Icons.wb_cloudy)
                            : snapshot.data.code / 100 == 3 ||
                                    snapshot.data.code / 100 == 5
                                ? Icon(Icons.beach_access)
                                : snapshot.data.code / 100 == 6
                                    ? Icon(Icons.ac_unit)
                                    : Icon(Icons.cloud_circle)
                  ],
                );
//                    Text(snapshot.data.tempMax.toString());
              })),
    );
  }
}
