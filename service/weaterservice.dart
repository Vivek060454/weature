import 'dart:convert';


import 'package:http/http.dart' as http;

import '../keys.dart';
import '../model/dailyW.dart';
import '../model/todatW.dart';

class WeatherService{

  String url = "www.community-open-weather-map.p.rapidapi.com";
  String headerHost = "community-open-weather-map.p.rapidapi.com";
  String apiKEY = Keys.openWeatherKEY;

  Future<TodayWeather> fetchTodayWeather(var lat, var long) async{

    final response = await http.get(
        Uri(
            scheme: "https",
            host: url,
            path: "weather",
            queryParameters: {
              "lat":lat,
              "lon":long,
              "units":"metric",
            }
        ),
        headers: {
          "Host":headerHost,
          'X-RapidAPI-Host': headerHost,
          'X-RapidAPI-Key': apiKEY
        }
    );

    if(response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return TodayWeather.fromJson(body);
    }
    else{
      throw Exception("Unable to perform request!");
    }

  }

  Future<List<DailyWeather>> fetchFiveDayForecastWeather(var lat, var long) async{

    final response = await http.get(
        Uri(
            scheme: "https",
            host: url,
            path: "forecast",
            queryParameters: {
              "lat":lat,
              "lon":long,
              "units":"metric",
            }
        ),
        headers: {
          "Host":headerHost,
          'X-RapidAPI-Host': headerHost,
          'X-RapidAPI-Key': apiKEY
        }
    );

    if(response.statusCode == 200) {

      final body = jsonDecode(response.body);
      final Iterable json = body["list"];
      return json.map((weather) => DailyWeather.fromJson(weather)).toList();

    }
    else{
      throw Exception("Unable to perform request!");
    }

  }

}