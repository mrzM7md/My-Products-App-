import 'package:equatable/equatable.dart';
import 'package:products/authentication/domain/entities/auth_response.dart';
import 'package:products/authentication/domain/repository/base_auth_repository.dart';
import 'package:products/core/network/usecases/base_usecase.dart';

import '../entities/auth.dart';

class RegisterNewAccountUseCase implements BaseUseCase<AuthResponse, RegisterParameters> {
  BaseAuthRepository baseAuthRepository;
  RegisterNewAccountUseCase({required this.baseAuthRepository});

  @override
  Future<AuthResponse> call({required RegisterParameters parameters}) async {
    return await baseAuthRepository.registerNewAccount(auth: parameters.auth);
  }
}

class RegisterParameters extends Equatable {
  final Auth auth;

  const RegisterParameters({required this.auth});

  @override
  List<Object?> get props => [auth];

}