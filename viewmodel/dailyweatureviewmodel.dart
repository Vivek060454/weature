

import '../model/dailyW.dart';

class DailyWeatherViewModel{

  final DailyWeather dailyWeather;

  DailyWeatherViewModel({required this.dailyWeather});

  double get temp_Min{
    return this.dailyWeather.main.tempMin;
  }

  double get temp_Max{
    return this.dailyWeather.main.tempMax;
  }

  DateTime get dateTime{
    return this.dailyWeather.dtTxt;
  }

  String get iconName{
    return this.dailyWeather.weather[0].icon;
  }

  String get description{
    return this.dailyWeather.weather[0].description;
  }

  int get humidity{
    return this.dailyWeather.main.humidity;
  }

  double get windSpeed{
    return this.dailyWeather.wind.speed;
  }
}
