import '../api/weather_api.dart';
import '../models/wather_model.dart';

class WeatherRepo {
  final WeatherApi _weatherApi;

  WeatherRepo({
    required WeatherApi weatherApi,
  }) : _weatherApi = weatherApi;
  Future<WeatherModel> getWeather() async {
    try {
      return await _weatherApi.getWeather();
    } catch (err) {
      rethrow;
    }
  }
}
