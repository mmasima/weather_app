import 'package:http/http.dart';

import '../models/wather_model.dart';

class WeatherApi {
  final Uri postsURL = Uri.parse(
      "https://api.openweathermap.org/data/3.0/onecall?lat=28.0473&lon=-26.2041&appid=");

  Future<WeatherModel> getWeather() async {
    Response res = await get(postsURL);

    if (res.statusCode == 200) {
      print('backend $res');
      return WeatherModel.fromJson(res as Map<String, dynamic>);

    } else {
      print('Request failed with status: ${res.statusCode}.');
      throw "Unable to retrieve posts.";
    }
  }
}
