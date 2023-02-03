

import '../model/todatW.dart';

class TodayWeatherViewModel{

  final TodayWeather todayWeather;

  TodayWeatherViewModel({required this.todayWeather});

  double get temp_Min{
    return this.todayWeather.main.tempMin;
  }

  double get temp_Max{
    return this.todayWeather.main.tempMax;
  }

  String get locationName{
    return this.todayWeather.name;
  }

  String get iconName{
    return this.todayWeather.weather[0].icon;
  }

  String get condition{
    return this.todayWeather.weather[0].description;
  }
}