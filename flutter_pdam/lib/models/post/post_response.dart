class PostApiResponse {
  PostApiResponse({
    required this.imagenportada,
    required this.postId,
    required this.postName,
    required this.description,
    required this.userEntityId,
    required this.createdDate,
    required this.subpostsName,
    required this.voteCount,
  });
  late final String imagenportada;
  late final int postId;
  late final String postName;
  late final String description;
  late final String userEntityId;
  late final String createdDate;
  late final String subpostsName;
  late final int voteCount;
  
  PostApiResponse.fromJson(Map<String, dynamic> json){
    imagenportada = json['imagenportada'];
    postId = json['postId'];
    postName = json['postName'];
    description = json['description'];
    userEntityId = json['userEntityId'];
    createdDate = json['createdDate'];
    subpostsName = json['subpostsName'];
    voteCount = json['voteCount'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['imagenportada'] = imagenportada;
    _data['postId'] = postId;
    _data['postName'] = postName;
    _data['description'] = description;
    _data['userEntityId'] = userEntityId;
    _data['createdDate'] = createdDate;
    _data['subpostsName'] = subpostsName;
    _data['voteCount'] = voteCount;
    return _data;
  }
}