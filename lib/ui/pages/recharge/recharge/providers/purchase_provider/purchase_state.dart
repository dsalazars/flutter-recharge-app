abstract class PurchaseState {}

class PurchaseIdle extends PurchaseState {}

class PurchaseLoading extends PurchaseState {}

class PurchaseSuccess extends PurchaseState {
  final String message;

  PurchaseSuccess(this.message);
}

class PurchaseError extends PurchaseState {
  final String message;

  PurchaseError(this.message);
}
