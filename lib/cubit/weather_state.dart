part of 'weather_cubit.dart';

abstract class WeatherState {
  const WeatherState();
}

class WeatherLoading extends WeatherState {
  const WeatherLoading();

  @override
  List<Object> get props => [];
}

class WeatherLoaded extends WeatherState {
  final WeatherModel weather;
  final String getWeatherMain;
  const WeatherLoaded({
    required this.weather,
    required this.getWeatherMain,
  });

  @override
  List<Object> get props => [
        weather,
        getWeatherMain,
      ];
}

class WeatherError extends WeatherState {
  final String message;
  const WeatherError(this.message);

  @override
  List<Object> get props => [];
}
