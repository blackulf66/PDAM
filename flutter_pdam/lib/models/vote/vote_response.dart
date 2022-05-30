class VoteResponse {
  VoteResponse({
    required this.voteType,
    required this.postId,
  });
  late final String voteType;
  late final String postId;
  
  VoteResponse.fromJson(Map<String, dynamic> json){
    voteType = json['voteType'];
    postId = json['postId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['voteType'] = voteType;
    _data['postId'] = postId;
    return _data;
  }
}