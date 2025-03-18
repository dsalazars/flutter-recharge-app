import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import 'package:puntored/dependecy_injection/injection.dart';
import 'package:puntored/domain/use_cases/get_puntored_api.dart';
import 'package:puntored/ui/pages/authentication/login/providers/login_states.dart';
import 'package:puntored/data/failure.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => locator<LoginNotifier>(),
);

class LoginNotifier extends StateNotifier<LoginState> {
  final GetPuntoredApi getPuntoredApi; 

  LoginNotifier(this.getPuntoredApi) : super(LoginState());

  Future<void> login(String user, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final Either<Failure, String> result = await getPuntoredApi.login(user, password);

    result.fold(
      (failure) {
        // Si falla, actualiza el estado con el mensaje de error
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
      },
      (token) {
        // Si tiene éxito, guarda el token y actualiza el estado
        state = state.copyWith(
          isLoading: false,
          token: token,
        );
      },
    );
  }
}
