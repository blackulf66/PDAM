class PostDto {
  PostDto({
    required this.nombre,
    required this.descripcion,
    required this.subpost,
    
  });
  late final String nombre;
  late final String descripcion;
  late final String subpost;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nombre'] = nombre;
    _data['descripcion'] = descripcion;
    _data['subpost'] = subpost;
    return _data;
  }
}