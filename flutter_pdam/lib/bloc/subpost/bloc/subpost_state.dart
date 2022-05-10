part of 'subpost_bloc.dart';



abstract class SubPostState extends Equatable {
  const SubPostState();
  
  @override
  List<Object> get props => [];
}

class BlocSubPostInitial extends SubPostState {}

class SubPostLoading extends SubPostState {}

class SubPostSuccessState extends SubPostState {
  final SubPostApiResponse loginResponse;

  const SubPostSuccessState(this.loginResponse);

  @override
  List<Object> get props => [loginResponse];
}

class SubPostErrorState extends SubPostState {
  final String message;

  const SubPostErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class SubPostFetched extends SubPostState {
  final List<SubPostApiResponse> post;

  const SubPostFetched(this.post);

  @override
  List<Object> get props => [post];
}

class SubPostFetchError extends SubPostState {
  final String message;
  const SubPostFetchError(this.message);

  @override
  List<Object> get props => [message];
}