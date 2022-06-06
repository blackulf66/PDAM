part of 'vote_bloc.dart';

abstract class VoteState extends Equatable {
  const VoteState();
  
  @override
  List<Object> get props => [];
}


class VoteInitial extends VoteState {}

class VoteLoading extends VoteState {}

class VoteSuccessState extends VoteState {
  final VoteResponse voteResponse;

  const VoteSuccessState(this.voteResponse);

  @override
  List<Object> get props => [voteResponse];
}

class VoteErrorState extends VoteState {
  final String message;

  const VoteErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class VoteFetched extends VoteState {
  final VoteResponse Vote;

  const VoteFetched(this.Vote);

  @override
  List<Object> get props => [Vote];
}

class VoteFetchError extends VoteState {
  final String message;
  const VoteFetchError(this.message);

  @override
  List<Object> get props => [message];
}