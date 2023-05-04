class ContactoModelo {
  int? id;
  String? nombre;
  int? direccionId;
  bool? estatus;
  String? createdAt;
  String? updatedAt;
  int? databaseId;
  int? listaPrecioClienteId;
  int? listaPrecioProveedorId;
  String? apellidoPaterno;
  String? apellidoMaterno;
  bool? personaMoral;
  bool? cliente;
  bool? proveedor;
  bool? deudor;
  bool? acreedor;
  bool? empleado;
  bool? vendedor;
  bool? cajero;
  bool? tecnico;
  int? cuentaContableCliente;
  int? cuentaContableProveedor;
  int? cuentaContableDeudor;
  int? cuentaContableAcreedor;
  int? cuentaContableEmpleado;
  int? cuentaContableClienteComp;
  int? cuentaContableProveedorComp;
  int? cuentaContableDeudorComp;
  int? cuentaContableAcreedorComp;
  int? cuentaContableEmpleadoComp;
  int? cuentaContableClienteAnticipo;
  int? cuentaContableProveedorAnticipo;
  String? impuestoPerfil;
  String? nombreCompleto;
  int? userId;
  String? impuestoPerfilProveedor;
  bool? socio;
  int? diasCreditoCliente;
  int? diasCreditoProveedor;

  ContactoModelo(
      this.id,
      this.nombre,
      this.direccionId,
      this.estatus,
      this.createdAt,
      this.updatedAt,
      this.databaseId,
      this.listaPrecioClienteId,
      this.listaPrecioProveedorId,
      this.apellidoPaterno,
      this.apellidoMaterno,
      this.personaMoral,
      this.cliente,
      this.proveedor,
      this.deudor,
      this.acreedor,
      this.empleado,
      this.vendedor,
      this.cajero,
      this.tecnico,
      this.cuentaContableCliente,
      this.cuentaContableProveedor,
      this.cuentaContableDeudor,
      this.cuentaContableAcreedor,
      this.cuentaContableEmpleado,
      this.cuentaContableClienteComp,
      this.cuentaContableProveedorComp,
      this.cuentaContableDeudorComp,
      this.cuentaContableAcreedorComp,
      this.cuentaContableEmpleadoComp,
      this.cuentaContableClienteAnticipo,
      this.cuentaContableProveedorAnticipo,
      this.impuestoPerfil,
      this.nombreCompleto,
      this.userId,
      this.impuestoPerfilProveedor,
      this.socio,
      this.diasCreditoCliente,
      this.diasCreditoProveedor);

  ContactoModelo.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson["id"],
        nombre = parsedJson["nombre"],
        direccionId = parsedJson["direccion_id"],
        estatus = parsedJson["estatus"],
        createdAt = parsedJson["created_at"],
        updatedAt = parsedJson["updated_at"],
        databaseId = parsedJson["database_id"],
        listaPrecioClienteId = parsedJson["lista_precio_cliente_id"],
        listaPrecioProveedorId = parsedJson["lista_precio_proveedor_id"],
        apellidoPaterno = parsedJson["apellido_paterno"],
        apellidoMaterno = parsedJson["apellido_materno"],
        personaMoral = parsedJson["persona_moral"],
        cliente = parsedJson["cliente"],
        proveedor = parsedJson["proveedor"],
        deudor = parsedJson["deudor"],
        acreedor = parsedJson["acreedor"],
        empleado = parsedJson["empleado"],
        vendedor = parsedJson["vendedor"],
        cajero = parsedJson["cajero"],
        tecnico = parsedJson["tecnico"],
        cuentaContableCliente = parsedJson["cuenta_contable_cliente"],
        cuentaContableProveedor = parsedJson["cuenta_contable_proveedor"],
        cuentaContableDeudor = parsedJson["cuenta_contable_deudor"],
        cuentaContableAcreedor = parsedJson["cuenta_contable_acreedor"],
        cuentaContableEmpleado = parsedJson["cuenta_contable_empleado"],
        cuentaContableClienteComp = parsedJson["cuenta_contable_cliente_comp"],
        cuentaContableProveedorComp =
            parsedJson["cuenta_contable_proveedor_comp"],
        cuentaContableDeudorComp = parsedJson["cuenta_contable_deudor_comp"],
        cuentaContableAcreedorComp =
            parsedJson["cuenta_contable_acreedor_comp"],
        cuentaContableEmpleadoComp =
            parsedJson["cuenta_contable_empleado_comp"],
        cuentaContableClienteAnticipo =
            parsedJson["cuenta_contable_cliente_anticipo"],
        cuentaContableProveedorAnticipo =
            parsedJson["cuenta_contable_proveedor_anticipo"],
        impuestoPerfil = parsedJson["impuesto_perfil"],
        nombreCompleto = parsedJson["nombre_completo"],
        userId = parsedJson["user_id"],
        impuestoPerfilProveedor = parsedJson["impuesto_perfil_proveedor"],
        socio = parsedJson["socio"],
        diasCreditoCliente = parsedJson["dias_credito_cliente"],
        diasCreditoProveedor = parsedJson["dias_credito_proveedor"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "direccion_id": direccionId,
        "estatus": estatus,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "database_id": databaseId,
        "lista_precio_cliente_id": listaPrecioClienteId,
        "lista_precio_proveedor_id": listaPrecioProveedorId,
        "apellido_paterno": apellidoPaterno,
        "apellido_materno": apellidoMaterno,
        "persona_moral": personaMoral,
        "cliente": cliente,
        "proveedor": proveedor,
        "deudor": deudor,
        "acreedor": acreedor,
        "empleado": empleado,
        "vendedor": vendedor,
        "cajero": cajero,
        "tecnico": tecnico,
        "cuenta_contable_cliente": cuentaContableCliente,
        "cuenta_contable_proveedor": cuentaContableProveedor,
        "cuenta_contable_deudor": cuentaContableDeudor,
        "cuenta_contable_acreedor": cuentaContableAcreedor,
        "cuenta_contable_empleado": cuentaContableEmpleado,
        "cuenta_contable_cliente_comp": cuentaContableClienteComp,
        "cuenta_contable_proveedor_comp": cuentaContableProveedorComp,
        "cuenta_contable_deudor_comp": cuentaContableDeudorComp,
        "cuenta_contable_acreedor_comp": cuentaContableAcreedorComp,
        "cuenta_contable_empleado_comp": cuentaContableEmpleadoComp,
        "cuenta_contable_cliente_anticipo": cuentaContableClienteAnticipo,
        "cuenta_contable_proveedor_anticipo": cuentaContableProveedorAnticipo,
        "impuesto_perfil": impuestoPerfil,
        "nombre_completo": nombreCompleto,
        "user_id": userId,
        "impuesto_perfil_proveedor": impuestoPerfilProveedor,
        "socio": socio,
        "dias_credito_cliente": diasCreditoCliente,
        "dias_credito_proveedor": diasCreditoProveedor
      };
}
