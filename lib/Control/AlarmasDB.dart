// ignore_for_file: file_names
import 'package:diabetes_al_dia/Modelo/alarmas_model.dart';
import 'package:diabetes_al_dia/Modelo/medicamentos_model.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages

import 'package:flutter/material.dart';

import 'ConexionDB.dart';

class AlarmasDB extends ConexionDB {
  Future<int> crateItem(AlarmasModel usuario) async {
    final Database db = await initializeDB();
    final id =  await db.insert('Alarmas', usuario.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  find() async {
    final Database db = await initializeDB();
    List<Map<String, dynamic>> res= await db.query("Alarmas");
    print(res);
    return res.isNotEmpty ? res : [];
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
