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
        tablaDatosMedicos(db);
        tablaMedicamento(db);
        insertarMedicamentos(db);
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
            nombre	TEXT NOT NULL,
            tipo	TEXT NOT NULL, 
            cantidad INTEGER	 NOT NULL,
            dosis	INTEGER NOT NULL,
            PRIMARY KEY(nombre))''');
  }

  void insertarMedicamentos(Database bd) {
    bd.execute(''' INSERT INTO Medicamentos(nombre, tipo, cantidad, dosis) VALUES("Metformina", "Tableta", 1, 1 )''');
    bd.execute(''' INSERT INTO Medicamentos(nombre, tipo, cantidad, dosis) VALUES("Insulina", "Inyeccion", 1, 1 )''');
    bd.execute(''' INSERT INTO Medicamentos(nombre, tipo, cantidad, dosis) VALUES("Inibidores da DPP-4", "Capsula", 1, 1 )''');
    bd.execute(''' INSERT INTO Medicamentos(nombre, tipo, cantidad, dosis) VALUES("Inibidores do SGLT2", "Capsula", 1, 1 )''');
    bd.execute(''' INSERT INTO Medicamentos(nombre, tipo, cantidad, dosis) VALUES("Agonistas do receptor GLP-1", "Capsula", 1, 1 )''');
    bd.execute(''' INSERT INTO Medicamentos(nombre, tipo, cantidad, dosis) VALUES("Inibidores da alfa-glicosidase", "Capsula", 1, 1 )''');
    bd.execute(''' INSERT INTO Medicamentos(nombre, tipo, cantidad, dosis) VALUES("Tiazolidinedionas", "Tableta", 1, 1 )''');
    bd.execute(''' INSERT INTO Medicamentos(nombre, tipo, cantidad, dosis) VALUES("Meglitinidas", "Tableta", 1, 1 )''');
    bd.execute(''' INSERT INTO Medicamentos(nombre, tipo, cantidad, dosis) VALUES("Sulfonilureias", "Tableta", 1, 1 )''');
    bd.execute(''' INSERT INTO Medicamentos(nombre, tipo, cantidad, dosis) VALUES("Biguanidas", "Tableta", 1, 1 )''');
    bd.execute(''' INSERT INTO Medicamentos(nombre, tipo, cantidad, dosis) VALUES("Insulina lispro", "Inyeccion", 1, 1 )''');
    bd.execute(''' INSERT INTO Medicamentos(nombre, tipo, cantidad, dosis) VALUES("Insulina aspart", "Inyeccion", 1, 1 )''');
    bd.execute(''' INSERT INTO Medicamentos(nombre, tipo, cantidad, dosis) VALUES("Insulina glargina", "Inyeccion", 1, 1 )''');
    bd.execute(''' INSERT INTO Medicamentos(nombre, tipo, cantidad, dosis) VALUES("Insulina detemir", "Inyeccion", 1, 1 )''');
    bd.execute(''' INSERT INTO Medicamentos(nombre, tipo, cantidad, dosis) VALUES("Insulina degludeca", "Inyeccion", 1, 1 )''');
    bd.execute(''' INSERT INTO Medicamentos(nombre, tipo, cantidad, dosis) VALUES("Exenatida", "Inyeccion", 1, 1 )''');
    bd.execute(''' INSERT INTO Medicamentos(nombre, tipo, cantidad, dosis) VALUES("Liraglutida", "Inyeccion", 1, 1 )''');
    bd.execute(''' INSERT INTO Medicamentos(nombre, tipo, cantidad, dosis) VALUES("Dulaglutida", "Inyeccion", 1, 1 )''');
    bd.execute(''' INSERT INTO Medicamentos(nombre, tipo, cantidad, dosis) VALUES("Semaglutida", "Inyeccion", 1, 1 )''');
    bd.execute(''' INSERT INTO Medicamentos(nombre, tipo, cantidad, dosis) VALUES("Canagliflozina", "Tableta", 1, 1 )''');
    bd.execute(''' INSERT INTO Medicamentos(nombre, tipo, cantidad, dosis) VALUES("Dapagliflozina", "Tableta", 1, 1 )''');
    bd.execute(''' INSERT INTO Medicamentos(nombre, tipo, cantidad, dosis) VALUES("Empagliflozina", "Tableta", 1, 1 )''');
    bd.execute(''' INSERT INTO Medicamentos(nombre, tipo, cantidad, dosis) VALUES("Acarbosa", "Tableta", 1, 1 )''');
    bd.execute(''' INSERT INTO Medicamentos(nombre, tipo, cantidad, dosis) VALUES("Miglitol", "Tableta", 1, 1 )''');
    bd.execute(''' INSERT INTO Medicamentos(nombre, tipo, cantidad, dosis) VALUES("Pioglitazona", "Capsula", 1, 1 )''');
    bd.execute(''' INSERT INTO Medicamentos(nombre, tipo, cantidad, dosis) VALUES("Rosiglitazona", "Capsula", 1, 1 )''');
  }

  void tablaDatosMedicos(Database bd) {
    bd.execute('DROP TABLE IF EXISTS DatosMedicos');
    bd.execute('''CREATE TABLE DatosMedicos(
            pregunta1	BLOB NOT NULL,
            pregunta2	BLOB NOT NULL,
            pregunta3	BLOB NOT NULL,
            pregunta4	BLOB NOT NULL,
            pregunta5	BLOB NOT NULL,
            pregunta6	BLOB NOT NULL, 
            calorias	REAL NOT NULL,
            pregunta7	BLOB NOT NULL,
            alimentos	TEXT NOT NULL,
            nombres	TEXT NOT NULL UNIQUE,
            FOREIGN KEY(nombres) REFERENCES Usuarios(nombres) ON DELETE CASCADE)''');
            
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
