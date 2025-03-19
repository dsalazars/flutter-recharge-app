import '../../domain/entities/purchase_response_entity.dart';

class PurchaseResponseModel extends PurchaseResponseEntity {
  PurchaseResponseModel({
    super.cellPhone,
    super.value,
    super.message,
    super.transactionalID,
  });

  factory PurchaseResponseModel.fromJson(Map<String, dynamic> json) {
    return PurchaseResponseModel(
      message: json['message'],
      transactionalID: json['transactionalID'],
      cellPhone: json['cellPhone'],
      value: json['value'],
    );
  }
}
