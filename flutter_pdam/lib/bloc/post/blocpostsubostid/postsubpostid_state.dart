part of 'postsubpostid_bloc.dart';

abstract class postsubpostidState extends Equatable {
  const postsubpostidState();
  
  @override
  List<Object> get props => [];
}

class BlocpostsubpostidInitial extends postsubpostidState {}

class postsubpostidLoading extends postsubpostidState {}

class postsubpostidSuccessState extends postsubpostidState {
  final PostApiResponse loginResponse;

  const postsubpostidSuccessState(this.loginResponse);

  @override
  List<Object> get props => [loginResponse];
}
class postsubpostidErrorState extends postsubpostidState {
  final String message;

  const postsubpostidErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class postsubpostidFetched extends postsubpostidState {
  final List<PostListS> post;

  const postsubpostidFetched(this.post);

  @override
  List<Object> get props => [post];
}

class postsubpostidFetchError extends postsubpostidState {
  final String message;
  const postsubpostidFetchError(this.message);

  @override
  List<Object> get props => [message];
}