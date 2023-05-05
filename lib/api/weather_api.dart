import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/wather_model.dart';

class WeatherApi {

  Future<WeatherModel> getWeather(
    String lat,
    String lng,
  ) async {
     final Uri postsURL = Uri.parse(
      "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lng&units=metric&appid=");
    final res = await http.get(postsURL);

    if (res.statusCode == 200) {
      final response = jsonDecode(res.body);
       return WeatherModel.fromJson(response as Map<String, dynamic>);
    } else {
      print('Request failed with status: ${res.statusCode}.');
      throw "Unable to retrieve posts.";
    }
  }
}
