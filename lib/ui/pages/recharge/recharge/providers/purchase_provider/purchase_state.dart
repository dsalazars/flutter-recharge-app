import 'package:equatable/equatable.dart';
import 'package:puntored/domain/entities/recharge_result_entity.dart';

abstract class PurchaseState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PurchaseIdle extends PurchaseState {}

class PurchaseLoading extends PurchaseState {}

class PurchaseSuccess extends PurchaseState {
  final String message;
  final List<RechargeResultEntity> recharges;

  PurchaseSuccess(this.message, [this.recharges = const []]);

  @override
  List<Object?> get props => [message, recharges];
}

class PurchaseError extends PurchaseState {
  final String message;

  PurchaseError(this.message);

  @override
  List<Object?> get props => [message];
}
