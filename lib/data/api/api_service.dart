import 'dart:convert';

import 'package:restaurant_app/data/models/models.dart';

import 'package:http/http.dart' as http;

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev';
  // static final String _apiKey = '12345';
  static final String _list = '/list';
  
  Future<Resto> fetchRestoList() async {
    final response = await http.get(_baseUrl + _list);
    if (response.statusCode == 200){
      return Resto.fromJson(json.decode(response.body));
    }
    else {
      throw Exception('Failed to load restaurant data');
    }
  }
}