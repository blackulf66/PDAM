part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class FetchUserListPost extends UserEvent{

  const FetchUserListPost();

  @override
  List<Object> get props => [];
}
