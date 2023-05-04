// ignore_for_file: avoid_print

import 'package:sqflite/sqflite.dart' as sql;
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/forma_pago_model.dart';
import '../routes/api_rutas.dart';
//Services

//Models

class SQLHelperFormaPago {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE formaPago(
          custom_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
          id INTEGER ,
          nombre TEXT,
          database_id INTEGER,
          bancarizado BOOLEAN,
          depositable BOOLEAN,
          mostrar_pv BOOLEAN,
          requiere_referencia BOOLEAN,
          factor_comision TEXT,
          codigo_sat TEXT,
          cuenta_contable TEXT,
          estatus BOOLEAN,
          created_at TEXT,
          updated_at TEXT,
          metodo_pago TEXT,
          forma_pago TEXT,
          moneda TEXT,
          tipo_cambio_default TEXT,
          permitir_cambio BOOLEAN
          downloaded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )""");
  }

  static Future<sql.Database> db() async {
    print('... CREATING DATABASE --> forma de pago ...');
    return sql.openDatabase('app_pos_formaPago.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      print('... CREATING A TABLE ...');
      await createTables(database);
      print('.. TABLE CREATED ..');
    });
  }

  static Future<int> getApiFormaPago() async {
    /* SE OBTINEN LOS DATOS DE LA API */
    final connJson = Uri.parse(api_formas_pago);
    List<FormaPagoModel> getprecios = [];
    var response = await http.get(connJson);

    String responseBody = response.body;
    var jsonBody = json.decode(responseBody);

    final db = await SQLHelperFormaPago.db();
    await db.delete('formaPago');

    for (var data in jsonBody) {
      getprecios.add(FormaPagoModel(
          data['id'],
          data['nombre'],
          data['database_id'],
          data['bancarizado'],
          data['depositable'],
          data['mostrar_pv'],
          data['requiere_referencia'],
          data['factor_comision'],
          data['codigo_sat'],
          data['cuenta_contable'],
          data['estatus'],
          data['created_at'],
          data['updated_at'],
          data['metodo_pago'],
          data['forma_pago'],
          data['moneda'],
          data['tipo_cambio_default'],
          data['permitir_cambio']));
    }

    getprecios.forEach((element) async {
      final data = {
        'id': element.id,
        'nombre': element.nombre,
        "database_id": element.database_id,
        "bancarizado": element.bancarizado,
        "depositable": element.depositable,
        "mostrar_pv": element.mostrar_pv,
        "requiere_referencia": element.requiere_referencia,
        "factor_comision": element.factor_comision,
        "codigo_sat": element.codigo_sat,
        "cuenta_contable": element.cuenta_contable,
        "estatus": element.estatus,
        "created_at": element.created_at,
        "updated_at": element.updated_at,
        "metodo_pago": element.metodo_pago,
        "forma_pago": element.forma_pago,
        "moneda": element.moneda,
        "tipo_cambio_default": element.tipo_cambio_default,
        "permitir_cambio": element.permitir_cambio
      };

      await db.insert('formaPago', data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
    });
    late int e = 1;
    print('... base de datos creada--> forma de pago ...');
    return e;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelperFormaPago.db();
    return db.query('formaPago', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelperFormaPago.db();
    return db.query('formaPago', where: "id = ?", whereArgs: [id], limit: 1);
  }

  //DELETE METHOD
}
