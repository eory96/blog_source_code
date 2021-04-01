import 'package:flutter/cupertino.dart';
import 'package:flutter_app_bloc_api/model/weather_model.dart';

class WeatherState {
  final bool loadDone;
  final Weather weather;
  final String city;

  WeatherState({
    @required this.loadDone,
    @required this.weather,
    @required this.city,
  });

  factory WeatherState.empty() {
    return WeatherState(
      loadDone: false,
      weather:
          Weather(temp: 0, tempMax: 0, tempMin: 0, weatherMain: "", code: 0),
      city: "",
    );
  }

  WeatherState update({
    bool loadDone,
    Weather weather,
    String city,
  }) {
    return copyWith(
      loadDone: loadDone,
      weather: weather,
      city: city,
    );
  }

  WeatherState copyWith({
    bool loadDone,
    Weather weather,
    String city,
  }) {
    return WeatherState(
      loadDone: loadDone ?? this.loadDone,
      weather: weather ?? this.weather,
      city: city ?? this.city,
    );
  }
}
