import 'package:bloc/bloc.dart';

import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  @override
  // TODO: implement initialState
  CounterState get initialState => CounterState.empty();

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    if (event is IncrementBtnPressed) {
      yield* _mapIncrementBtnPressedToState();
    } else if (event is DecrementBtnPressed) {
      yield* _mapDecrementBtnPressedToState();
    }
  }

  Stream<CounterState> _mapIncrementBtnPressedToState() async* {
    int i = state.count;
    i++;
    print(i);
    yield state.update(count: i);
  }

  Stream<CounterState> _mapDecrementBtnPressedToState() async* {
    int i = state.count;
    i--;
    yield state.update(count: i);
  }
}
