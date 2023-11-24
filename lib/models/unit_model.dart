import 'package:equatable/equatable.dart';

class UnitModel extends Equatable {
  final String id;
  final String unitId;
  final int temperature;
  final int humidity;
  final int battery;
  final int currentTransaction;

  const UnitModel({
    required this.id,
    required this.unitId,
    required this.temperature,
    required this.humidity,
    required this.battery,
    required this.currentTransaction,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['_id'],
      unitId: json['unitId'],
      temperature: json['temperature'],
      humidity: json['humidity'],
      battery: json['batteryCapacity'],
      currentTransaction: json['currentTransaction'],
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
      ];
}
