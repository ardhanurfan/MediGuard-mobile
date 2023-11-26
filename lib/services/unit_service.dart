import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mediguard/models/delivery_cat_model.dart';
import 'package:mediguard/models/transaction_model.dart';
import 'package:mediguard/models/unit_model.dart';
import 'package:mediguard/services/token_service.dart';
import 'package:mediguard/services/url_service.dart';

class UnitService {
  Future<UnitModel> connectMediGuard({
    required String unitId,
  }) async {
    late Uri url = UrlService.api('unit/connect');
    var headers = {
      'Content-Type': 'application/json',
      // 'Authorization': await UserService.getTokenPreference() ?? '',
    };

    var body = {
      'unitId': unitId,
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
      encoding: Encoding.getByName('utf-8'),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'] as Map<String, dynamic>;
      await TokenService.setTokenPreference("unit", unitId);
      return UnitModel.fromJson(data);
    } else {
      throw "Invalid code. Try using the mediguard QR.";
    }
  }

  Future<List<TransactionModel>> getTransactionById(
      {required String unitId}) async {
    late Uri url = UrlService.api('unit/transactionUnits/$unitId');

    var headers = {
      'Content-Type': 'application/json',
    };

    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'] as List;
      if (data.isNotEmpty) {
        return (data.first['transactionUnits'] as List)
            .map((transaction) => TransactionModel.fromJson(transaction))
            .toList();
      } else {
        throw "Data not found";
      }
    } else {
      throw "Get data failed";
    }
  }

  Future<UnitModel> getUnitById({required String unitId}) async {
    late Uri url = UrlService.api('unit/transactionUnits/$unitId');

    var headers = {
      'Content-Type': 'application/json',
    };

    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'] as List;
      if (data.isNotEmpty) {
        var dataUnit = data.first as Map<String, dynamic>;
        return UnitModel.fromJson(dataUnit);
      } else {
        throw "MediGuard Not Assigned";
      }
    } else {
      throw "Get data failed";
    }
  }

  Future<DeliveryCatModel> getDeliveryCat({required int orderNum}) async {
    late Uri url = UrlService.api('deliveryCat/get/$orderNum');

    var headers = {
      'Content-Type': 'application/json',
    };

    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'] as Map<String, dynamic>;
      if (data.isNotEmpty) {
        return DeliveryCatModel.fromJson(data);
      } else {
        throw "Data not found";
      }
    } else {
      throw "Get data failed";
    }
  }

  Future<bool> lockMediGuard({
    required String unitId,
    required bool value,
  }) async {
    late Uri url = UrlService.api('unit/device-lock');
    var headers = {
      'Content-Type': 'application/json',
      // 'Authorization': await UserService.getTokenPreference() ?? '',
    };

    var body = {
      'device': unitId,
      'value': value.toString(),
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
      encoding: Encoding.getByName('utf-8'),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      if (data) {
        return true;
      } else {
        throw "MediGuard not found";
      }
    } else {
      throw "Change lock state MediGuard Failed";
    }
  }

  Future<bool> nextDestination({
    required String unitId,
  }) async {
    late Uri url = UrlService.api('unit/next');
    var headers = {
      'Content-Type': 'application/json',
      // 'Authorization': await UserService.getTokenPreference() ?? '',
    };

    var body = {
      'unitId': unitId,
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
      encoding: Encoding.getByName('utf-8'),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      if (data != null) {
        return true;
      } else {
        return false;
      }
    } else {
      throw "Next Destination Failed";
    }
  }
}
