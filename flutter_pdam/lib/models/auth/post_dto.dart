class PostDto {
  PostDto({
    required this.titulo,
    required this.texto,
    required this.postEnum,
    
  });
  late final String titulo;
  late final String texto;
  late final String postEnum;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['titulo'] = titulo;
    _data['texto'] = texto;
    _data['postEnum'] = postEnum;
    return _data;
  }
}