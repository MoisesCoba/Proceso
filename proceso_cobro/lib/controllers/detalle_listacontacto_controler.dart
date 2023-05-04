// ignore_for_file: avoid_print

import 'package:sqflite/sqflite.dart' as sql;
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/detalle_listacontacto_model.dart';
import '../routes/api_rutas.dart';
//Services

//Models

class SQLHelperDetalleListaContacto {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE detalleListaContacto(
          custom_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
          id INTEGER,
          lista_contacto_id INTEGER,
          contacto_id INTEGER,
          estatus BOOLEAN,
          downloaded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )""");
  }

  static Future<sql.Database> db() async {
    print('... CREATING DATABASE --> detalleListaContacto ...');
    return sql.openDatabase('app_detalleListaContacto.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      print('... CREATING A TABLE ...');
      await createTables(database);
      print('.. TABLE CREATED ..');
    });
  }

  static Future<int> getApiDetalleListaContacto() async {
    /* SE OBTINEN LOS DATOS DE LA API */
    final connJson = Uri.parse(api_lista_contactos);
    List<DetalleListaContactoModel> getLista = [];
    var response = await http.get(connJson);

    String responseBody = response.body;
    var jsonBody = json.decode(responseBody);

    final db = await SQLHelperDetalleListaContacto.db();
    await db.delete('detalleListaContacto');

    for (var data in jsonBody) {
      if (data['detalles'] == []) {
        print("no existe el detalle");
      } else {
        for (int i = 0; i < data['detalles'].length; i++) {
          getLista.add(DetalleListaContactoModel(
              data['detalles'][i]['id'],
              data['detalles'][i]['lista_contacto_id'],
              data['detalles'][i]['contacto_id'],
              data['detalles'][i]['estatus']));
        }
      }
    }

    getLista.forEach((element) async {
      final data = {
        'id': element.id,
        'lista_contacto_id': element.lista_contacto_id,
        'contacto_id': element.contacto_id,
        'estatus': element.estatus
      };

      await db.insert('detalleListaContacto', data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
    });
    late int e = 1;
    print('.. TABLE CREATED detalle lista contactos..');
    return e;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelperDetalleListaContacto.db();
    return db.query('detalleListaContacto', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelperDetalleListaContacto.db();
    return db.query('detalleListaContacto',
        where: "id = ?", whereArgs: [id], limit: 1);
  }

  //DELETE METHOD
}
