import 'package:get_it/get_it.dart';
import 'package:weather_app/api/weather_api.dart';
import 'package:weather_app/cubit/weather_cubit.dart';
import 'package:weather_app/repo/weather_repo.dart';

final getIt = GetIt.instance;

void serviceLocatorInit() {
  getIt.registerFactory(() => WeatherApi());
  getIt.registerFactory<WeatherRepo>(
      () => WeatherRepo(weatherApi: getIt.get<WeatherApi>()));
  getIt.registerFactory<WeatherCubit>(
      () => WeatherCubit(weatherRepo: getIt.get<WeatherRepo>()));
}
