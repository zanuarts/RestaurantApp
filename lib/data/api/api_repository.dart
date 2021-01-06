import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/models.dart';

class ApiRepository {
  final _service = ApiService();

  Future<Resto> fetchRestoList() {
    return _service.fetchRestoList();
  }
}

class NetworkError extends Error{}