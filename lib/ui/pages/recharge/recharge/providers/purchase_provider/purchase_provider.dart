import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puntored/data/failure.dart';
import 'package:puntored/domain/entities/purchase_request_entity.dart';
import 'package:puntored/domain/entities/recharge_result_entity.dart';
import 'package:puntored/domain/use_cases/get_puntored_api.dart';
import '../../../../../../dependecy_injection/injection.dart';
import '../../../../../../domain/use_cases/get_local_use_cases.dart';
import 'purchase_state.dart';

class PurchaseNotifier extends StateNotifier<PurchaseState> {
  final GetPuntoredApi getPuntoredApi;
  final GetLocalUseCases getLocalUseCases;

  PurchaseNotifier(this.getPuntoredApi, this.getLocalUseCases) : super(PurchaseIdle()) {
    _loadLocalRecharges();
  }

  // Cargar recargas locales al iniciar
  Future<void> _loadLocalRecharges() async {
    final localResults = await getLocalUseCases.getRechargeResultsByUser("duvan");
    localResults.fold(
      (failure) => print('Error al cargar recargas locales: ${failure.message}'),
      (list) {
        state = PurchaseSuccess("Recargas cargadas", list);
      },
    );
  }

  Future<void> realizarCompra(PurchaseRequestEntity purchase) async {
    state = PurchaseLoading();
    final result = await getPuntoredApi.postPurchase(purchase);
    result.fold(
      (failure) {
        state = PurchaseError(_mapFailureToMessage(failure));
      },
      (response) async {
        // Guardar en SQLite
        final rechargeResult = RechargeResultEntity(
          username: "duvan",
          transaccionId: response.transactionalID ?? '',
          status: response.message!,
          supply: purchase.supplierId,
          amount: purchase.value,
          number: purchase.cellPhone,
        );

        final saveResult = await getLocalUseCases.saveRechargeResult(rechargeResult);
        saveResult.fold(
          (failure) => print('Error al guardar en local: ${failure.message}'),
          (_) async => _loadLocalRecharges(), // Recargar lista local
        );
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) return 'Error en el servidor';
    if (failure is ConnectionFailure) return 'Error de conexión';
    return 'Error desconocido';
  }
}

// Proveedor del PurchaseNotifier
final purchaseProvider = StateNotifierProvider<PurchaseNotifier, PurchaseState>(
  (ref) => locator<PurchaseNotifier>(),
);