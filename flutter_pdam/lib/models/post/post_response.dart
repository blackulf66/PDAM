class PostApiResponse {
  PostApiResponse({
    required this.id,
    required this.titulo,
    required this.texto,
    required this.imagen,
    required this.postEnum,
    required this.username,
    required this.userImage,

  });
  late final int id;
  late final String titulo;
  late final String texto;
  late final String imagen;
  late final String postEnum;
  late final String username;
  late final String userImage;

  
  PostApiResponse.fromJson(Map<String, dynamic> json){
    id = json['id'];
    titulo = json['titulo'];
    texto = json['texto'];
    imagen = json['imagen'];
    postEnum = json['postEnum'];
    username = json['username'];
    userImage = json['userImage'];

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['titulo'] = titulo;
    _data['texto'] = texto;
    _data['imagen'] = imagen;
    _data['postEnum'] = postEnum;
    _data['userImage'] = userImage;
    _data['username'] = username;
    return _data;
  }
}