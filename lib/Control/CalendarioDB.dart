// ignore_for_file: file_names
import 'package:diabetes_al_dia/Modelo/medicamentos_model.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages

import 'package:flutter/material.dart';

import 'ConexionDB.dart';

class CalendarioDB extends ConexionDB {
  find(dia) async {
    final Database db = await initializeDB();
    List<Map<String, dynamic>> res2=[];
    List<Map<String, dynamic>> res= await db.rawQuery('''
    SELECT *
    FROM Alarmas al
    INNER JOIN Medicamentos me ON al.medicamento = me.nombre
    WHERE al.dias LIKE ?
  ''', ['%$dia%']);
    print(res);
    print("Agenda");
    return res.isNotEmpty ? res : res2;
  }

  Future<void> delete(String nombre) async {
    final Database db = await initializeDB();
    try {
      await db.delete("Alarmas", where: "nombre = ?", whereArgs: [nombre]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  Future<int> update(Medicamentos note) async {
    final Database db = await initializeDB();
    return db
        .update("Alarmas", note.toMap(), where: 'nombre = ?', whereArgs: [note.nombre]);
  }

}
