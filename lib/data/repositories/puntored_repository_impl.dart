import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:puntored/data/datasource/remote_datasource.dart';
import 'package:puntored/data/exception.dart';
import 'package:puntored/data/failure.dart';
import 'package:puntored/domain/entities/proveedores_recarga_entity.dart';
import 'package:puntored/domain/repositories/puntored_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PuntoredRepositoryImpl implements PuntoredRepository {
  final RemoteDataSource remoteDataSource;
  final storage = FlutterSecureStorage();

  PuntoredRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ProveedorRecargaEntity>>>
  getProveedoresRecarga() async {
    try {
      final result = await remoteDataSource.getProveedoresRecarga();
      return Right(result);
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
      return const Left(ServerFailure('Error en el servidor'));
    } on SocketException {
      return const Left(ConnectionFailure('Error de conexión a la red'));
    }
  }
}
