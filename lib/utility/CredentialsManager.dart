import 'dart:convert';
import 'package:flutter/services.dart';

enum WHICH_TOKEN{
  trefle,
}

class CredentialsManager{
  CredentialsManager._();

  static Future<String> getTokenAsync(WHICH_TOKEN token) async{
    String tokenName = _getTokenKeyString(token);
    final String response = await rootBundle.loadString('assets/json/credentials.json');
    final data = await json.decode(response);
    if(!data[tokenName].isEmpty){
      return data[tokenName];
    }

    return "";
  }

  static String _getTokenKeyString(WHICH_TOKEN token){
    switch(token){
      case WHICH_TOKEN.trefle:
        return "TREFLE_TOKEN";
      
      default: 
        return "";
    }
  }
}