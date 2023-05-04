import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/wather_model.dart';

class WeatherApi {
  final Uri postsURL = Uri.parse(
      "https://api.openweathermap.org/data/2.5/onecall?lat=28.0473&lon=-26.2041&units=metric&appid=29da89f167ed80b4f85074fa831cd668");

  Future<WeatherModel> getWeather() async {
    final res = await http.get(postsURL);

    if (res.statusCode == 200) {
      final response = jsonDecode(res.body);
      print('backend $response.fromJson()');
      return WeatherModel.fromJson(response as Map<String, dynamic>);
    } else {
      print('Request failed with status: ${res.statusCode}.');
      throw "Unable to retrieve posts.";
    }
  }
}
