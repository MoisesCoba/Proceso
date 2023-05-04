class FormaPagoModel {
  final int id;
  final String nombre;
  final int database_id;
  final bool? bancarizado;
  final bool? depositable;
  final bool? mostrar_pv;
  final bool? requiere_referencia;
  final String? factor_comision;
  final String? codigo_sat;
  final String? cuenta_contable;
  final bool? estatus;
  final String? created_at;
  final String? updated_at;
  final String? metodo_pago;
  final String? forma_pago;
  final String? moneda;
  final String? tipo_cambio_default;
  final bool? permitir_cambio;

  FormaPagoModel(
    this.id,
    this.nombre,
    this.database_id,
    this.bancarizado,
    this.depositable,
    this.mostrar_pv,
    this.requiere_referencia,
    this.factor_comision,
    this.codigo_sat,
    this.cuenta_contable,
    this.estatus,
    this.created_at,
    this.updated_at,
    this.metodo_pago,
    this.forma_pago,
    this.moneda,
    this.tipo_cambio_default,
    this.permitir_cambio,
  );

  FormaPagoModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        nombre = parsedJson['nombre'],
        database_id = parsedJson['database_id'],
        bancarizado = parsedJson['bancarizado'],
        depositable = parsedJson['depositable'],
        mostrar_pv = parsedJson['mostrar_pv'],
        requiere_referencia = parsedJson['requiere_referencia'],
        factor_comision = parsedJson['factor_comision'],
        codigo_sat = parsedJson['codigo_sat'],
        cuenta_contable = parsedJson['cuenta_contable'],
        estatus = parsedJson['estatus'],
        created_at = parsedJson['created_at'],
        updated_at = parsedJson['updated_at'],
        metodo_pago = parsedJson['metodo_pago'],
        forma_pago = parsedJson['forma_pago'],
        moneda = parsedJson['moneda'],
        tipo_cambio_default = parsedJson['tipo_cambio_default'],
        permitir_cambio = parsedJson['permitir_cambio'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'database_id': database_id,
        'bancarizado': bancarizado,
        'depositable': depositable,
        'mostrar_pv': mostrar_pv,
        'requiere_referencia': requiere_referencia,
        'factor_comision': factor_comision,
        'codigo_sat': codigo_sat,
        'cuenta_contable': cuenta_contable,
        'estatus': estatus,
        'created_at': created_at,
        'updated_at': updated_at,
        'metodo_pago': metodo_pago,
        'forma_pago': forma_pago,
        'moneda': moneda,
        'tipo_cambio_default': tipo_cambio_default,
        'permitir_cambio': permitir_cambio
      };
}
