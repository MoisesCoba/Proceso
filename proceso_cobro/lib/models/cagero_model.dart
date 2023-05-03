class CajerosModel {
  int? id;
  int? contacto_id;
  String? user;
  String? password;
  int? almacen_id;
  int? sucursal_id;
  int? empresa_id;
  int? cliente_id;
  int? vendedor_id;
  int? razon_social_id;
  String? moneda;
  String? serie_venta;
  String? serie_cobro;
  String? created_at;
  String? updated_at;

  CajerosModel(
    this.id,
    this.contacto_id,
    this.user,
    this.password,
    this.almacen_id,
    this.sucursal_id,
    this.empresa_id,
    this.cliente_id,
    this.vendedor_id,
    this.razon_social_id,
    this.moneda,
    this.serie_venta,
    this.serie_cobro,
    this.created_at,
    this.updated_at,
  );

  CajerosModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson["id"],
        contacto_id = parsedJson["contacto_id"],
        user = parsedJson["user"],
        password = parsedJson["password"],
        almacen_id = parsedJson["almacen_id"],
        sucursal_id = parsedJson["sucursal_id"],
        empresa_id = parsedJson["empresa_id"],
        cliente_id = parsedJson["cliente_id"],
        vendedor_id = parsedJson["vendedor_id"],
        razon_social_id = parsedJson["razon_social_id"],
        moneda = parsedJson["moneda"],
        serie_venta = parsedJson["serie_venta"],
        serie_cobro = parsedJson["serie_cobro"],
        created_at = parsedJson["created_at"],
        updated_at = parsedJson["updated_at"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "contacto_id": contacto_id,
        "user": user,
        "password": password,
        "almacen_id": almacen_id,
        "sucursal_id": sucursal_id,
        "empresa_id": empresa_id,
        "cliente_id": cliente_id,
        "vendedor_id": vendedor_id,
        "razonSocial_id": razon_social_id,
        "moneda": moneda,
        "serie_venta": serie_venta,
        "serie_cobro": serie_cobro,
        "created_at": created_at,
        "updated_at": updated_at,
      };
}
