part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class FetchUser extends UserEvent{

  const FetchUser();

  @override
  List<Object> get props => [];
}

class FetchUserList extends UserEvent{

  const FetchUserList();

  @override
  List<Object> get props => [];
}