import 'package:app_flutter/models/dto/login_dto.dart';
import 'package:app_flutter/models/response/login_response.dart';
import 'package:app_flutter/repositories/auth/auth_repositori.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(LoginInitial()) {
    on<DoLoginEvent>(_doLogin);
  }

  void _doLogin(DoLoginEvent event, Emitter<LoginState> emit) async {
    emit(DoLoginLoadin());

    try {
      final LoginDto loginDto =
          LoginDto(username: event.username, password: event.password);
      final reponse = await authRepository.login(loginDto);
      emit(DoLoginSuccess(reponse));
      return;
    } on Exception catch (e) {
      emit(DoLoginError(e.toString()));
    }
  }
}
