class DocumentoCreditoModel {
  final int id;
  final int contactoId;
  final int documentoId;
  final String? tabla;
  final String? fecha;
  final String? vencimiento;
  final int? empresaId;
  final int? parcialidad;
  final String? factura;
  final String? uuid;
  final String? cfdi;
  final bool? legal;
  final int? dias;
  final String? moneda;
  final String? tipoCambio;
  final int? razonSocialId;
  final String? createdAt;
  final String? updatedAt;
  final bool? dxc;
  final bool? dxp;
  final String? subtotal;
  final String? impuesto;
  final String? retencion;
  final String? total;
  final bool? estatus;
  final String? saldo;
  final String? pagado;
  final String? metodoPago;
  final int? lineaCreditoId;
  final String? tipoContacto;

  DocumentoCreditoModel(
      this.id,
      this.contactoId,
      this.documentoId,
      this.tabla,
      this.fecha,
      this.vencimiento,
      this.empresaId,
      this.parcialidad,
      this.factura,
      this.uuid,
      this.cfdi,
      this.legal,
      this.dias,
      this.moneda,
      this.tipoCambio,
      this.razonSocialId,
      this.createdAt,
      this.updatedAt,
      this.dxc,
      this.dxp,
      this.subtotal,
      this.impuesto,
      this.retencion,
      this.total,
      this.estatus,
      this.saldo,
      this.pagado,
      this.metodoPago,
      this.lineaCreditoId,
      this.tipoContacto);

  DocumentoCreditoModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        contactoId = parsedJson['contacto_id'],
        documentoId = parsedJson['documento_id'],
        tabla = parsedJson['tabla'],
        fecha = parsedJson['fecha'],
        vencimiento = parsedJson['vencimiento'],
        empresaId = parsedJson['empresa_id'],
        parcialidad = parsedJson['parcialidad'],
        factura = parsedJson['factura'],
        uuid = parsedJson['uuid'],
        cfdi = parsedJson['cfdi'],
        legal = parsedJson['legal'],
        dias = parsedJson['dias'],
        moneda = parsedJson['moneda'],
        tipoCambio = parsedJson['tipo_cambio'],
        razonSocialId = parsedJson['razon_social_id'],
        createdAt = parsedJson['created_at'],
        updatedAt = parsedJson['updated_at'],
        dxc = parsedJson['dxc'],
        dxp = parsedJson['dxp'],
        subtotal = parsedJson['subtotal'],
        impuesto = parsedJson['impuesto'],
        retencion = parsedJson['retencion'],
        total = parsedJson['total'],
        estatus = parsedJson['estatus'],
        saldo = parsedJson['saldo'],
        pagado = parsedJson['pagado'],
        metodoPago = parsedJson['metodo_pago'],
        lineaCreditoId = parsedJson['linea_credito_id'],
        tipoContacto = parsedJson['tipo_contacto'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'contacto_id': contactoId,
        'documento_id': documentoId,
        'tabla': tabla,
        'fecha': fecha,
        'vencimiento': vencimiento,
        'empresa_id': empresaId,
        'parcialidad': parcialidad,
        'factura': factura,
        'uuid': uuid,
        'cfdi': cfdi,
        'legal': legal,
        'dias': dias,
        'moneda': moneda,
        'tipo_cambio': tipoCambio,
        'razon_social_id': razonSocialId,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'dxc': dxc,
        'dxp': dxp,
        'subtotal': subtotal,
        'impuesto': impuesto,
        'retencion': retencion,
        'total': total,
        'estatus': estatus,
        'saldo': saldo,
        'pagado': pagado,
        'metodo_pago': metodoPago,
        'linea_credito_id': lineaCreditoId,
        'tipo_contacto': tipoContacto,
      };
}
