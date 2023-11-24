import 'package:equatable/equatable.dart';

import 'address_model.dart';

class TransactionModel extends Equatable {
  final int orderNum;
  final String unitId;
  final String distance;
  final String duration;
  final String vendor;
  final AddressModel address;

  const TransactionModel({
    required this.orderNum,
    required this.unitId,
    required this.distance,
    required this.duration,
    required this.vendor,
    required this.address,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      orderNum: json['orderNum'],
      unitId: json['unitId'] ?? "",
      distance: json['distance'] ?? "",
      duration: json['duration'] ?? "",
      vendor: json['vendor'] ?? "",
      address: AddressModel.fromJson(json['address']),
    );
  }

  @override
  List<Object?> get props => [];
}
