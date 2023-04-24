// ignore_for_file: file_names
class Usuario {
  String? nombres;
  String? apellidos;
  String? fecha_nacimiento;
  String? genero;
  double? peso;
  double? estatura;
  String? imagen;

  Usuario(
      {this.nombres,
      this.apellidos,
      this.fecha_nacimiento,
      this.genero,
      this.peso,
      this.estatura,
      this.imagen});
      
  Usuario.fromMap(Map<String, dynamic> item)
      : nombres = item["nombres"],
        apellidos = item["apellidos"],
        fecha_nacimiento = item["fecha_nacimiento"],
        genero = item["genero"],
        peso = item["peso"],
        estatura = item["estatura"],
        imagen = item["imagen"];

  Map<String, dynamic> toMap() {
    return {
      'nombres': nombres,
      'apellidos': apellidos,
      'fecha_nacimiento': fecha_nacimiento,
      'genero': genero,
      'peso': peso,
      'estatura': estatura,
      'imagen': imagen
    };
  }
}
