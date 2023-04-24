// ignore_for_file: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ConexionDB {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'scd.db'),
      onCreate: (db, version) async {
        tablaUsuario(db);
        //tablaHistorial(db);
        //triggerInsertar(db);
        //triggerActualizar(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion == 1) {
          updateTable(db);
          tablaUsuario(db);
        }
      },
      onDowngrade: onDatabaseDowngradeDelete,
      readOnly: false,
      singleInstance: true,
      onConfigure: onConfigure,
      version: 1,
    );
  }

  Future onConfigure(Database bd) async {
    await bd.execute('PRAGMA foreign_keys = ON');
  }

  void updateTable(Database bd) {
    bd.execute('ALTER TABLE Company ADD description TEXT');
  }

  void tablaUsuario(Database bd) {
    bd.execute('DROP TABLE IF EXISTS Usuarios');
    bd.execute('''CREATE TABLE Usuarios(
            nombres	TEXT NOT NULL,
            apellidos	TEXT NOT NULL,
            fecha_nacimiento TEXT NOT NULL, 
            genero TEXT NOT NULL,
            peso	REAL NOT NULL,
            estatura	REAL NOT NULL,
            imagen TEXT NOT NULL,
            PRIMARY KEY(nombres))''');
  }

   void tablaMedicamento(Database bd) {
    bd.execute('DROP TABLE IF EXISTS Medicamentos');
    bd.execute('''CREATE TABLE Medicamentos(
            id	INTEGER,
            nombres	TEXT NOT NULL,
            cantidad	TEXT NOT NULL
            tipo	TEXT NOT NULL, 
            genero	TEXT NOT NULL,
            peso	REAL NOT NULL,
            estatura	REAL NOT NULL,
            PRIMARY KEY(id AUTOINCREMENT))''');
  }

  void tablaDatosMedicos(Database bd) {
    bd.execute('DROP TABLE IF EXISTS DatosMedicos');
    bd.execute('''CREATE TABLE DatosMedicos(
            id	INTEGER,
            nombres	TEXT NOT NULL,
            pregunta1	BOOLEAN NOT NULL,
            pregunta2	BOOLEAN NOT NULL
            pregunta3	BOOLEAN NOT NULL,
            pregunta4	BOOLEAN NOT NULL,
            pregunta5	BOOLEAN NOT NULL
            pregunta6	BOOLEAN NOT NULL, 
            calorias	REAL NOT NULL,
            pregunta7	BOOLEAN NOT NULL
            alimentos	TEXT NOT NULL,
            FOREIGN KEY(nombres) REFERENCES Usuarios(nombre) ON DELETE CASCADE,
            PRIMARY KEY(id AUTOINCREMENT))''');
            
  }

  void tablaHistorial(Database bd) {
    bd.execute('DROP TABLE IF EXISTS Historial');
    bd.execute('''CREATE TABLE Historial(
            id	INTEGER,
            nombres	TEXT NOT NULL,
            genero	TEXT NOT NULL,
            edad	TEXT NOT NULL,
            peso	REAL NOT NULL,
            estatura	REAL NOT NULL,
            fecha	TEXT NOT NULL,
            FOREIGN KEY(nombres) REFERENCES Usuarios(nombres) ON DELETE CASCADE,
            PRIMARY KEY(id AUTOINCREMENT))''');
  }

  void triggerInsertar(Database bd) {
    bd.execute('DROP TRIGGER IF EXISTS historialI');
    bd.execute('''CREATE TRIGGER historialI
            AFTER UPDATE ON Usuarios
            FOR EACH ROW
            BEGIN
            INSERT INTO Historial(nombre, genero, edad, peso, estatura, fecha)
            VALUES(new.nombre, new.genero, new.edad, new.peso, new.estatura, DATETIME('NOW'));
            END''');
  }

  void triggerActualizar(Database bd) {
    bd.execute('DROP TRIGGER IF EXISTS historialA');
    bd.execute('''CREATE TRIGGER historialA
            AFTER INSERT ON Usuarios
            FOR EACH ROW
            BEGIN
            INSERT INTO Historial(nombre, genero, edad, peso, estatura, fecha)
            VALUES(new.nombre, new.genero, new.edad, new.peso, new.estatura, DATETIME('NOW'));
            END''');
  }
}
