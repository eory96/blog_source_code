import 'package:flutter/material.dart';
import 'package:flutter_app_bloc_api/bloc/weather_bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'weather_page.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<WeatherApp> {
  final WeatherBloc _weatherBloc = WeatherBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _weatherBloc.add(WeatherLoaded());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _weatherBloc,
      child: MaterialApp(
        title: 'Weather',
        theme: ThemeData(),
        home: BlocBuilder(
          bloc: _weatherBloc,
          builder: (BuildContext context, WeatherState state) {
            return WeatherPage();
          },
        ),
      ),
    );
  }
}
