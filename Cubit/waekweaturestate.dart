

import 'package:flutter/cupertino.dart';

import '../model/dailyW.dart';

@immutable
abstract class WeeksweatherState {}

class WeeksweatherInitial extends WeeksweatherState {}

class WeeksweatherLoaded extends WeeksweatherState {
  final List<DailyWeather> fiveDayWeather;

  WeeksweatherLoaded({required this.fiveDayWeather});
}

class WeeksweatherLive extends WeeksweatherState {
  final List<DailyWeather> fiveDayWeatherLive;

  WeeksweatherLive({required this.fiveDayWeatherLive});
}

class WeeksweatherFailed extends WeeksweatherState {}
