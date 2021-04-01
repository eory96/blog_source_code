import 'package:flutter/material.dart';
import 'package:flutter_app_bloc_api/bloc/weather_bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherPage extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocListener<WeatherBloc, WeatherState>(
        listener: (BuildContext context, WeatherState state) {},
        child: Scaffold(
          appBar: AppBar(
            title: Text('Weather'),
          ),
          body: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (BuildContext context, WeatherState state) {
              if (state.loadDone == false) {
                return Column(
                  children: <Widget>[
                    searchCity(context, state),
                    Center(child: CircularProgressIndicator()),
                  ],
                );
              } else {
                return Column(
                  children: <Widget>[
                    searchCity(context, state),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('현재 온도 : ${state.weather.temp.toString()}'),
                          Text('최저 온도 : ${state.weather.tempMin.toString()}'),
                          Text('최고 온도 : ${state.weather.tempMax.toString()}'),
                          //아이콘의 경우 적절한것이 기본적으로 제공이 되지 않고 있다. 제대로된 앱을 위해서는 적절한 이미지를 삽입하는것이 옳은것 같다.
                          state.weather.code == 800
                              ? Icon(Icons.wb_sunny)
                              : state.weather.code / 100 == 8 ||
                                      state.weather.code / 100 == 2
                                  ? Icon(Icons.wb_cloudy)
                                  : state.weather.code / 100 == 3 ||
                                          state.weather.code / 100 == 5
                                      ? Icon(Icons.beach_access)
                                      : state.weather.code / 100 == 6
                                          ? Icon(Icons.ac_unit)
                                          : Icon(Icons.cloud_circle)
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ));
  }

  Widget searchCity(BuildContext context, WeatherState state) {
    return Row(
      children: <Widget>[
        Icon(Icons.search),
        Expanded(
          child: TextField(
            controller: searchController,
            onSubmitted: (String txt) {
              context.bloc<WeatherBloc>().add(WeatherSearch(city: txt));
            },
          ),
        )
      ],
    );
  }
}
