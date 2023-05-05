import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:weather_app/api/weather_api.dart';
import 'package:weather_app/cubit/weather_cubit.dart';
import 'package:weather_app/repo/weather_repo.dart';
import '../mock_services_locator.dart' as mock_sl;

void main() {
  group('WeatherCubit', () {
    late WeatherApi weatherApi;
    late WeatherCubit weatherCubit;
    late WeatherRepo weatherRepo;

    setUpAll(() {
      mock_sl.setupWeatherServiceLocatorMocks();
    });
    setUp(() {
      weatherRepo = mock_sl.mockSl();
      weatherApi = mock_sl.mockSl();
      weatherCubit = mock_sl.mockSl();
    });


    tearDown(() {
      weatherCubit.close();
    });

    test('should initially start with loading state', () async {
      expect(weatherCubit.state, const WeatherLoading());
    });
    blocTest<WeatherCubit, WeatherState>(
      'should emit correct state when repo succeeds',
      setUp: () {
        when(
          () => weatherRepo.getWeather('-25,11', '27.11'),
        ).thenAnswer(
          (_) => Future.value(any()),
        );
      },
      build: () => WeatherCubit(
        weatherRepo: weatherRepo,
      ),
      act: (cubit) async {
        cubit.getWeather(lat: '-25,11', lng: '27.11');
      },
      expect: () => [
        const WeatherLoading(),
        WeatherLoaded(weather: any(), getWeatherMain: any()),
      ],
    );
  });
}
