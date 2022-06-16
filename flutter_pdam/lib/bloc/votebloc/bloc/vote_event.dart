part of 'vote_bloc.dart';

abstract class VoteEvent extends Equatable {
  const VoteEvent();

  @override
  List<Object> get props => [];
}

class FetchVote extends VoteEvent{
  final VoteDto votedto;

  const FetchVote(this.votedto);

  @override
  List<Object> get props => [];
}

