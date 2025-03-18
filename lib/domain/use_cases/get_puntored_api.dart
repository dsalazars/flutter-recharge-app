import 'package:dartz/dartz.dart';
import 'package:puntored/data/failure.dart';
import 'package:puntored/domain/entities/proveedores_recarga_entity.dart';
import 'package:puntored/domain/repositories/puntored_repository.dart';

class GetPuntoredApi {
  final PuntoredRepository repository;

  GetPuntoredApi(this.repository);

  Future<Either<Failure, List<ProveedorRecargaEntity>>> getProveedoresRecarga() {
    return repository.getProveedoresRecarga();
  }

  Future<Either<Failure, String>> login(String user, String password) {
    return repository.login(user, password);
  }
}
