import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/auth/register_dto.dart';
import '../../../models/auth/register_response.dart';
import '../../../repository/authrepository/auth_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;

  RegisterBloc(this.authRepository) : super(RegisterInitialState()) {
    on<DoRegisterEvent>(_doRegisterEvent);
  }

  void _doRegisterEvent(DoRegisterEvent event, Emitter<RegisterState> emit) async {
    try {
      final registerResponse = await authRepository.register(event.registerDto, event.imagePath);
      emit(RegisterSuccessState(registerResponse));
      return;
    } on Exception catch (e) {
      emit(RegisterErrorState(e.toString()));
    }
  }
}
