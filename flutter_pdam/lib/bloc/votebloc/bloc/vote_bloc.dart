import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pdamfinal/models/vote/vote_dto.dart';

import '../../../models/vote/vote_response.dart';
import '../../../repository/voteRepository/vote_repository.dart';

part 'vote_event.dart';
part 'vote_state.dart';

class VoteBloc extends Bloc<VoteEvent, VoteState> {

  final VoteRepository public;

  VoteBloc(this.public) : super(VoteInitial()) {
    on<FetchVote>(_VoteFetched);
}
void _VoteFetched(FetchVote event, Emitter<VoteState> emit) async {
    try {
      final Vote = await public.fetchVote(event.votedto);

      emit(VoteFetched(Vote));
      return;
    } on Exception catch (e) {
      emit(VoteFetchError(e.toString()));
    }
  }
}