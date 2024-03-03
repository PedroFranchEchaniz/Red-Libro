import 'package:app_flutter/models/response/registed_user_response.dart';
import 'package:app_flutter/repositories/userRegisted/user_registed_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'loges_user_event.dart';
part 'loges_user_state.dart';

class LogesUserBloc extends Bloc<LogesUserEvent, LogesUserState> {
  final RegistedUserRepository userRepo;

  LogesUserBloc({required this.userRepo}) : super(LogesUserInitial()) {
    on<FetchUser>((event, emit) async {
      emit(UsearLoading());
      try {
        final user = await userRepo.getRegistedUser();
        emit(UserLoaded(user));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
