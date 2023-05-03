// ignore_for_file: non_constant_identifier_names

class DetalleListaContactoModel {
  final int id;
  final int? lista_contacto_id;
  final int? contacto_id;
  final bool estatus;

  DetalleListaContactoModel(
    this.id,
    this.lista_contacto_id,
    this.contacto_id,
    this.estatus,
  );

  DetalleListaContactoModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        lista_contacto_id = parsedJson['lista_contacto_id'],
        contacto_id = parsedJson['contacto_id'],
        estatus = parsedJson['estatus'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'lista_contacto_id': lista_contacto_id,
        'contacto_id': contacto_id,
        'estatus': estatus,
      };
}
