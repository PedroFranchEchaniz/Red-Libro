import 'package:app_flutter/models/dto/register_dto.dart';
import 'package:app_flutter/models/response/register_response.dart';
import 'package:app_flutter/repositories/register/register_repositori.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository registerRepository;

  RegisterBloc(this.registerRepository) : super(RegisterInitial()) {
    on<DoRegisterEvent>(_doRegister);
  }

  Future<void> _doRegister(
      DoRegisterEvent event, Emitter<RegisterState> emit) async {
    emit(DoRegisterLoading());

    try {
      final RegisterDto registerDto = RegisterDto(
          username: event.username,
          password: event.password,
          verifyPassword: event.verifypassword,
          name: event.name,
          lastName: event.lastname);
      final response = await registerRepository.register(registerDto);
      emit(DoRegisterSucces(response));
    } on Exception catch (e) {
      emit(DoRegisterError(e.toString()));
    }
  }
}
