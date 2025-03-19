class RechargeResultEntity {
  final String username;
  final String transaccionId;
  final String status;
  final String supply;
  final String amount;
  final String number;

  RechargeResultEntity({
    required this.username,
    required this.transaccionId,
    required this.status,
    required this.supply,
    required this.amount,
    required this.number,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'transaccion_id': transaccionId,
      'status': status,
      'supply': supply,
      'amount': amount,
      'number': number,
    };
  }

  factory RechargeResultEntity.fromMap(Map<String, dynamic> map) {
    return RechargeResultEntity(
      username: map['username'],
      transaccionId: map['transaccion_id'],
      status: map['status'],
      supply: map['supply'],
      amount: map['amount'],
      number: map['number'],
    );
  }
}
