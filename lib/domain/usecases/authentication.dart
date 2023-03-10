import 'package:equatable/equatable.dart';

import '../../domain/entities/account_entity.dart';

abstract class Authentication {
  Future<AccountEntity>? auth(AuthenticationParams params);
}

class AuthenticationParams extends Equatable {
  final String email;
  final String secret;

  @override
  List<Object> get props => [email, secret];

  const AuthenticationParams({required this.email, required this.secret});
}
