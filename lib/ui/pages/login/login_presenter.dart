abstract class LoginPresenter {
  Stream<String> get emailErrorStream;
  Stream<String> get passowordErrorStream;
  Stream<bool> get isFormErrorStream;

  void validateEmail(String email);
  void validatePassword(String password);
  void auth() {}
}
