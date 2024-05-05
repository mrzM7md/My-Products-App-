import 'package:products/authentication/domain/entities/auth.dart';
import 'package:products/authentication/domain/entities/auth_response.dart';

abstract class BaseAuthRepository {
  Future<AuthResponse> registerNewAccount({required Auth auth});
  Future<AuthResponse> login({required Auth auth});
}