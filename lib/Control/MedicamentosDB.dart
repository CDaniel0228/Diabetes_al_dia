// ignore_for_file: file_names
import 'package:diabetes_al_dia/Modelo/medicamentos_model.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages

import 'package:flutter/material.dart';

import 'ConexionDB.dart';

class MedicamentosDB extends ConexionDB {
  Future<int> crateItem(Medicamentos usuario) async {
    final Database db = await initializeDB();
    final id =  await db.insert('Medicamentos', usuario.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  find() async {
    final Database db = await initializeDB();
    List<Map<String, dynamic>> res= await db.query("Medicamentos");
    print(res);
    return res.isNotEmpty ? res : null;
  }

  Future<void> delete(String nombre) async {
    final Database db = await initializeDB();
    try {
      await db.delete("Medicamentos", where: "nombre = ?", whereArgs: [nombre]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  Future<int> update(Medicamentos note) async {
    final Database db = await initializeDB();
    return db
        .update("Medicamentos", note.toMap(), where: 'nombre = ?', whereArgs: [note.nombre]);
  }

}
