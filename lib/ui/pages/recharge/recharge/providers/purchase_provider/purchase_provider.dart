import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../data/failure.dart';
import '../../../../../../dependecy_injection/injection.dart';
import '../../../../../../domain/entities/purchase_request_entity.dart';
import '../../../../../../domain/use_cases/get_puntored_api.dart';
import 'purchase_state.dart';

class PurchaseNotifier extends StateNotifier<PurchaseState> {
  final GetPuntoredApi getPuntoredApi;

  PurchaseNotifier(this.getPuntoredApi) : super(PurchaseIdle());

  Future<void> realizarCompra(PurchaseRequestEntity purchase) async {
    state = PurchaseLoading();
    final result = await getPuntoredApi.postPurchase(purchase);
    result.fold(
      (failure) {
        state = PurchaseError(_mapFailureToMessage(failure));
      },
      (response) {
        state = PurchaseSuccess(response.message!);
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) return 'Error en el servidor';
    if (failure is ConnectionFailure) return 'Error de conexión';
    return 'Error desconocido';
  }
}

final purchaseProvider = StateNotifierProvider<PurchaseNotifier, PurchaseState>(
  (ref) => locator<PurchaseNotifier>(),
);
