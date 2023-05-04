import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/cubit/weather_cubit.dart';
import 'package:weather_app/repo/weather_repo.dart';
import 'package:weather_app/services/service_locator.dart';

import 'api/weather_api.dart';
import 'geolocator.dart';
import 'models/wather_model.dart';

void main() {
  serviceLocatorInit();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
          create: (context) =>
              WeatherCubit(weatherRepo: GetIt.instance.get<WeatherRepo>()),
          child: const MyHomePage(title: 'Weather'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late WeatherCubit _weatherCubit;
  late Position position;
  @override
  void initState() async {
    position = await getLocation();
    _weatherCubit = WeatherCubit(
      weatherRepo: GetIt.instance.get<WeatherRepo>(),
    );

    _loadWeatherDeatials();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _weatherCubit.close();
  }

  Future<void> _loadWeatherDeatials() {
    final weatherCubit = BlocProvider.of<WeatherCubit>(context);

    return weatherCubit.getWeather(
        lat: position.latitude.toString(),
        lng: position.longitude.toString());
  }

  Future<Position> getLocation() async {
    determinePosition();
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    return position;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state) {
        if (state is WeatherLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WeatherLoaded) {
          return weatherScreen(state.weather, state.getWeatherMain);
        } else {
          return const Center(
            child: Text('Error loading weather Api'),
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final WeatherModel result = await WeatherApi().getWeather();
          getLocation();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), //
    );
  }
}

Widget weatherScreen(WeatherModel weather, String getWeatherMain) {
  final String mainWeather = getWeatherMain;
  final Color hexCode;
  if (mainWeather == 'sunny') {
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
                  image: AssetImage('assets/images/forest_$mainWeather.png'))),
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
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'min"',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'current"',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: const [
                        Text(
                          'max"',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${weather.daily![0].temp!.min!.toInt()}º',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '${weather.current!.temp!.toInt()}º',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '${weather.daily?[0].temp?.max?.toInt()}º',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.black,
                ),
                const SizedBox(height: 20),
                ...weather.daily!.asMap().entries.map(
                  (e) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _weekDay(e.value.dt!),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Image.asset('assets/icons/$getWeatherMain.png'),
                          Text(
                            '${e.value.temp!.day!.toInt()}º',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
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

String _weekDay(DateTime weekday) {
  switch (weekday.day) {
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
