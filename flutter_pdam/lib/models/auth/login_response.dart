class LoginResponse {
  LoginResponse({
    required this.email,
    required this.nick,
    required this.avatar,
    required this.username,
    required this.role,
    required this.token,
     this.fecha,
    required this.perfilPrivado,
    required this.posts,
  });
  late final String email;
  late final String nick;
  late final String avatar;
  late final String username;
  late final String role;
  late final String token;
  late final Null fecha;
  late final bool perfilPrivado;
  late final List<Posts> posts;
  
  LoginResponse.fromJson(Map<String, dynamic> json){
    email = json['email'];
    nick = json['nick'];
    avatar = json['avatar'];
    username = json['username'];
    role = json['role'];
    token = json['token'];
    fecha = null;
    perfilPrivado = json['perfilPrivado'];
    posts = List.from(json['posts']).map((e)=>Posts.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['nick'] = nick;
    _data['avatar'] = avatar;
    _data['username'] = username;
    _data['role'] = role;
    _data['token'] = token;
    _data['fecha'] = fecha;
    _data['perfilPrivado'] = perfilPrivado;
    _data['posts'] = posts.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Posts {
  Posts({
    required this.id,
    required this.titulo,
    required this.texto,
    required this.imagen,
    required this.postEnum,
    required this.username,
  });
  late final int id;
  late final String titulo;
  late final String texto;
  late final String imagen;
  late final String postEnum;
  late final String username;
  
  Posts.fromJson(Map<String, dynamic> json){
    id = json['id'];
    titulo = json['titulo'];
    texto = json['texto'];
    imagen = json['imagen'];
    postEnum = json['postEnum'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['titulo'] = titulo;
    _data['texto'] = texto;
    _data['imagen'] = imagen;
    _data['postEnum'] = postEnum;
    _data['username'] = username;
    return _data;
  }
}