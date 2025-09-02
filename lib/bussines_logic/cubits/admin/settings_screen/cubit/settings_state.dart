part of 'settings_cubit.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

final class SettingsInitial extends SettingsState {}

final class SettingsSignOutLoading extends SettingsState {}

final class SettingsSignOutSuccess extends SettingsState {
  final String message;
  const SettingsSignOutSuccess(this.message);

  @override
  List<Object> get props => [message];
}

final class SettingsSignOutError extends SettingsState {
  final String message;
  const SettingsSignOutError(this.message);

  @override
  List<Object> get props => [message];
}
