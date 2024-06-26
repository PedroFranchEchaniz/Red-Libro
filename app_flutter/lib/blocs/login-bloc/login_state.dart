part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class DoLoginLoadin extends LoginState {}

final class DoLoginSuccess extends LoginState {
  final LogiResponse userLogin;
  DoLoginSuccess(this.userLogin);
}

final class DoLoginError extends LoginState {
  final String errorMessage;
  DoLoginError(this.errorMessage);
}
