import 'package:equatable/equatable.dart';

class SensorModel extends Equatable {
  final String id;
  final String device;
  final String temperature;
  final String altitude;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SensorModel({
    required this.id,
    required this.device,
    required this.temperature,
    required this.altitude,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SensorModel.fromJson(Map<String, dynamic> json) {
    return SensorModel(
      id: json['_id'],
      device: json['device'],
      temperature: json['temperature'],
      altitude: json['altitude'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  toJson() {
    return {
      '_id': id,
      'device': device,
      'temperature': temperature,
      'altitude': altitude,
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
    };
  }

  @override
  List<Object?> get props =>
      [id, device, temperature, altitude, createdAt, updatedAt];
}
