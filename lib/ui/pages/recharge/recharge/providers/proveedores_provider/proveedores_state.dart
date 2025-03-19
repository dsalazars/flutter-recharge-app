import '../../../../../../domain/entities/proveedores_recarga_entity.dart';

abstract class ProveedoresState {
}

class ProveedoresLoading extends ProveedoresState {}


class ProveedoresLoaded extends ProveedoresState {
  final List<ProveedorRecargaEntity> proveedores;

  ProveedoresLoaded(this.proveedores);
}


class ProveedoresError extends ProveedoresState {
  final String message;

  ProveedoresError(this.message);
}