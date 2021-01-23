import 'dart:convert';

import 'package:restaurant_app/data/models/detail_model.dart';
import 'package:restaurant_app/data/models/resto_model.dart';

import 'package:http/http.dart' as http;

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev';
  static final String _apiKey = '12345';
  static final String _list = '/list';
  static final String _detail = '/detail/:id';

  Future<Resto> fetchRestoList() async {
    final response = await http.get(_baseUrl + _list);
    if (response.statusCode == 200){
      return Resto.fromJson(json.decode(response.body));
    }
    else {
      throw Exception('Failed to load restaurant data');
    }
  }

  Future<RestoDetail> fetchRestoDetail() async {
    final response = await http.get(_baseUrl + _detail);
    if (response.statusCode == 200){
      return RestoDetail.fromJson(json.decode(response.body));
    }
    else{
      throw Exception('Failed to load Detail data');
    }
  }
}