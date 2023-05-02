import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/wather_model.dart';
import '../repo/weather_repo.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepo _weatherRepo;

  WeatherCubit({required WeatherRepo weatherRepo})
      : _weatherRepo = weatherRepo,
        super(const WeatherLoading());

  Future<void> getWeather({required String  lat,required String lng}) async {
    try {
      emit(const WeatherLoading());
      final WeatherModel weather = await _weatherRepo.getWeather();
      emit(WeatherLoaded(weather: weather));
    } catch (err) {
      emit(const WeatherError("Couldn't fetch weather. Is the device online?"));
    }
  }
}
