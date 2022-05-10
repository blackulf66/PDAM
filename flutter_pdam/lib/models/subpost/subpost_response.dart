class SubPostApiResponse {
  SubPostApiResponse({
    required this.imagen,
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.createdDate,
    required this.postList,
    required this.userEntityId,
  });
  late final String imagen;
  late final int id;
  late final String nombre;
  late final String descripcion;
  late final String createdDate;
  late final List<PostList> postList;
  late final String userEntityId;
  
  SubPostApiResponse.fromJson(Map<String, dynamic> json){
    imagen = json['imagen'];
    id = json['id'];
    nombre = json['nombre'];
    descripcion = json['descripcion'];
    createdDate = json['createdDate'];
    postList = List.from(json['postList']).map((e)=>PostList.fromJson(e)).toList();
    userEntityId = json['userEntityId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['imagen'] = imagen;
    _data['id'] = id;
    _data['nombre'] = nombre;
    _data['descripcion'] = descripcion;
    _data['createdDate'] = createdDate;
    _data['postList'] = postList.map((e)=>e.toJson()).toList();
    _data['userEntityId'] = userEntityId;
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