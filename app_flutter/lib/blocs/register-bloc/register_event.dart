part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class DoRegisterEvent extends RegisterEvent {
  final String username;
  final String password;
  final String verifypassword;
  final String lastname;
  final String name;
  DoRegisterEvent(this.username, this.password, this.verifypassword,
      this.lastname, this.name);
}
