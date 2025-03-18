class Validators {

  static String? validateTransactionAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'El monto es obligatorio';
    }
    final num? amount = num.tryParse(value);
    if (amount == null) {
      return 'El monto debe ser un número válido';
    }
    if (amount < 1000) {
      return 'El monto mínimo es 1,000';
    }
    if (amount > 100000) {
      return 'El monto máximo es 100,000';
    }
    return null; 
  }


  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'El número de teléfono es obligatorio';
    }
    if (!RegExp(r'^[3]\d{9}$').hasMatch(value)) {
      return 'El número debe empezar en "3" y tener 10 dígitos numéricos';
    }
    return null;
  }
}
