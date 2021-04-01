import 'package:meta/meta.dart';

@immutable
class AuthenticationState {
  final bool started;
  final bool isInitialized;
  final String id;
  final String pw;
  final String name;
  final bool authenticated;
  final bool moveToLoginPage;
  final bool isSubmitting;

  AuthenticationState(
      {@required this.started,
      @required this.isInitialized,
      @required this.id,
      @required this.pw,
      @required this.name,
      @required this.authenticated,
      @required this.moveToLoginPage,
      @required this.isSubmitting});

  factory AuthenticationState.empty() {
    return AuthenticationState(
        started: false,
        isInitialized: false,
        id: "",
        pw: "",
        name: "",
        authenticated: false,
        moveToLoginPage: false,
        isSubmitting: false);
  }

  AuthenticationState update(
      {bool started,
      bool isInitialized,
      String id,
      String pw,
      String name,
      bool authenticated,
      bool moveToLoginPage,
      bool isSubmitting}) {
    return copyWith(
        started: started,
        isInitialized: isInitialized,
        id: id,
        pw: pw,
        name: name,
        authenticated: authenticated,
        moveToLoginPage: moveToLoginPage,
        isSubmitting: isSubmitting);
  }

  AuthenticationState copyWith(
      {bool started,
      bool isInitialized,
      String id,
      String pw,
      String name,
      bool authenticated,
      bool moveToLoginPage,
      bool isSubmitting}) {
    return AuthenticationState(
        started: started ?? this.started,
        isInitialized: isInitialized ?? this.isInitialized,
        id: id ?? this.id,
        pw: pw ?? this.pw,
        name: name ?? this.name,
        authenticated: authenticated ?? this.authenticated,
        moveToLoginPage: moveToLoginPage ?? this.moveToLoginPage,
        isSubmitting: isSubmitting ?? this.isSubmitting);
  }

  @override
  String toString() {
    return '''AuthenticationState {
      started: $started,
      isInitialized: $isInitialized,
      authenticated: $authenticated,
      moveToLoginPage: $moveToLoginPage,
      isSubmitting: $isSubmitting,
    }''';
  }
}
