import 'package:dio/dio.dart';
import 'package:locator_tcs/api/dio_clinte.dart';
import 'package:locator_tcs/models/location_model.dart';

class ApiService {
  final Dio _dio = ApiClient().dio;

  Future<TcsLocationModel?> fetchPosts({int userId = 1}) async {
    try {
      final response = await _dio.get(
        '/content/dam/global-tcs/en/worldwide-json/worldwide-map-5-12.json',
      );

      TcsLocationModel tcsLocationModel =
          TcsLocationModel.fromJson(response.data);

      return tcsLocationModel;
    } catch (error) {
      print("error");
    }
  }
}
