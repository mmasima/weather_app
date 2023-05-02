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
          child: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  void initState() {
    getLocation();
    WeatherRepo _weatherRepo = GetIt.instance.get<WeatherRepo>();
    _weatherCubit = WeatherCubit(
      weatherRepo: _weatherRepo,
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

    return weatherCubit.getWeather(lat: '-25.9991783', lng: '28.1262917');
  }

  void getLocation() async {
    determinePosition();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    print('hello world ${position.latitude}  + ${position.longitude}');
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
          return weatherScreen(state.weather);
        } else {
          return const Center(
            child: Text('Error loading weather Api'),
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final WeatherModel result = await WeatherApi().getWeather();
          print("frontend ${result}");
          getLocation();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), //
    );
  }
}

Widget weatherScreen(WeatherModel weather) {
  final String mainWeather =
      weather.current?.weather?.map((e) => e.main.toString()) as String;
  return Column(
    children: [
      Expanded(
        flex: 1,
        child: Container(
          decoration:  BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/$mainWeather.png'))),
          color: Colors.redAccent,
          child: Center(
            child: Text(
              weather.current!.dt.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      Expanded(
        flex: 2,
        child: Container(
          color: Colors.amber,
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
                      ),
                    ),
                    const Text(
                      'current"',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: const [
                        Text(
                          'max"',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('18"'),
                    Text('25"'),
                    Text('27"'),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.black,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'min"',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'current"',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'max"',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    ],
  );
}
