import 'package:http/http.dart';

import '../api/weather_api.dart';
import '../models/wather_model.dart';

class WeatherRepo {
  final WeatherApi _weatherApi;

  WeatherRepo({
    required WeatherApi weatherApi,
  }) : _weatherApi = weatherApi;
  Future<WeatherModel> getWeather(
    String lat,
    String lng,
  ) async {
    try {
      return await _weatherApi.getWeather(lat, lng);
    } catch (err) {
      rethrow;
    }
  }
}
