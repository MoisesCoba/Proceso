import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'dart:convert';

import '../models/contacto_model.dart';
import '../routes/api_rutas.dart';

class SQLHelperContacto {
/* esta línea utiliza el método "execute" de la instancia de la base de datos para ejecutar una o
 más consultas SQL que crearán las tablas necesarias en la base de datos */

  static Future<void> createTables(sql.Database database) async {
    print('... PROSSESING TABLE ...');
    await database.execute("""CREATE TABLE contacto(
          custom_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          id INTEGER,
          nombre TEXT,
          direccion_id INTEGER,
          estatus BOOLEAN,
          created_at TEXT,
          updated_at TEXT,
          database_id INTEGER,
          lista_precio_cliente_id INTEGER,
          lista_precio_proveedor_id INTEGER,
          apellido_paterno TEXT,
          apellido_materno TEXT,
          persona_moral BOOLEAN,
          cliente BOOLEAN,
          proveedor BOOLEAN,
          deudor BOOLEAN,
          acreedor BOOLEAN,
          empleado BOOLEAN,
          vendedor BOOLEAN,
          cajero BOOLEAN,
          tecnico BOOLEAN,
          cuenta_contable_cliente INTEGER,
          cuenta_contable_proveedor INTEGER,
          cuenta_contable_deudor INTEGER,
          cuenta_contable_acreedor INTEGER,
          cuenta_contable_empleado INTEGER,
          cuenta_contable_cliente_comp INTEGER,
          cuenta_contable_proveedor_comp INTEGER,
          cuenta_contable_deudor_comp INTEGER,
          cuenta_contable_acreedor_comp INTEGER,
          cuenta_contable_empleado_comp INTEGER,
          cuenta_contable_cliente_anticipo INTEGER,
          cuenta_contable_proveedor_anticipo INTEGER,
          impuesto_perfil TEXT,
          nombre_completo TEXT,
          user_id INTEGER,
          impuesto_perfil_proveedor TEXT,
          socio BOOLEAN,
          dias_credito_cliente INTEGER,
          dias_credito_proveedor INTEGER,
          synchronization_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )""");
    print('... TABLE CREATED SUCCESSFULY ...');
  }

//la función "db()"" abre la DB SQLite Y crear las tablas utilizando la función "createTables".
  static Future<sql.Database> db() async {
    print('... CREATING DATABASE CONTACTO...');
    return sql.openDatabase('app_contacto.db', version: 1,
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
  static Future<int> getApiContactos() async {
    print('... Consumiendo API ...');
    // Obtener los datos de la API
    final connJson = Uri.parse(apiContactos);
    List<ContactoModelo> getLineas = [];
    var response = await http.get(connJson);
    String responseBody = response.body;
    var jsonBody = json.decode(responseBody);

    print('... ABRIENDO BASE DE DATOS ...');
    final db = await SQLHelperContacto.db();

    // Eliminar todos los datos de la tabla "cajeros"
    await db.delete('contacto');

    print('... BUILDING LIST  B-) ...');
    for (var data in jsonBody) {
      getLineas.add(ContactoModelo(
        data["id"],
        data["nombre"],
        data["direccion_id"],
        data["estatus"],
        data["created_at"],
        data["updated_at"],
        data["database_id"],
        data["lista_precio_cliente_id"],
        data["lista_precio_proveedor_id"],
        data["apellido_paterno"],
        data["apellido_materno"],
        data["persona_moral"],
        data["cliente"],
        data["proveedor"],
        data["deudor"],
        data["acreedor"],
        data["empleado"],
        data["vendedor"],
        data["cajero"],
        data["tecnico"],
        data["cuenta_contable_cliente"],
        data["cuenta_contable_proveedor"],
        data["cuenta_contable_deudor"],
        data["cuenta_contable_acreedor"],
        data["cuenta_contable_empleado"],
        data["cuenta_contable_cliente_comp"],
        data["cuenta_contable_proveedor_comp"],
        data["cuenta_contable_deudor_comp"],
        data["cuenta_contable_acreedor_comp"],
        data["cuenta_contable_empleado_comp"],
        data["cuenta_contable_cliente_anticipo"],
        data["cuenta_contable_proveedor_anticipo"],
        data["impuesto_perfil"],
        data["nombre_completo"],
        data["user_id"],
        data["impuesto_perfil_proveedor"],
        data["socio"],
        data["dias_credito_cliente"],
        data["dias_credito_proveedor"],
      ));
    }

    getLineas.forEach((element) async {
      final data = {
        'id': element.id,
        "nombre": element.nombre,
        "direccion_id": element.direccionId,
        "estatus": element.estatus,
        "created_at": element.createdAt,
        "updated_at": element.updatedAt,
        "database_id": element.databaseId,
        "lista_precio_cliente_id": element.listaPrecioClienteId,
        "lista_precio_proveedor_id": element.listaPrecioProveedorId,
        "apellido_paterno": element.apellidoPaterno,
        "apellido_materno": element.apellidoMaterno,
        "persona_moral": element.personaMoral,
        "cliente": element.cliente,
        "proveedor": element.proveedor,
        "deudor": element.deudor,
        "acreedor": element.acreedor,
        "empleado": element.empleado,
        "vendedor": element.vendedor,
        "cajero": element.cajero,
        "tecnico": element.tecnico,
        "cuenta_contable_cliente": element.cuentaContableCliente,
        "cuenta_contable_proveedor": element.cuentaContableProveedor,
        "cuenta_contable_deudor": element.cuentaContableDeudor,
        "cuenta_contable_acreedor": element.cuentaContableAcreedor,
        "cuenta_contable_empleado": element.cuentaContableEmpleado,
        "cuenta_contable_cliente_comp": element.cuentaContableClienteComp,
        "cuenta_contable_proveedor_comp": element.cuentaContableProveedorComp,
        "cuenta_contable_deudor_comp": element.cuentaContableDeudorComp,
        "cuenta_contable_acreedor_comp": element.cuentaContableAcreedorComp,
        "cuenta_contable_empleado_comp": element.cuentaContableEmpleadoComp,
        "cuenta_contable_cliente_anticipo":
            element.cuentaContableClienteAnticipo,
        "cuenta_contable_proveedor_anticipo":
            element.cuentaContableProveedorAnticipo,
        "impuesto_perfil": element.impuestoPerfil,
        "nombre_completo": element.nombreCompleto,
        "user_id": element.userId,
        "impuesto_perfil_proveedor": element.impuestoPerfilProveedor,
        "socio": element.socio,
        "dias_credito_cliente": element.diasCreditoCliente,
        "dias_credito_proveedor": element.diasCreditoProveedor,
      };

      await db.insert('contacto', data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
    });
    print('.. TABLE CREATED contactos..');

    late int e = 1;
    return e;
  }
  // obtiene todos los registros de una tabla en una base de datos SQLite utilizando el paquete sqflite en Flutter.

  static Future<List<Map<String, dynamic>>> getItemsContacto() async {
    final db = await SQLHelperContacto.db();
    return db.query('contacto', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelperContacto.db();
    return db.query('contacto', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<List> find(int id) async {
    final db = await SQLHelperContacto.db();
    return db.query('contacto', where: "id = ?", whereArgs: [id], limit: 1);
  }
}
