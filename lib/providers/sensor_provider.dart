import 'package:flutter/material.dart';
import 'package:mediguard/models/sensor_model.dart';

class SensorProvider extends ChangeNotifier {
  String _altitude = '0';
  String _temperature = '0';

  String get altitude => _altitude;
  String get temperature => _temperature;

  set setAltitude(String altitude) {
    _altitude = altitude;
    notifyListeners();
  }

  set setTemperature(String temperature) {
    _temperature = temperature;
    notifyListeners();
  }

  set setDataSensor(SensorModel sensor) {
    _altitude = sensor.altitude;
    _temperature = sensor.temperature;
    notifyListeners();
  }
}
