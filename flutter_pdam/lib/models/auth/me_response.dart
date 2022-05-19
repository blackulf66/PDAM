class MeResponse {
  MeResponse({
    required this.userId,
    required this.username,
    required this.email,
    required this.avatar,
    required this.created,
    required this.postList,
    required this.userRole,
    required this.following,
  });
  late final String userId;
  late final String username;
  late final String email;
  late final String avatar;
  late final String created;
  late final List<dynamic> postList;
  late final String userRole;
  late final List<dynamic> following;
  
  MeResponse.fromJson(Map<String, dynamic> json){
    userId = json['userId'];
    username = json['username'];
    email = json['email'];
    avatar = json['avatar'];
    created = json['created'];
    postList = List.castFrom<dynamic, dynamic>(json['postList']);
    userRole = json['userRole'];
    following = List.castFrom<dynamic, dynamic>(json['following']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['username'] = username;
    _data['email'] = email;
    _data['avatar'] = avatar;
    _data['created'] = created;
    _data['postList'] = postList;
    _data['userRole'] = userRole;
    _data['following'] = following;
    return _data;
  }
}