class VoteDto {
  VoteDto({
    required this.voteType,
    required this.postId,
  });
  late final String voteType;
  late final int postId;
  
  VoteDto.fromJson(Map<String, dynamic> json){
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