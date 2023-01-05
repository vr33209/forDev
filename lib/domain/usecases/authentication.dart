import '../../domain/entities/account_entity.dart';

abstract class Authentication {
  Future<AccountEntity> auth(AuthenticationParams params);
}

class AuthenticationParams {
  final String email;
  final String secret;

  Map toJson() => {'email': email, 'password': secret};

  AuthenticationParams({required this.email, required this.secret});
}
