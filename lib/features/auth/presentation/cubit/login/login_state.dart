import '../../../data/models/user_model.dart';

abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  final String message;
  final UserModel user;

  const LoginSuccess({
    required this.message,
    required this.user,
  });
}

class LoginFailure extends LoginState {
  final String message;

  const LoginFailure(this.message);
}