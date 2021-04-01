import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final double temp; //현재 온도
  final double tempMin; //최저 온도
  final double tempMax; //최고 온도
  final String weatherMain; //흐림정도
  final int code; //흐림정도의 id(icon 작업시 필요)

  const Weather({
    this.temp,
    this.tempMin,
    this.tempMax,
    this.weatherMain,
    this.code,
  });

  @override
  // TODO: implement props
  List<Object> get props => [temp, tempMin, tempMax, weatherMain, code];
}
