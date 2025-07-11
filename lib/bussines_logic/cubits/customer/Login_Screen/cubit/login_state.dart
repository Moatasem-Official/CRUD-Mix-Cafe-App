part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginError extends LoginState {
  final String message;
  const LoginError(this.message);

  @override
  List<Object> get props => [message];
}

final class LoginNoInternet extends LoginState {
  final String message;
  const LoginNoInternet(this.message);

  @override
  List<Object> get props => [message];
}

final class LoginNoUser extends LoginState {
  final String message;
  const LoginNoUser(this.message);

  @override
  List<Object> get props => [message];
}

final class LoginNoPassword extends LoginState {
  final String message;
  const LoginNoPassword(this.message);

  @override
  List<Object> get props => [message];
}

final class LoginNoEmail extends LoginState {
  final String message;
  const LoginNoEmail(this.message);

  @override
  List<Object> get props => [message];
}

final class LoginUserNotVerified extends LoginState {
  final String message;
  const LoginUserNotVerified(this.message);

  @override
  List<Object> get props => [message];
}

final class LoginWrongEmailOrPassword extends LoginState {
  final String message;
  const LoginWrongEmailOrPassword(this.message);

  @override
  List<Object> get props => [message];
}

final class LoginUnknownError extends LoginState {
  final String message;
  const LoginUnknownError(this.message);

  @override
  List<Object> get props => [message];
}
