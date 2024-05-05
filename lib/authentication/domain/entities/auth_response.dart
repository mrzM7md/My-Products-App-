import 'package:equatable/equatable.dart';
import 'package:products/authentication/domain/entities/auth.dart';
import 'package:products/core/utilities/enums.dart';

import '../../../core/network/entities/api_responses.dart';

class AuthResponse extends Equatable implements MainResponse {
  @override
  final ResponseAuthStatus statue;

  @override
  final String message;

  final Auth? data;

  const AuthResponse({required this.statue, required this.message, this.data});

  @override
  List<Object?> get props => [statue, message, data];
}
