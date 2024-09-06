part of 'registration_bloc.dart';

@immutable
sealed class RegistrationState {}

final class RegistrationInitial extends RegistrationState {}

final class RegistrationLoadingState extends RegistrationState {}

final class RegistrationLoadedState extends RegistrationState {
  RegistrationLoadedState({this.stateModel});

  final StateModal? stateModel;
}

final class RegistrationFailureState extends RegistrationState {
  RegistrationFailureState({required this.errorMessage});

  final String errorMessage;
}

final class UserDataSavedSuccessState extends RegistrationState {
  UserDataSavedSuccessState({required this.userModel});

  final UserModel? userModel;
}
