import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/cubit/weather_cubit.dart';
import 'package:weather_app/repo/weather_repo.dart';
import 'package:weather_app/screens/homeScreen.dart';
import 'package:weather_app/services/service_locator.dart';


void main() {
  serviceLocatorInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
          child: const HomeScreen(title: 'Weather'),
        ));
  }
}
