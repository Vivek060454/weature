import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../Cubit/locationcubit.dart';
import '../Cubit/locationstate.dart';
import '../Cubit/todaysweaturestate.dart';
import '../Cubit/todayweaturecubit.dart';
import '../Cubit/waekweaturestate.dart';
import '../Cubit/weakweaturecubit.dart';
import '../model/dailyW.dart';
import '../model/todatW.dart';
import '../widget/dailyweaturewidgetlist.dart';
import '../widget/failtogetlocation.dart';
import '../widget/horizontalwhiteline.dart';
import '../widget/loadingwidget.dart';
import '../widget/shimmerblock.dart';
import '../widget/todaweaturewidget.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  var lattitude;
  var longitude;

  late LocationCubit locatoinCubit;
  late TodayweatherCubit todayweatherCubit;
  late WeeksweatherCubit weeksweatherCubit;
  late LocationSettings locationSettings;

  void getUserLocation() async{

    await locatoinCubit.getLocation().then((gotUserLocation) async{

      if(gotUserLocation){

        lattitude = locatoinCubit.userLocation.latitude.toString();
        longitude = locatoinCubit.userLocation.longitude.toString();

        await todayweatherCubit.fetchTodayWeather(lattitude, longitude);
        await weeksweatherCubit.fetchFiveDayForecastWeather(lattitude, longitude);

        Timer.periodic(Duration(minutes:10), (Timer t) async{

          Stream<Position> positionStream = Geolocator.getPositionStream(locationSettings: locationSettings);

          await positionStream.first.then((position){
            lattitude = position.latitude.toString();
            longitude = position.longitude.toString();
          });

          await todayweatherCubit.updateDailyLiveLocationWeather(lattitude,longitude);
          await weeksweatherCubit.updateWeeklyLiveLocationWeather(lattitude,longitude);

        });

      }
      else{
        Geolocator.openLocationSettings();
      }

    });

  }

  @override
  void initState() {
    super.initState();

    locatoinCubit = BlocProvider.of<LocationCubit>(context);
    todayweatherCubit = BlocProvider.of<TodayweatherCubit>(context);
    weeksweatherCubit = BlocProvider.of<WeeksweatherCubit>(context);

    if(Platform.isAndroid){

      locationSettings = AndroidSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
          forceLocationManager: true,
          intervalDuration: const Duration(seconds: 10),
          foregroundNotificationConfig: const ForegroundNotificationConfig(
            notificationText:
            "Weather 1 will continue to receive your location even when you aren't using it",
            notificationTitle: "Running in Background",
            enableWakeLock: true,
          )
      );

    }else if (Platform.isIOS){

      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        distanceFilter: 100,
        pauseLocationUpdatesAutomatically: true,
        showBackgroundLocationIndicator: false,
      );
    }else {

      locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );

    }

    getUserLocation();

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: BlocBuilder<LocationCubit, LocationState>(
                builder: (context, locationState) {

                  if(locationState is LocationInitial){

                    return LoadingWidget(message: 'Getting your location...',);

                  }
                  else if(locationState is LocationLoaded){

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        //today weather
                        Expanded(
                          flex: 2,
                          child: BlocBuilder<TodayweatherCubit, TodayweatherState>(
                              builder: (context, todayWeatherState) {

                                if(todayWeatherState is TodayweatherInitial){

                                  return LoadingWidget(message:"Getting weather...");

                                }
                                else if(todayWeatherState is TodayWeatherLoaded){

                                  TodayWeather todayWeather = todayWeatherState.todayWeather;
                                  return TodayWeatherWidget(todayWeather: todayWeather);

                                }
                                else if(todayWeatherState is TodayWeatherLive){

                                  TodayWeather todayWeather = todayWeatherState.todayWeatherLive;
                                  return TodayWeatherWidget(todayWeather: todayWeather);

                                }

                                return Container();
                              }
                          ),
                        ),


                        HorizontalWhiteLine(),

                        //weeks weather
                        Expanded(
                          flex: 6,
                          child: BlocBuilder<WeeksweatherCubit, WeeksweatherState>(
                              builder: (context, weeksWeatherState) {

                                if(weeksWeatherState is WeeksweatherInitial){

                                  return SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ShimmerBlock(),
                                        ShimmerBlock(),
                                        ShimmerBlock()
                                      ],
                                    ),
                                  );
                                }
                                else if(weeksWeatherState is WeeksweatherLoaded){

                                  List<DailyWeather> weeklyWeatherState = weeksWeatherState.fiveDayWeather;
                                  return DailyWeatherListWidget(dailyWeather: weeklyWeatherState);
                                }
                                else if(weeksWeatherState is WeeksweatherLive){

                                  List<DailyWeather> weeklyWeatherState = weeksWeatherState.fiveDayWeatherLive;
                                  return DailyWeatherListWidget(dailyWeather: weeklyWeatherState);
                                }

                                return Container();
                              }
                          ),
                        ),

                      ],
                    );

                  }
                  else if(locationState is LocationFailed){

                    return FaliedToGetLocationWidget(onPressed: getUserLocation);
                  }

                  return Container();
                }
            )
        )
    );
  }
}