import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/wather_model.dart';
import '../repo/weather_repo.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepo _weatherRepo;

  WeatherCubit(this._weatherRepo) : super(const WeatherInitial());

  Future<void> getWeather(String cityName) async {
    try {
      emit(const WeatherLoading());
      final WeatherModel weather = await _weatherRepo.getWeather();
      emit(WeatherLoaded(weather));
    } catch (err) {
      emit(const WeatherError("Couldn't fetch weather. Is the device online?"));
    }
  }
}