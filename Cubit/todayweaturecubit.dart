import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weater/Cubit/todaysweaturestate.dart';


import '../model/todatW.dart';
import '../service/weaterservice.dart';



class TodayweatherCubit extends Cubit<TodayweatherState> {

  TodayweatherCubit() : super(TodayweatherInitial());

  Future<bool> fetchTodayWeather(var lat, var long) async {

    TodayWeather todayWeather;
    bool gotTodayWeather = false;

    await WeatherService().fetchTodayWeather(lat, long).then((results) {

      todayWeather = results;
      gotTodayWeather = true;
      emit(TodayWeatherLoaded(todayWeather: todayWeather));
    });

    return gotTodayWeather;
  }

  Future<bool> updateDailyLiveLocationWeather(var lat, var long) async{

    TodayWeather todayWeather;
    bool gotTodayWeather = false;

    await WeatherService().fetchTodayWeather(lat, long).then((results) {
      todayWeather = results;
      gotTodayWeather = true;
      emit(TodayWeatherLive(todayWeatherLive: todayWeather));

    });

    return gotTodayWeather;

  }

}