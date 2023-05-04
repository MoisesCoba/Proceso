// ignore_for_file: avoid_print

import 'package:sqflite/sqflite.dart' as sql;
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/lista_contacto_model.dart';
import '../routes/api_rutas.dart';
//Services

//Models

class SQLHelperListaContacto {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE listaContacto(
          custom_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
          id INTEGER,
          nombre TEXT,
          estatus BOOLEAN,
          created_at TEXT,
          updated_at TEXT,
          downloaded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )""");
  }

  static Future<sql.Database> db() async {
    print('... CREATING DATABASE --> lista contactos ...');
    return sql.openDatabase('app_pos_listaContacto.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      print('... CREATING A TABLE ...');
      await createTables(database);
      print('.. TABLE CREATED ..');
    });
  }

  static Future<int> getApiListaContacto() async {
    /* SE OBTINEN LOS DATOS DE LA API */
    final connJson = Uri.parse(api_lista_contactos);
    List<ListaContactoModel> getLista = [];
    var response = await http.get(connJson);

    String responseBody = response.body;
    var jsonBody = json.decode(responseBody);

    final db = await SQLHelperListaContacto.db();
    //await db.delete('listaContacto');

    for (var data in jsonBody) {
      getLista.add(ListaContactoModel(
        data['id'],
        data['nombre'],
        data['estatus'],
        data['created_at'],
        data['updated_at'],
      ));
    }

    getLista.forEach((element) async {
      final data = {
        'id': element.id,
        'nombre': element.nombre,
        'estatus': element.estatus,
        'created_at': element.created_at,
        'updated_at': element.updated_at
      };

      await db.insert('listaContacto', data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
    });
    late int e = 1;
    print('.. TABLE CREATED lista contactos ..');
    return e;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelperListaContacto.db();
    return db.query('listaContacto', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelperListaContacto.db();
    return db.query('listaContacto',
        where: "id = ?", whereArgs: [id], limit: 1);
  }

  //DELETE METHOD
}
