import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puntored/data/failure.dart';
import 'package:puntored/domain/entities/purchase_request_entity.dart';
import 'package:puntored/domain/entities/recharge_result_entity.dart';
import 'package:puntored/domain/use_cases/get_puntored_api.dart';

import '../../../../../../data/repositories/database_repository_impl.dart';
import '../../../../../../dependecy_injection/injection.dart';
import '../../../../../../domain/repositories/local_repository.dart';
import '../../../../../../domain/use_cases/get_local_use_cases.dart';
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
      (response) async {
              final GetLocalUseCases localUseCases;
              GetLocalUseCases repository =
            GetLocalUseCases(repository: LocalRepository());
        state = PurchaseSuccess(response.message!);

        // Guardar respuesta en la base de datos local
        final rechargeResult = RechargeResultEntity(
          username: "alejo",
          transaccionId: response.transactionalID ?? '',
          status: response.message!,
          supply: purchase.supplierId,
          amount: purchase.value,
          number: purchase.cellPhone,
        );

        final saveResult = await localUseCases.saveRechargeResult(rechargeResult);
        saveResult.fold(
          (failure) => print('Error al guardar en local: ${failure.message}'),
          (_) async {
            // Consultar e imprimir por consola los registros locales
            final localResults = await localUseCases.getRechargeResultsByUser("alejo");
            localResults.fold(
              (failure) => print('Error al obtener registros locales: ${failure.message}'),
              (list) {
                print('Registros almacenados en local para el usuario ${"alejo"}:');
                for (var item in list) {
                  print(
                      'ID: ${item.transaccionId}, Estado: ${item.status}, Número: ${item.number}, Monto: ${item.amount}');
                }
              },
            );
          },
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

final purchaseProvider = StateNotifierProvider<PurchaseNotifier, PurchaseState>(
  (ref) => locator<PurchaseNotifier>(),
);