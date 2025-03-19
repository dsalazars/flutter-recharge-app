
import '../../domain/entities/purchase_request_entity.dart';

class PurchaseRequestModel extends PurchaseRequestEntity{
  PurchaseRequestModel({
    required super.cellPhone,
    required super.value,
    required super.supplierId,
  });


  Map<String, dynamic> toJson() {
    return {
      'cellPhone': cellPhone,
      'value': value,
      'supplierId': supplierId,
    };
  }
}
