part of 'loges_user_bloc.dart';

@immutable
sealed class LogesUserState {}

final class LogesUserInitial extends LogesUserState {}

class UsearLoading extends LogesUserState {}

class UserLoaded extends LogesUserState {
  final RegistedUserResponse user;
  UserLoaded(this.user);
}

class UserError extends LogesUserState {
  final String message;
  UserError(this.message);
}
