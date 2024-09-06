import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:super_fam_app/model/state_model.dart';
import 'package:super_fam_app/model/user_model.dart';
import 'package:super_fam_app/repos/get_states_repo.dart';
import 'package:super_fam_app/services/shared_prefrence.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial()) {
    on<GetStateDataEvent>(getStateDataEvent);
    on<AddUserDetailEvent>(addUserDetailEvent);
  }

  FutureOr<void> getStateDataEvent(
    GetStateDataEvent event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(RegistrationLoadingState());
    try {
      final data = await GetStatesRepo().getStateList();
      print(data);
      emit(RegistrationLoadedState(stateModel: data));
    } catch (e) {
      print(e);
      emit(RegistrationFailureState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> addUserDetailEvent(
    AddUserDetailEvent event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(RegistrationLoadingState());

    try {
      final eventoJson = event.userDetail.toJson();
      await AppPrefHelper.setUserModal(
        userModal: jsonEncode(eventoJson),
      );
      final response = AppPrefHelper.getUserModal();
      await AppPrefHelper.setLoggedIn(loggedIn: true);
      emit(
        UserDataSavedSuccessState(
          userModel:
              UserModel.fromJson(jsonDecode(response) as Map<String, dynamic>),
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}
