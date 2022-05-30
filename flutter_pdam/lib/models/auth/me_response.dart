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
  late final List<PostList> postList;
  late final String userRole;
  late final List<Following> following;
  
  MeResponse.fromJson(Map<String, dynamic> json){
    userId = json['userId'];
    username = json['username'];
    email = json['email'];
    avatar = json['avatar'];
    created = json['created'];
    postList = List.from(json['postList']).map((e)=>PostList.fromJson(e)).toList();
    userRole = json['userRole'];
    following = List.from(json['following']).map((e)=>Following.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['username'] = username;
    _data['email'] = email;
    _data['avatar'] = avatar;
    _data['created'] = created;
    _data['postList'] = postList.map((e)=>e.toJson()).toList();
    _data['userRole'] = userRole;
    _data['following'] = following.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class PostList {
  PostList({
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
  
  PostList.fromJson(Map<String, dynamic> json){
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

class Following {
  Following({
    required this.imagen,
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.createdDate,
     this.postList,
    required this.userEntityId,
  });
  late final String imagen;
  late final int id;
  late final String nombre;
  late final String descripcion;
  late final String createdDate;
  late final Null postList;
  late final String userEntityId;
  
  Following.fromJson(Map<String, dynamic> json){
    imagen = json['imagen'];
    id = json['id'];
    nombre = json['nombre'];
    descripcion = json['descripcion'];
    createdDate = json['createdDate'];
    postList = null;
    userEntityId = json['userEntityId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['imagen'] = imagen;
    _data['id'] = id;
    _data['nombre'] = nombre;
    _data['descripcion'] = descripcion;
    _data['createdDate'] = createdDate;
    _data['postList'] = postList;
    _data['userEntityId'] = userEntityId;
    return _data;
  }
}