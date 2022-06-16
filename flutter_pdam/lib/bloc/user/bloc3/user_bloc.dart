import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/auth/me_response.dart';
import '../../../repository/userRepository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc3 extends Bloc<UserEventFollow, UserStateFollow> {

  final UserRepository public;

  UserBloc3(this.public) : super(BlocUserInitialFollow()) {
    on<FetchUserListFollow>(_userFetchedListFollow);
}

  void _userFetchedListFollow(FetchUserListFollow event, Emitter<UserStateFollow> emit) async {
    try {
      final user = await public.fetchUserfollowList();

      emit(UserFetchedListFollow(user));
      return;
    } on Exception catch (e) {
      emit(UserFetchErrorFollow(e.toString()));
    }
  }
}