import 'package:puntored/domain/entities/proveedores_recarga_entity.dart';

class ProveedorRecargaModel extends ProveedorRecargaEntity {
  ProveedorRecargaModel({
    super.id,
    super.nombre,
  });

  factory ProveedorRecargaModel.fromJson(Map<String, dynamic> json) {
    return ProveedorRecargaModel(
      id: json["id"],
      nombre: json["name"], 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": nombre, 
    };
  }


  static List<ProveedorRecargaModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ProveedorRecargaModel.fromJson(json)).toList();
  }
}
