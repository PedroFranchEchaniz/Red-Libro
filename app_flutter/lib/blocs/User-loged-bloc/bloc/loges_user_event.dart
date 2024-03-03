part of 'loges_user_bloc.dart';

@immutable
sealed class LogesUserEvent {}

class FetchUser extends LogesUserEvent {}
