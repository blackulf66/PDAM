part of 'post_bloc.dart';



abstract class PostState extends Equatable {
  const PostState();
  
  @override
  List<Object> get props => [];
}

class BlocPostInitial extends PostState {}

class PostLoading extends PostState {}

class PostSuccessState extends PostState {
  final PostApiResponse loginResponse;

  const PostSuccessState(this.loginResponse);

  @override
  List<Object> get props => [loginResponse];
}

class PostErrorState extends PostState {
  final String message;

  const PostErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class PostFetched extends PostState {
  final List<PostApiResponse> post;

  const PostFetched(this.post);

  @override
  List<Object> get props => [post];
}

class PostFetchError extends PostState {
  final String message;
  const PostFetchError(this.message);

  @override
  List<Object> get props => [message];
}