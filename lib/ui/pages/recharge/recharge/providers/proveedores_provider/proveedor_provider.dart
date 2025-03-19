import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../data/failure.dart';
import '../../../../../../dependecy_injection/injection.dart';
import '../../../../../../domain/use_cases/get_puntored_api.dart';
import 'proveedores_state.dart';



// class LoginNotifier extends StateNotifier<LoginState> {
//   final GetPuntoredApi getPuntoredApi; 

//   LoginNotifier(this.getPuntoredApi) : super(LoginState());


class ProveedoresNotifier extends StateNotifier<ProveedoresState> {
  final GetPuntoredApi getPuntoredApi;

  ProveedoresNotifier(this.getPuntoredApi) : super(ProveedoresLoading()) {
    cargarProveedores();
  }

  Future<void> cargarProveedores() async {
    state = ProveedoresLoading();
    final result = await getPuntoredApi.getSuppliers();
    result.fold(
      (failure) {
        state = ProveedoresError(_mapFailureToMessage(failure));
      },
      (proveedores) {
        state = ProveedoresLoaded(proveedores);
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) return 'Error en el servidor';
    if (failure is ConnectionFailure) return 'Error de conexión';
    return 'Error desconocido';
  }
}


final proveedoresProvider = StateNotifierProvider<ProveedoresNotifier, ProveedoresState>(
  (ref) => locator<ProveedoresNotifier>(),
);
