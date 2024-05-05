import 'package:equatable/equatable.dart';
import 'package:products/core/utilities/enums.dart';

abstract class AuthState{}

class InitialAuthState extends Equatable implements AuthState{
  @override
  List<Object?> get props => [];
}

// ############### Start Login State // ###############
class LoginState extends Equatable implements AuthState{
  final ResponseAuthStatus status;
  final String message;
  const LoginState({required this.status, required this.message});

  @override
  List<Object?> get props => [status, message];
}
// ############### End Login State // ###############


// ############### Start Register State // ###############
class RegisterState extends Equatable implements AuthState{
  final ResponseAuthStatus status;
  final String message;
  const RegisterState({required this.status, required this.message});

  @override
  List<Object?> get props => [status, message];
// ############### End Login State // ###############

}

