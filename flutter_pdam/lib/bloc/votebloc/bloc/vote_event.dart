part of 'vote_bloc.dart';

abstract class VoteEvent extends Equatable {
  const VoteEvent();

  @override
  List<Object> get props => [];
}

class FetchVote extends VoteEvent{

  const FetchVote();

  @override
  List<Object> get props => [];
}

