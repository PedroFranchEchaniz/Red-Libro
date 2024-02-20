import 'package:app_flutter/models/dto/register_dto.dart';
import 'package:app_flutter/models/response/register_response.dart';

abstract class RegisterRepository {
  Future<RegisterResponse> register(RegisterDto registerDto);
}
