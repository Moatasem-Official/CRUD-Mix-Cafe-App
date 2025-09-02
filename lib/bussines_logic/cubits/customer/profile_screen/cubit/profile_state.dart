part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileSignOutLoading extends ProfileState {}

final class ProfileSignOutSuccess extends ProfileState {
  final String message;
  const ProfileSignOutSuccess(this.message);
  @override
  List<Object> get props => [message];
}

final class ProfileSignOutError extends ProfileState {
  final String error;
  const ProfileSignOutError(this.error);
  @override
  List<Object> get props => [error];
}
