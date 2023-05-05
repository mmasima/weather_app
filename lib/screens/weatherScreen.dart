import '../models/wather_model.dart';
import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  final WeatherModel weather;
  final String getWeatherMain;
  const WeatherScreen(
      {super.key, required this.getWeatherMain, required this.weather});

  @override
  Widget build(BuildContext context) {
    final String mainWeather = getWeatherMain;
    final Color hexCode;
    if (mainWeather == 'sun') {
      hexCode = const Color(0xFF47AB2F);
    } else if (mainWeather == 'clouds') {
      hexCode = const Color(0xFF54717A);
    } else {
      hexCode = const Color(0xFF57575D);
    }
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image:
                        AssetImage('assets/images/forest_$mainWeather.png'))),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${weather.current!.temp!.toInt()}º',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 60,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    mainWeather,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            color: hexCode,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'min',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'current',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'max',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${weather.daily![0].temp!.min!.toInt()}º',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${weather.current!.temp!.toInt()}º',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${weather.daily?[0].temp?.max?.toInt()}º',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  ...weather.daily!.asMap().entries.take(4).map(
                    (e) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  _weekDay(e.value.dt!),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Image.asset(
                                  'assets/icons/$getWeatherMain.png',
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${e.value.temp!.day!.toInt()}º',
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ).toList()
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

String _weekDay(DateTime weekday) {
  switch (weekday.weekday) {
    case 1:
      return 'Monday';
    case 2:
      return 'Tuesday';
    case 3:
      return 'Wednesday';
    case 4:
      return 'Thursday';
    case 5:
      return 'Friday';
    case 6:
      return 'Saturday';
    case 7:
      return 'Sunday';
    default:
      return 'Unkown';
  }
}
