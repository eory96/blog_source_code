import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_app_bloc_api/model/weather_model.dart';
import 'package:http/http.dart' as http;

import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  @override
  // TODO: implement initialState
  WeatherState get initialState => WeatherState.empty();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherLoaded) {
      yield* _mapWeatherLoadedToState(event.weather);
    } else if (event is WeatherChanged) {
      yield* _mapWeatherChangedToState(event.city);
    } else if (event is WeatherSearch) {
      yield* _mapWeatherSearchToState(event.city);
    }
  }

  Stream<WeatherState> _mapWeatherLoadedToState(Weather weather) async* {
    String apiAddress =
        "https://api.openweathermap.org/data/2.5/weather?q=daegu&appid=fc61bef11fb886fb7b1dfdc01728610a&units=metric";
    http.Response response;
    var data;
    Weather weather;

    try {
      response = await http.get(apiAddress);
      data = json.decode(response.body);

      weather = Weather(
          temp: data["main"]["temp"].toDouble(),
          tempMax: data["main"]["temp_max"].toDouble(),
          tempMin: data["main"]["temp_min"].toDouble(),
          weatherMain: data["weather"][0][
              "main"], //weather부분의 경우 리스트로 json에 들어가고 있기 때문에 첫번째것을 쓴다고 표시를 해준다.
          code: data["weather"][0]
              ["id"]); //weather부분의 경우 리스트로 json에 들어가고 있기 때문에 첫번째것을 쓴다고 표시를 해준다
      yield state.update(loadDone: true, weather: weather);
    } catch (e) {
      print(e);
      yield state.update(loadDone: false, weather: weather);
    }
  }

  Stream<WeatherState> _mapWeatherChangedToState(String city) async* {
    yield state.update(city: city);
  }

  Stream<WeatherState> _mapWeatherSearchToState(String city) async* {
    String apiAddress =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=fc61bef11fb886fb7b1dfdc01728610a&units=metric";
    http.Response response;
    var data;
    Weather weather;

    try {
      response = await http.get(apiAddress);
      data = json.decode(response.body);

      weather = Weather(
          temp: data["main"]["temp"].toDouble(),
          tempMax: data["main"]["temp_max"].toDouble(),
          tempMin: data["main"]["temp_min"].toDouble(),
          weatherMain: data["weather"][0][
              "main"], //weather부분의 경우 리스트로 json에 들어가고 있기 때문에 첫번째것을 쓴다고 표시를 해준다.
          code: data["weather"][0]
              ["id"]); //weather부분의 경우 리스트로 json에 들어가고 있기 때문에 첫번째것을 쓴다고 표시를 해준다
      yield state.update(loadDone: true, weather: weather);
    } catch (e) {
      print(e);
      yield state.update(loadDone: false, weather: weather);
    }
  }
}
