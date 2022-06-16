class VoteResponse {
  VoteResponse({
    required this.voteType,
    required this.postId,
    required this.user,
  });
  late final String voteType;
  late final String postId;
  late final String user;
  
  VoteResponse.fromJson(Map<String, dynamic> json){
    voteType = json['voteType'];
    postId = json['postId'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['voteType'] = voteType;
    _data['postId'] = postId;
    _data['user']= user;
    return _data;
  }
}