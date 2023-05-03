// ignore_for_file: non_constant_identifier_names

class ListaContactoModel {
  final int id;
  final String? nombre;
  final bool estatus;
  final String? created_at;
  final String? updated_at;

  ListaContactoModel(
    this.id,
    this.nombre,
    this.estatus,
    this.created_at,
    this.updated_at,
  );

  ListaContactoModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        nombre = parsedJson['nombre'],
        estatus = parsedJson['estatus'],
        created_at = parsedJson['created_at'],
        updated_at = parsedJson['updated_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'estatus': estatus,
        'created_at': created_at,
        'updated_at': updated_at,
      };
}
