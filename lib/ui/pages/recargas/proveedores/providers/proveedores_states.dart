import 'package:puntored/domain/entities/proveedores_recarga_entity.dart';

class RecargaState {
  final bool isLoading;
  final List<ProveedorRecargaEntity> suppliers;
  final String? errorMessage;

  RecargaState({
    this.isLoading = false,
    this.suppliers = const [],
    this.errorMessage,
  });

  RecargaState copyWith({
    bool? isLoading,
    List<ProveedorRecargaEntity>? suppliers,
    String? errorMessage,
  }) {
    return RecargaState(
      isLoading: isLoading ?? this.isLoading,
      suppliers: suppliers ?? this.suppliers,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}