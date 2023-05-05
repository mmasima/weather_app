import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../cubit/weather_cubit.dart';
import '../geolocator.dart';
import 'weatherScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  late WeatherCubit _weatherCubit;
  Position? position;
  @override
  void initState() {
    getLocation();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _weatherCubit.close();
  }

  Future<void> getLocation() async {
    determinePosition();
    Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    setState(() {
      position = pos;
    });
  }

  Future<void> _loadWeatherDeatials() async {
    final weatherCubit = BlocProvider.of<WeatherCubit>(context);
    return weatherCubit.getWeather(
        lat: position?.latitude.toString() ?? '',
        lng: position?.longitude.toString() ?? '');
  }

  @override
  Widget build(BuildContext context) {
    if (position != null) {
      _loadWeatherDeatials();
    }
    return Scaffold(
      body: BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state) {
        if (state is WeatherLoading) {
          return Container(
            color: const Color(0xFF54717A),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is WeatherLoaded) {
          return WeatherScreen(
              weather: state.weather, getWeatherMain: state.getWeatherMain);
        } else {
          return const Center(
            child: Text('Error loading weather Api'),
          );
        }
      }), //
    );
  }
}
