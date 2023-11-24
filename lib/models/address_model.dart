import 'package:equatable/equatable.dart';

class AddressModel extends Equatable {
  final String id;
  final String kodeCabang;
  final int custNum;
  final String alamat;
  final String channel;
  final double latitude;
  final double longitude;

  const AddressModel({
    required this.id,
    required this.kodeCabang,
    required this.custNum,
    required this.channel,
    required this.alamat,
    required this.latitude,
    required this.longitude,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] ?? "",
      kodeCabang: json['kodeCabang'] ?? "",
      custNum: json['custNum'],
      channel: json['channel'] ?? "",
      alamat: json['alamat'] ?? "",
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  @override
  List<Object?> get props =>
      [id, kodeCabang, custNum, channel, alamat, latitude, longitude];
}
