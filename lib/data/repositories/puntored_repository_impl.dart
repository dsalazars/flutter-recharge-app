import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:puntored/data/datasource/remote_datasource.dart';
import 'package:puntored/data/exception.dart';
import 'package:puntored/data/failure.dart';
import 'package:puntored/domain/entities/proveedores_recarga_entity.dart';
import 'package:puntored/domain/repositories/puntored_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/entities/purchase_request_entity.dart';
import '../../domain/entities/purchase_response_entity.dart';
import '../model/proveedores_recarga_model.dart';
import '../model/purchase_request_model.dart';
import '../model/purchase_response_model.dart';

class PuntoredRepositoryImpl implements PuntoredRepository {
  final RemoteDataSource remoteDataSource;
  final storage = FlutterSecureStorage();

  PuntoredRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ProveedorRecargaEntity>>>
  getSuppliers() async {
    try {
      final proveedores = await remoteDataSource
          .get<List<ProveedorRecargaModel>>(
            '/getSuppliers',
            (json) => ProveedorRecargaModel.fromJsonList(json),
          );
      return Right(proveedores);
    } on ServerException {
      return const Left(ServerFailure('Error en el servidor'));
    } on SocketException {  
      return const Left(ConnectionFailure('Error de conexión a la red'));
    }
  }

@override
Future<Either<Failure, PurchaseResponseEntity>> postPurchase(PurchaseRequestEntity data) async {
  try {
    final requestModel = PurchaseRequestModel(
      cellPhone: data.cellPhone,
      value: data.value,
      supplierId: data.supplierId,
    );

    final response = await remoteDataSource.post(
      '/buy',
      requestModel.toJson(),
      (json) => PurchaseResponseModel.fromJson(json),
    );

    return Right(response);
  } on ServerException {
    return const Left(ServerFailure('Error en el servidor'));
  } on SocketException {
    return const Left(ConnectionFailure('Error de conexión a la red'));
  }
}


  @override
  Future<Either<Failure, String>> login(String user, String password) async {
    try {
      final token = await remoteDataSource.post('/auth', {
        "user": user,
        "password": password,
      }, null);
      print('Token recibido: ${token['token']}');
      await storage.write(key: 'auth_token', value: token['token']);
      return Right(token['token']);
    } on ServerException {
      return const Left(ServerFailure('Nombre de usuario o contraseña incorrectos'));
    } on SocketException {
      return const Left(ConnectionFailure('Error de conexión a la red'));
    }
  }
}
