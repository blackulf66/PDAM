part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
  
  @override
  List<Object> get props => [];
}

class BlocUserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccessState extends UserState {
  final MeResponse meResponse;

  const UserSuccessState(this.meResponse);

  @override
  List<Object> get props => [meResponse];
}

class UserErrorState extends UserState {
  final String message;

  const UserErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class UserFetched extends UserState {
  final MeResponse user;

  const UserFetched(this.user);

  @override
  List<Object> get props => [user];
}

class UserFetchedList extends UserState {
  final List<Following> user;

  const UserFetchedList(this.user);

  @override
  List<Object> get props => [user];
}

class UserFetchedListPost extends UserState {
  final List<PostList>  user;

  const UserFetchedListPost(this.user);

  @override
  List<Object> get props => [user];
}
class UserFetchError extends UserState {
  final String message;
  const UserFetchError(this.message);

  @override
  List<Object> get props => [message];
}