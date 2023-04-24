// ignore_for_file: file_names

class DatosMedicos {
  bool? pregunta1;
  bool? pregunta2;
  bool? pregunta3;
  bool? pregunta4;
  bool? pregunta5;
  bool? pregunta6;
  double? calorias;
  bool? pregunta7;
  String? alimentos;
  String? nombres;

  DatosMedicos(
      {this.pregunta1,
      this.pregunta2,
      this.pregunta3,
      this.pregunta4,
      this.pregunta5,
      this.pregunta6});
      
  DatosMedicos.fromMap(Map<String, dynamic> item)
      : pregunta1 = item["nombres"],
        pregunta2 = item["apellidos"],
        pregunta3 = item["fecha_nacimiento"],
        pregunta4 = item["genero"],
        pregunta5 = item["peso"],
        pregunta6 = item["estatura"];

  Map<String, dynamic> toMap() {
    return {
      'nombres': pregunta1,
      'apellidos': pregunta1,
      'fecha_nacimiento': pregunta3,
      'genero': pregunta4,
      'peso': pregunta5,
      'estatura': pregunta6
    };
  }
}
