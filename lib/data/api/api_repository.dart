import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/detail_model.dart';
import 'package:restaurant_app/data/models/resto_model.dart';

class ApiRepository {
  final _service = ApiService();

  Future<Resto> fetchRestoList() {
    return _service.fetchRestoList();
  }

  Future<RestoDetail> fetchRestoDetail(String id) {
    return _service.fetchRestoDetail(id);
  }
}

class NetworkError extends Error {}
