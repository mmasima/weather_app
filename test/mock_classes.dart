import 'package:weather_app/api/weather_api.dart';
import 'package:weather_app/cubit/weather_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/repo/weather_repo.dart';

class WeatherCubitMock extends Mock implements WeatherCubit {}

class WeatherRepoMock extends Mock implements WeatherRepo {}

class WeatherApiMock extends Mock implements WeatherApi {}
