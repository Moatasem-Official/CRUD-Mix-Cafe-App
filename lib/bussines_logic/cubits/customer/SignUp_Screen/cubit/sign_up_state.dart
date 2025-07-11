part of 'sign_up_cubit.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpSuccess extends SignUpState {
  final String message;
  const SignUpSuccess(this.message);

  @override
  List<Object> get props => [message];
}

final class SignUpError extends SignUpState {
  final String error;
  const SignUpError(this.error);

  @override
  List<Object> get props => [error];
}

final class SignUpNoInternet extends SignUpState {
  final String message;
  const SignUpNoInternet(this.message);

  @override
  List<Object> get props => [message];
}

final class SignUpEmailAlreadyInUse extends SignUpState {
  final String message;
  const SignUpEmailAlreadyInUse(this.message);

  @override
  List<Object> get props => [message];
}

final class SignUpWeakPassword extends SignUpState {
  final String message;
  const SignUpWeakPassword(this.message);

  @override
  List<Object> get props => [message];
}

final class SignUpInvalidEmail extends SignUpState {
  final String message;
  const SignUpInvalidEmail(this.message);

  @override
  List<Object> get props => [message];
}

final class SignUpUserDisabled extends SignUpState {
  final String message;
  const SignUpUserDisabled(this.message);

  @override
  List<Object> get props => [message];
}

final class SignUpTooManyRequests extends SignUpState {
  final String message;
  const SignUpTooManyRequests(this.message);

  @override
  List<Object> get props => [message];
}
