import 'package:get_it/get_it.dart';
import 'package:weather_app/api/weather_api.dart';
import 'package:weather_app/cubit/weather_cubit.dart';

import 'mock_classes.dart';

GetIt mockSl = GetIt.instance;

void setupWeatherServiceLocatorMocks() {
  mockSl.registerLazySingleton<WeatherCubit>(() => WeatherCubitMock());

  mockSl.registerLazySingleton<WeatherApi>(() => WeatherApiMock());
}
