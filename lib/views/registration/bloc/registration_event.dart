part of 'registration_bloc.dart';

@immutable
sealed class RegistrationEvent {}

class GetStateDataEvent extends RegistrationEvent {}

class AddUserDetailEvent extends RegistrationEvent {
  AddUserDetailEvent({required this.userDetail});

  final UserModel userDetail;
}
