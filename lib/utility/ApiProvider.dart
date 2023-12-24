import 'dart:convert';
import 'package:arrose_ta_plante/Plant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arrose_ta_plante/utility/CredentialsManager.dart';
import 'package:http/http.dart' as http;

class ApiProvider{
  String _trefleToken = '';
  bool _tokenSet = false;
  final String _baseUrl = 'https://trefle.io/api/v1/plants';

  void Init(){
    getTrefleToken();
  }

  Future<void> getTrefleToken() async {
    _trefleToken = await CredentialsManager.getTokenAsync(WHICH_TOKEN.trefle);
    _tokenSet = true;
  }

  Future<List> fetchPlants(int page) async {
    if(!_tokenSet) {
       await getTrefleToken();
    }

    final url = "$_baseUrl?token=$_trefleToken&page=$page";
    return _sendRequest(url);
  }

  Future<List> searchPlants(int page, String query) async {
    final url = "$_baseUrl/search?token=$_trefleToken&q=$query&page=$page";
    return _sendRequest(url);
  }

  Future<List> _sendRequest(String url) async{ 
    final response = await http.get(Uri.parse(url));
    final responseBody = processResponse(response);
    Map<String, dynamic> jsonResponse = json.decode(responseBody);
    return jsonResponse['data'].map((plant) => Plant.fromJson(plant)).toList();
  }

  String processResponse(http.Response response) {
  if (response.statusCode == 200 || response.statusCode == 201) {
    return response.body;
  } else if (response.statusCode == 400) {
    throw Exception("Bad request");
  } else if (response.statusCode == 401) {
    throw Exception("Unauthorized");
  } else if (response.statusCode == 403) {
    throw Exception("Forbidden");
  } else if (response.statusCode == 404) {
    throw Exception("Not found");
  } else if (response.statusCode == 405) {
    throw Exception("Method not allowed");
  } else if (response.statusCode == 500) {
    throw Exception("Internal server error");
  } else if (response.statusCode == 502) {
    throw Exception("Bad gateway");
  } else if (response.statusCode == 503) {
    throw Exception("Service unavailable");
  } else {
    throw Exception("Unknown response status");
  }
}
}