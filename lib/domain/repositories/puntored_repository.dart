
import 'package:dartz/dartz.dart';
import 'package:puntored/data/failure.dart';
import 'package:puntored/domain/entities/proveedores_recarga_entity.dart';
import '../entities/purchase_request_entity.dart';
import '../entities/purchase_response_entity.dart';



abstract class PuntoredRepository {
    Future<Either<Failure, String>> login(String user, String password);
    Future<Either<Failure, List<ProveedorRecargaEntity>>> getSuppliers();
    Future<Either<Failure, PurchaseResponseEntity>> postPurchase(PurchaseRequestEntity data);
    
}