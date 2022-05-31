part of 'user_bloc.dart';

abstract class UserStatePost extends Equatable {
  const UserStatePost();
  
  @override
  List<Object> get props => [];
}

class BlocUserInitialPost extends UserStatePost {}

class UserLoading extends UserStatePost {}

class UserSuccessStateListPost extends UserStatePost {
  final PostList meResponse;

  const UserSuccessStateListPost(this.meResponse);

  @override
  List<Object> get props => [meResponse];
}

class UserErrorStatePost extends UserStatePost {
  final String message;

  const UserErrorStatePost(this.message);

  @override
  List<Object> get props => [message];
}


class UserFetchedListPost extends UserStatePost {
  final List<PostList>  user;

  const UserFetchedListPost(this.user);

  @override
  List<Object> get props => [user];
}
class UserFetchErrorPost extends UserStatePost {
  final String message;
  const UserFetchErrorPost(this.message);

  @override
  List<Object> get props => [message];
}