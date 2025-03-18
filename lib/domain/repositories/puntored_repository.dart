
import 'package:dartz/dartz.dart';
import 'package:puntored/data/failure.dart';
import 'package:puntored/domain/entities/proveedores_recarga_entity.dart';



abstract class PuntoredRepository {
    Future<Either<Failure, List<ProveedorRecargaEntity>>> getProveedoresRecarga();
    Future<Either<Failure, String>> login(String user, String password);
}