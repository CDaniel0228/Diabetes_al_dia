// ignore_for_file: file_names
class Medicamentos {
  String? nombre;
  String? tipo;
  int? cantidad;
  int? dosis;
  

  Medicamentos(
      {this.nombre,
      this.tipo,
      this.cantidad,
      this.dosis});
      
  Medicamentos.fromMap(Map<String, dynamic> item)
      : nombre = item["nombre"],
        tipo = item["tipo"],
        cantidad = item["cantidad"],
        dosis = item["dosis"];

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'tipo':tipo,
      'cantidad': cantidad,
      'dosis': dosis
    };
  }
}
