import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/detail_model.dart';
import 'package:restaurant_app/data/models/resto_model.dart';
import 'package:restaurant_app/data/models/search_model.dart';

class ApiRepository {
  final _service = ApiService();

  Future<Resto> fetchRestoList() {
    return _service.fetchRestoList();
  }

  Future<RestoDetail> fetchRestoDetail(String id) {
    return _service.fetchRestoDetail(id);
  }

  Future<RestoSearch> fetchSearch(String query) {
    return _service.fetchSearch(query);
  }
}

class NetworkError extends Error {}
