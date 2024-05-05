import 'package:equatable/equatable.dart';
import 'package:products/authentication/domain/entities/auth_response.dart';
import 'package:products/authentication/domain/repository/base_auth_repository.dart';
import 'package:products/core/network/usecases/base_usecase.dart';

import '../entities/auth.dart';

class LoginUseCase implements BaseUseCase<AuthResponse, LoginParameters> {
  BaseAuthRepository baseAuthRepository;
  LoginUseCase({required this.baseAuthRepository});

  @override
  Future<AuthResponse> call({required LoginParameters parameters}) async {
    return await baseAuthRepository.login(auth: parameters.auth);
  }
}

class LoginParameters extends Equatable {
  final Auth auth;
  const LoginParameters({required this.auth});

  @override
  List<Object?> get props => [auth];

}