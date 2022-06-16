part of 'user_bloc.dart';

abstract class UserStateFollow extends Equatable {
  const UserStateFollow();
  
  @override
  List<Object> get props => [];
}

class BlocUserInitialFollow extends UserStateFollow {}

class UserLoading extends UserStateFollow {}

class UserSuccessStateFollow extends UserStateFollow {
  final MeResponse meResponse;

  const UserSuccessStateFollow(this.meResponse);

  @override
  List<Object> get props => [meResponse];
}

class UserSuccessStateListFollow extends UserStateFollow {
  final Following meResponse;

  const UserSuccessStateListFollow(this.meResponse);

  @override
  List<Object> get props => [meResponse];
}

class UserErrorStateFollow extends UserStateFollow {
  final String message;

  const UserErrorStateFollow(this.message);

  @override
  List<Object> get props => [message];
}

class UserFetchedListFollow extends UserStateFollow {
  final List<Following>  user;

  const UserFetchedListFollow(this.user);

  @override
  List<Object> get props => [user];
}
class UserFetchErrorFollow extends UserStateFollow {
  final String message;
  const UserFetchErrorFollow(this.message);

  @override
  List<Object> get props => [message];
}