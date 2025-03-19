import 'package:dartz/dartz.dart';
import 'package:puntored/data/datasource/local_datasource.dart';

import 'package:puntored/data/failure.dart';
import 'package:puntored/domain/entities/recharge_result_entity.dart';
import 'package:puntored/domain/repositories/local_repository.dart';


class LocalRepositoryImpl implements LocalRepository {
  late LocalDataSource localDataSource;

  LocalRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, void>> saveRechargeResult(RechargeResultEntity result) {
    return localDataSource.saveRechargeResult(result);
  }

  @override
  Future<Either<Failure, List<RechargeResultEntity>>> getRechargeResultsByUser(String username) {
    return localDataSource.getRechargeResultsByUser(username);
  }
}
