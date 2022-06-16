class SubPostDto {
  SubPostDto({
    required this.nombre,
    required this.descripcion,
    
  });
  late final String nombre;
  late final String descripcion;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nombre'] = nombre;
    _data['descripcion'] = descripcion;
    return _data;
  }
}