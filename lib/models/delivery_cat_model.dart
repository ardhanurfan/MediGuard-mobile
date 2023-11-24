import 'package:equatable/equatable.dart';

class DeliveryCatModel extends Equatable {
  final String kategoriPengiriman;
  final int minSuhu;
  final int maxSuhu;

  const DeliveryCatModel({
    required this.kategoriPengiriman,
    required this.maxSuhu,
    required this.minSuhu,
  });

  factory DeliveryCatModel.fromJson(Map<String, dynamic> json) {
    return DeliveryCatModel(
      kategoriPengiriman: json['kategoriPengiriman'],
      maxSuhu: json['maxSuhu'],
      minSuhu: json['minSuhu'],
    );
  }

  toJson() {
    return {
      'kategoriPengiriman': kategoriPengiriman,
      'maxSuhu': maxSuhu,
      'minSuhu': minSuhu,
    };
  }

  @override
  List<Object?> get props => [kategoriPengiriman, maxSuhu, minSuhu];
}
