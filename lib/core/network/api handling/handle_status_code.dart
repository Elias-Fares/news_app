import 'package:flutter/material.dart';
import 'package:news_app/core/consatnt/utils.dart';
import 'package:news_app/core/network/api%20handling/CustomExeption.dart';

dynamic response(response) {
  //   print(response.body['code'] + 'aaaaaaaaaaaaaaaaaaa');
  print(response.statusCode.toString() + ' status code');

  // either return the response when the status code is 200  OR throw an exception and go to catch and then return error in catch
  switch (response.statusCode) {
    case 200:
      print(response.body);
      return response.body;

    case 400:
      Utils.showGetXToast(
          title: 'Error',
          message: response.body['message'],
          toastColor: Color.fromARGB(255, 202, 67, 67));
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
      Utils.showGetXToast(
          title: 'firas',
          message: response.body['message'],
          toastColor: Color.fromARGB(255, 202, 67, 67));
      throw FirasException(response.body.toString());
    case null:
      Utils.showGetXToast(
          title: 'Unexpected Error',
          message: 'StatusCode is Null',
          toastColor: Color.fromARGB(255, 202, 67, 67));
      throw BadRequestException(response.body.toString());

    default:
      Utils.showGetXToast(
          title: 'null', message: 'null', toastColor: Color.fromARGB(255, 202, 67, 67));
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
