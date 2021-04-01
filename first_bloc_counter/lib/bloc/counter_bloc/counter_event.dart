import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CounterEvent extends Equatable {
  CounterEvent([List props = const []]) : super(props);
}

class IncrementBtnPressed extends CounterEvent {
  @override
  String toString() {
    return 'DailyAcntPressed';
  }
}

class DecrementBtnPressed extends CounterEvent {
  @override
  String toString() {
    return 'DailyAcntPressed';
  }
}
