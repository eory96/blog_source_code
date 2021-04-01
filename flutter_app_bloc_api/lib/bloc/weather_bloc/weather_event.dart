import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_bloc_api/model/weather_model.dart';

class WeatherEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class WeatherLoaded extends WeatherEvent {
  final Weather weather;

  WeatherLoaded({@required this.weather});

  @override
  String toString() {
    // TODO: implement toString
    return "Weather Loaded";
  }
}

class WeatherChanged extends WeatherEvent {
  final String city;

  WeatherChanged({@required this.city});

  @override
  String toString() {
    // TODO: implement toString
    return "city changed";
  }
}

class WeatherSearch extends WeatherEvent {
  final String city;

  WeatherSearch({@required this.city});

  @override
  String toString() {
    // TODO: implement toString
    return "city changed";
  }
}
