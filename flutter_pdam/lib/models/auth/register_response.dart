class RegisterResponse {
  RegisterResponse({
    required this.userId,
    required this.username,
    required this.email,
    required this.avatar,
    required this.created,
    this.subpostList,
    required this.userRole,
  });
  late final String userId;
  late final String username;
  late final String email;
  late final String avatar;
  late final String created;
  late final Null subpostList;
  late final String userRole;
  
  RegisterResponse.fromJson(Map<String, dynamic> json){
    userId = json['userId'];
    username = json['username'];
    email = json['email'];
    avatar = json['avatar'];
    created = json['created'];
    subpostList = null;
    userRole = json['userRole'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['username'] = username;
    _data['email'] = email;
    _data['avatar'] = avatar;
    _data['created'] = created;
    _data['subpostList'] = subpostList;
    _data['userRole'] = userRole;
    return _data;
  }
}