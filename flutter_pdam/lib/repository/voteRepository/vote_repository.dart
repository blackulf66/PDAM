import 'package:pdamfinal/models/vote/vote_dto.dart';
import 'package:pdamfinal/models/vote/vote_response.dart';

abstract class VoteRepository {
  Future<VoteResponse> fetchVote(VoteDto voteDto);
  

}