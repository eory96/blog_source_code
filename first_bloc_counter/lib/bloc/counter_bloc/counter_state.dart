import 'package:meta/meta.dart';

@immutable
class CounterState {
  final int count;

  CounterState({@required this.count});

  factory CounterState.empty() {
    return CounterState(count: 0);
  }

  CounterState update({
    int count,
  }) {
    return copyWith(count: count);
  }

  CounterState copyWith({
    int count,
  }) {
    return CounterState(count: count ?? this.count);
  }

  @override
  String toString() {
    return ''' 
      count is $count,
    ''';
  }
}
