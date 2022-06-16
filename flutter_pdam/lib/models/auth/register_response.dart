class RegisterResponse {
  RegisterResponse({
    required this.userId,
    required this.username,
    required this.email,
    required this.avatar,
    required this.created,
     this.postList,
    required this.userRole,
     this.following,
  });
  late final String userId;
  late final String username;
  late final String email;
  late final String avatar;
  late final String created;
  late final Null postList;
  late final String userRole;
  late final Null following;
  
  RegisterResponse.fromJson(Map<String, dynamic> json){
    userId = json['userId'];
    username = json['username'];
    email = json['email'];
    avatar = json['avatar'];
    created = json['created'];
    postList = null;
    userRole = json['userRole'];
    following = null;
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