import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/auth/me_response.dart';
import '../../../repository/userRepository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBlocPost extends Bloc<UserEvent, UserStatePost> {

  final UserRepository public;

  UserBlocPost(this.public) : super(BlocUserInitialPost()) {
    on<FetchUserListPost>(_userFetchedList);
}
 void _userFetchedList(FetchUserListPost event, Emitter<UserStatePost> emit) async {
    try {
      final user = await public.fetchUserPostList();

      emit(UserFetchedListPost(user));
      return;
    } on Exception catch (e) {
      emit(UserFetchErrorPost(e.toString()));
    }
  }
}