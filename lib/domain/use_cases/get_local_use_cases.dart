
import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../entities/recharge_result_entity.dart';
import '../repositories/local_repository.dart';

class GetLocalUseCases {
  final LocalRepository repository;

  GetLocalUseCases(this.repository);

  Future<Either<Failure, void>> saveRechargeResult(RechargeResultEntity result) {
    return repository.saveRechargeResult(result);
  }

  Future<Either<Failure, List<RechargeResultEntity>>> getRechargeResultsByUser(String username) {
    return repository.getRechargeResultsByUser(username);
  }
}
