import 'package:flutter/material.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:news_app/core/consatnt/utils.dart';
import 'package:news_app/core/network/api%20handling/handle_status_code.dart';

class ApiProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.timeout = Duration(seconds: 5);

    /// You can also set base configuration / behavior through the interceptor feature
    /// available inside this function too!
  }

  Future<dynamic> gets<JSON, DartModel>(String url, {Map<String, dynamic>? query, Map<String, String>? headers, required DartModel Function(JSON theComingJson)? makingTheFromJsonPossible}) async {
    var responseJson;
    try {
      httpClient.errorSafety = false;
      //print requset
      print(url);
      print(query.toString());

      //send the requset with the querey
      Response<dynamic> model = await get(url, query: query, headers: headers);

      //hadnle status code
      responseJson = response(model);

      //apply from json function
      return makingTheFromJsonPossible!(responseJson);
    } catch (e, s) {
      //handling error
      print(".................. Error Type:  " + e.runtimeType.toString() + '  .................');
      print('Errorrrrrrrrrr' + e.toString());
      print(s);
      if (e is GetHttpException) {
        if (e.message.contains('SocketException'))
          Utils.showGetXToast(title: 'Error', message: 'No Internet Connection', toastColor:  Colors.red);
        else
          Utils.showGetXToast(title: 'Error', message: e.message, toastColor: Colors.red);
        return 'error';
      } else {
        Utils.showGetXToast(title: 'Error', message: e.toString(), toastColor: Colors.red);
        print("UNEXPECTED ERROR");
        return 'error';
      }
      // return  NetWorkExceptions.getApiException(e);
    }
  }


}