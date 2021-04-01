import 'dart:async';

import 'package:bloc/bloc.dart';

import 'bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  @override
  AuthenticationState get initialState => AuthenticationState.empty();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarting) {
      yield* _mapAppStartingToState();
    }
  }

  // 앱 실행 시 자동로그인 처리
  Stream<AuthenticationState> _mapAppStartingToState() async* {}
}
