part of 'post_bloc.dart';



abstract class BlocPostState extends Equatable {
  const BlocPostState();
  
  @override
  List<Object> get props => [];
}

class BlocPostInitial extends BlocPostState {}

class PostLoading extends BlocPostState {}

class PostSuccessState extends BlocPostState {
  final PostApiResponse loginResponse;

  const PostSuccessState(this.loginResponse);

  @override
  List<Object> get props => [loginResponse];
}

class PostErrorState extends BlocPostState {
  final String message;

  const PostErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class PostFetched extends BlocPostState {
  final List<PostApiResponse> post;

  final String type;

  const PostFetched(this.post, this.type);

  @override
  List<Object> get props => [post];
}

class PostFetchError extends BlocPostState {
  final String message;
  const PostFetchError(this.message);

  @override
  List<Object> get props => [message];
}