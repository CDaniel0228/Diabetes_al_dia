import 'package:sqflite/sqflite.dart';
import '../Modelo/Usuario.dart';
import 'ConexionDB.dart';

class HistorialDB extends ConexionDB{
  Future<List<Usuario>> getItems(nombre) async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult;
    try{
    queryResult =  await db.query("Historial", where: "nombre = ?", whereArgs: [nombre]);
        return queryResult.map((e) => Usuario.fromMap(e)).toList();

    }catch(err){
      return [];
    }
  }
}