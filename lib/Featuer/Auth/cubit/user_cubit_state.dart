part of 'user_cubit_cubit.dart';

@immutable
sealed class UserCubitState {}

final class UserInitial extends UserCubitState {}

final class SignUpSuccess extends UserCubitState {
  final String message;

  SignUpSuccess(this.message);
}

final class SignUpLoading extends UserCubitState {}

final class SignUpFailure extends UserCubitState {
  final String errorMessage;

  SignUpFailure({required this.errorMessage});
}

final class SignInFailure extends UserCubitState {
  final String errorMessage;

  SignInFailure({required this.errorMessage});
}

final class SignInSuccess extends UserCubitState {
  final LoginResponse loginResponse;
  final String message;
  final String accessToken;
  final int userId;

  SignInSuccess(
      this.loginResponse, this.message, this.accessToken, this.userId);
}

final class SignInLoading extends UserCubitState {}

class LogoutLoading extends UserCubitState {}

class LogoutSuccess extends UserCubitState {
  final String message;
  LogoutSuccess({required this.message});
}

class LogoutFailure extends UserCubitState {
  final String errorMessage;
  LogoutFailure({required this.errorMessage});
}

final class ForgetLoading extends UserCubitState {}

final class ForgetSuccess extends UserCubitState {
  final String message;

  ForgetSuccess({required this.message});
}

final class ForgetFailure extends UserCubitState {
  final String errorMessage;
  ForgetFailure({required this.errorMessage});
}

final class ResetLoading extends UserCubitState {}

final class ResetSuccess extends UserCubitState {
  final String message;

  ResetSuccess({required this.message});
}

final class ResetFailure extends UserCubitState {
  final String errorMessage;
  ResetFailure({required this.errorMessage});
}

class VerifyCodeLoading extends UserCubitState {}

class VerifyCodeSuccess extends UserCubitState {}

class VerifyCodeFailure extends UserCubitState {
  final String message;

  VerifyCodeFailure(this.message);
}
