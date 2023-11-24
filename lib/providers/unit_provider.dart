import 'package:flutter/material.dart';
import 'package:mediguard/models/delivery_cat_model.dart';
import 'package:mediguard/models/unit_model.dart';
import 'package:mediguard/services/unit_service.dart';

class UnitProvider extends ChangeNotifier {
  late UnitModel _mediguard;
  late DeliveryCatModel _deliveryCat;

  UnitModel get mediguard => _mediguard;
  DeliveryCatModel get deliveryCat => _deliveryCat;

  set setDataSensor(UnitModel sensor) {
    _mediguard = sensor;
    notifyListeners();
  }

  Future<bool> connect({required String unitId}) async {
    try {
      _mediguard = await UnitService().connectMediGuard(unitId: unitId);
      _deliveryCat = await UnitService()
          .getDeliveryCat(orderNum: _mediguard.currentTransaction);
      notifyListeners();
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
