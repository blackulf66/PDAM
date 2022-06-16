import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/auth/me_response.dart';
import '../../../repository/userRepository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  final UserRepository public;

  UserBloc(this.public) : super(BlocUserInitial()) {
    on<FetchUser>(_userFetched);
}
void _userFetched(FetchUser event, Emitter<UserState> emit) async {
    try {
      final user = await public.fetchUser();

      emit(UserFetched(user));
      return;
    } on Exception catch (e) {
      emit(UserFetchError(e.toString()));
    }
  }
}