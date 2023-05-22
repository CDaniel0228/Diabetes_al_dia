// ignore_for_file: file_names
class AlarmasModel {
  String? dias;
  String? fechaInicio;
  String? hora;
  String? duracion;
  String? medicamento;

  AlarmasModel({
      this.dias,
      this.fechaInicio,
      this.hora,
      this.duracion,
      this.medicamento});
      
  AlarmasModel.fromMap(Map<String, dynamic> item)
      : dias = item["dias"],
        fechaInicio = item["fecha_inicio"],
        hora = item["hora"],
        duracion = item["duracion"],
        medicamento = item["medicamento"];

  Map<String, dynamic> toMap() {
    return {
      'dias': dias,
      'fecha_inicio': fechaInicio,
      'hora': hora,
      'duracion': duracion,
      'medicamento': medicamento,
    };
  }
}
