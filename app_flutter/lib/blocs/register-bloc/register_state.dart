part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class DoRegisterLoading extends RegisterState {}

final class DoRegisterSucces extends RegisterState {
  final RegisterResponse userRegister;
  DoRegisterSucces(this.userRegister);
}

final class DoRegisterError extends RegisterState {
  final String errorMessage;
  DoRegisterError(this.errorMessage);
}
