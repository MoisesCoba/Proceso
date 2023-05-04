import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart' as sql;

import '../models/documento_credito_model.dart';
import '../routes/api_rutas.dart';
//Services

class SQLHelperDocumentoCredito {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE documento(
    custom_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    id INTEGER ,
    contacto_id INTEGER,
    documento_id INTEGER,
    tabla TEXT,
    fecha TEXT,
    vencimiento TEXT,
    empresa_id INTEGER,
    parcialidad INTEGER,
    factura TEXT,
    uuid TEXT,
    cfdi TEXT,
    legal BOOLEAN,
    dias INTEGER,
    moneda TEXT,
    tipo_cambio TEXT,
    razon_social_id INTEGER,
    created_at TEXT,
    updated_at TEXT,
    dxc BOOLEAN,
    dxp BOOLEAN,
    subtotal TEXT,
    impuesto TEXT,
    retencion TEXT,
    total TEXT,
    estatus BOOLEAN,
    saldo TEXT,
    pagado TEXT,
    metodo_pago TEXT,
    linea_credito_id INTEGER,
    tipo_contacto TEXT
          downloaded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        )""");
  }

  static Future<sql.Database> db() async {
    print('... CREATING DATABASE:--> documento_credito...');
    return sql.openDatabase('app_pos_documento.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      print('... CREATING A TABLE: --> docuemnto ...');
      await createTables(database);
      print('.. unidad TABLE CREATED ..');
    });
  }

  static Future<int> getApiDocumento() async {
    /* SE OBTINEN LOS DATOS DE LA API */
    final connJson = Uri.parse(api_documentos_credito);
    List<DocumentoCreditoModel> getList = [];
    var response = await http.get(connJson);

    String responseBody = response.body;
    var jsonBody = json.decode(responseBody);

    print('... OPENING DB   U_U ...');
    final db = await SQLHelperDocumentoCredito.db();
    await db.delete('documento');

    print('... BUILDING LIST  B-) ...');
    for (var data in jsonBody) {
      getList.add(DocumentoCreditoModel(
          data['id'],
          data['contacto_id'],
          data['documento_id'],
          data['tabla'],
          data['fecha'],
          data['vencimiento'],
          data['empresa_id'],
          data['parcialidad'],
          data['factura'],
          data['uuid'],
          data['cfdi'],
          data['legal'],
          data['dias'],
          data['moneda'],
          data['tipo_cambio'],
          data['razon_social_id'],
          data['created_at'],
          data['updated_at'],
          data['dxc'],
          data['dxp'],
          data['subtotal'],
          data['impuesto'],
          data['retencion'],
          data['total'],
          data['estatus'],
          data['saldo'],
          data['pagado'],
          data['metodo_pago'],
          data['linea_credito_id'],
          data['tipo_contacto']));
    }

    getList.forEach((element) async {
      final data = {
        'id': element.id,
        'contacto_id': element.contactoId,
        'documento_id': element.documentoId,
        'tabla': element.tabla,
        'fecha': element.fecha,
        'vencimiento': element.vencimiento,
        'empresa_id': element.empresaId,
        'parcialidad': element.parcialidad,
        'factura': element.factura,
        'uuid': element.uuid,
        'cfdi': element.cfdi,
        'legal': element.legal,
        'dias': element.dias,
        'moneda': element.moneda,
        'tipo_cambio': element.tipoCambio,
        'razon_social_id': element.razonSocialId,
        'created_at': element.createdAt,
        'updated_at': element.updatedAt,
        'dxc': element.dxc,
        'dxp': element.dxp,
        'subtotal': element.subtotal,
        'impuesto': element.impuesto,
        'retencion': element.retencion,
        'total': element.total,
        'estatus': element.estatus,
        'saldo': element.saldo,
        'pagado': element.pagado,
        'metodo_pago': element.metodoPago,
        'linea_credito_id': element.lineaCreditoId,
        'tipo_contacto': element.tipoContacto,
      };

      await db.insert('documento', data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
      print('..Base de datos creada documentos credito..');
    });
    late int e = 1;
    return e;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelperDocumentoCredito.db();
    return db.query('documento', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelperDocumentoCredito.db();
    return db.query('documento', where: "id = ?", whereArgs: [id], limit: 1);
  }
}
