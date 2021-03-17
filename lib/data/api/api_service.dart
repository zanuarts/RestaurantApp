import 'dart:convert';

import 'package:restaurant_app/data/models/detail_model.dart';
import 'package:restaurant_app/data/models/resto_model.dart';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/models/search_model.dart';

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev';
  static final String _apiKey = '12345';
  static final String _list = '/list';
  static final String _detail = '/detail/';
  static final String _search = '/search?q=';

  Future<Resto> fetchRestoList() async {
    final response = await http.get(_baseUrl + _list);
      if (response.statusCode == 200){
        return Resto.fromJson(json.decode(response.body));
      }
      else{
        throw Exception('Failed to load Detail data');
      }
  }

  Future<RestoDetail> fetchRestoDetail(String id) async {
    print(_baseUrl + _detail + id);
    final response = await http.get(_baseUrl + _detail + id);
    if (response.statusCode == 200) {
      return RestoDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Detail data');
    }
  }

  Future<RestoSearch> fetchSearch(String query) async {
    print(_baseUrl + _search + query);
    final response = await http.get(_baseUrl + _search + query);
    if (response.statusCode == 200) {
      return RestoSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Search data');
    }
  }
}
