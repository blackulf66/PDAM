class LoginResponse {
  LoginResponse({
    required this.email,
    required this.avatar,
    required this.username,
    required this.token,
    required this.userRole,
    required this.fecha,
     this.subPosts,
    required this.posts,
  });
  late final String email;
  late final String avatar;
  late final String username;
  late final String token;
  late final String userRole;
  late final String fecha;
  late final Null subPosts;
  late final List<dynamic> posts;
  
  LoginResponse.fromJson(Map<String, dynamic> json){
    email = json['email'];
    avatar = json['avatar'];
    username = json['username'];
    token = json['token'];
    userRole = json['userRole'];
    fecha = json['fecha'];
    subPosts = null;
    posts = List.castFrom<dynamic, dynamic>(json['posts']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['avatar'] = avatar;
    _data['username'] = username;
    _data['token'] = token;
    _data['userRole'] = userRole;
    _data['fecha'] = fecha;
    _data['subPosts'] = subPosts;
    _data['posts'] = posts;
    return _data;
  }
}
