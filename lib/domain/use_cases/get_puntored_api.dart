import 'package:dartz/dartz.dart';
import 'package:puntored/data/failure.dart';
import 'package:puntored/domain/entities/proveedores_recarga_entity.dart';
import 'package:puntored/domain/repositories/puntored_repository.dart';

import '../entities/purchase_request_entity.dart';
import '../entities/purchase_response_entity.dart';


class GetPuntoredApi {
  final PuntoredRepository repository;

  GetPuntoredApi(this.repository);

  Future<Either<Failure, List<ProveedorRecargaEntity>>> getSuppliers() {
    return repository.getSuppliers();
  }

  Future<Either<Failure, String>> login(String user, String password) {
    return repository.login(user, password);
  }

  Future<Either<Failure, PurchaseResponseEntity>> postPurchase(PurchaseRequestEntity data) {
    return repository.postPurchase(data);
  }
}

