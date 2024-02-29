import 'package:app_flutter/models/dto/login_dto.dart';
import 'package:app_flutter/models/response/login_response.dart';

abstract class AuthRepository {
  Future<LogiResponse> login(LoginDto loginDto);
}
