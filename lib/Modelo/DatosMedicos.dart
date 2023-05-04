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
      this.pregunta6,
      this.calorias,
      this.pregunta7,
      this.alimentos,
      this.nombres});

  DatosMedicos.fromMap(Map<String, dynamic> item)
      : pregunta1 = item["pregunta1"],
        pregunta2 = item["pregunta2"],
        pregunta3 = item["pregunta3"],
        pregunta4 = item["pregunta4"],
        pregunta5 = item["pregunta5"],
        pregunta6 = item["pregunta6"],
        calorias = item["calorias"],
        pregunta7 = item["pregunta7"],
        alimentos = item["alimentos"],
        nombres = item["nombres"];

  Map<String, dynamic> toMap() {
    return {
      'pregunta1': pregunta1,
      'pregunta2': pregunta2,
      'pregunta3': pregunta3,
      'pregunta4': pregunta4,
      'pregunta5': pregunta5,
      'pregunta6': pregunta6,
      'calorias': calorias,
      'pregunta7': pregunta7,
      'alimentos': pregunta5,
      'nombres': nombres
    };
  }
}
