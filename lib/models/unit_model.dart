import 'package:equatable/equatable.dart';

class UnitModel extends Equatable {
  final String id;
  final String unitId;
  final double temperature;
  final double humidity;
  final int battery;
  final int? currentTransaction;
  final List<int> orderNum;

  const UnitModel({
    required this.id,
    required this.unitId,
    required this.temperature,
    required this.humidity,
    required this.battery,
    required this.currentTransaction,
    required this.orderNum,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['_id'],
      unitId: json['unitId'],
      temperature: json['temperature'].toDouble(),
      humidity: json['humidity'].toDouble(),
      battery: json['batteryCapacity'],
      currentTransaction: json['currentTransaction'],
      orderNum: json['orderNum'] != null
          ? List<int>.from(
              json['orderNum'].map((e) => e),
            )
          : [],
    );
  }

  toJson() {
    return {
      '_id': id,
      'unitId': unitId,
      'temperature': temperature,
      'humidity': humidity,
      'battery': battery,
      'currentTransaction': currentTransaction,
      'orderNum': orderNum,
    };
  }

  @override
  List<Object?> get props => [
        id,
        unitId,
        temperature,
        humidity,
        battery,
        currentTransaction,
        orderNum,
      ];
}
