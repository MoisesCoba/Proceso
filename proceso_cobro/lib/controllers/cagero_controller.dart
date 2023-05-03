import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'dart:convert';
import '../models/modelo.dart';
import '../routes/api_rutas.dart';
//Services

//Models

/* esta línea utiliza el método "execute" de la instancia de la base de datos para ejecutar una o
 más consultas SQL que crearán las tablas necesarias en la base de datos */
class SQLHelperCajeros {
  static Future<void> createTables(sql.Database database) async {
    print('... PROSSESING TABLE ...');
    await database.execute("""CREATE TABLE cajeros(
          custom_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          id INTEGER ,
          contacto_id INTEGER,
          user TEXT,
          password TEXT,
          almacen_id INTEGER,
          sucursal_id INTEGER,
          empresa_id INTEGER,
          cliente_id INTEGER,
          vendedor_id INTEGER,
          razon_social_id INTEGER,
          moneda TEXT,
          serie_venta TEXT,
          serie_cobro TEXT,
          created_at TEXT,
          updated_at TEXT
          user_id INTEGER,
          api_key_id INTEGER,
          cuenta_bancaria_id INTEGER,
          ticket TEXT,
          downloaded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )""");
    print('... TABLE CREATED SUCCESSFULY ...');
  }

//la función "db()"" abre la DB SQLite Y crear las tablas utilizando la función "createTables".
  static Future<sql.Database> db() async {
    print('... CREATING DATABASE ...');
    return sql.openDatabase('app_pos_cajeros.db', version: 1,
        //"ONCREATE" es una función anónima que se ejecutará cuando se cree una nueva base de datos o cuando se actualice su versión
        onCreate: (sql.Database database, int version) async {
      print('... CREATING A TABLE ...');
      await createTables(database);
      print('.. TABLE CREATED ..');
    });
  }

/*
consume una API en Flutter utilizando el paquete http y convierte los datos obtenidos de la API de formato JSON 
a objetos de Dart utilizando la clase json. 
*/
  static Future<int> getApiCajeros() async {
    print('... Consumiendo API ...');
    // Obtener los datos de la API
    final connJson = Uri.parse(apiContactoSinc);
    List<CajerosModel> getLineas = [];
    var response = await http.get(connJson);
    String responseBody = response.body;
    var jsonBody = json.decode(responseBody);

    print('... ABRIENDO BASE DE DATOS ...');
    final db = await SQLHelperCajeros.db();

    // Eliminar todos los datos de la tabla "cajeros"
    await db.delete('cajeros');

    print('... BUILDING LIST  B-) ...');
    for (var data in jsonBody) {
      if (data['cajeros'] == null) {
        print("no existe el cajero");
      } else {
        getLineas.add(CajerosModel(
            data['cajeros']['id'],
            data['cajeros']['contacto_id'],
            data['cajeros']['user'],
            data['cajeros']['password'],
            data['cajeros']['almacen_id'],
            data['cajeros']['sucursal_id'],
            data['cajeros']['empresa_id'],
            data['cajeros']['cliente_id'],
            data['cajeros']['vendedor_id'],
            data['cajeros']['razon_social_id'],
            data['cajeros']['moneda'],
            data['cajeros']['serie_venta'],
            data['cajeros']['serie_cobro'],
            data['cajeros']['created_at'],
            data['cajeros']['updated_at'],
            data['cajeros']['user_id'],
            data['cajeros']['api_key_id'],
            data['cajeros']['cuenta_bancaria_id'],
            data['cajeros']['ticket']));
      }
    }

    getLineas.forEach((element) async {
      final data = {
        'id': element.id,
        'contacto_id': element.contacto_id,
        'user': element.user,
        'password': element.password,
        'almacen_id': element.almacen_id,
        'sucursal_id': element.sucursal_id,
        'empresa_id': element.empresa_id,
        'cliente_id': element.cliente_id,
        'vendedor_id': element.vendedor_id,
        'razon_social_id': element.razon_social_id,
        'moneda': element.moneda,
        'serie_venta': element.serie_venta,
        'serie_cobro': element.serie_cobro,
        'created_at': element.created_at,
        'updated_at': element.updated_at,
        'user_id': element.user_id,
        'api_key_id': element.api_key_id,
        'cuenta_bancaria_id': element.cuenta_bancaria_id,
        'ticket': element.ticket
      };
      print('.. DATOS INSERTADOS ..');
      await db.insert('cajeros', data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
    });
    print('.. COMPLETE ..');

    late int e = 1;
    return e;
  }
  // obtiene todos los registros de una tabla en una base de datos SQLite utilizando el paquete sqflite en Flutter.

  static Future<List<Map<String, dynamic>>> getItemsCajero() async {
    final db = await SQLHelperCajeros.db();
    return db.query('cajeros', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelperCajeros.db();
    return db.query('cajeros', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<List> find(int id) async {
    final db = await SQLHelperCajeros.db();
    return db.query('cajeros', where: "id = ?", whereArgs: [id], limit: 1);
  }
}
