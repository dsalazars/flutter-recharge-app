import 'package:dartz/dartz.dart';
import 'package:puntored/data/failure.dart';
import 'package:puntored/domain/entities/recharge_result_entity.dart';

abstract class LocalRepository {
  
  Future<Either<Failure, void>> saveRechargeResult(RechargeResultEntity result);
  Future<Either<Failure, List<RechargeResultEntity>>> getRechargeResultsByUser(String username);
}
