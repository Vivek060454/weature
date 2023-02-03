import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../model/dailyW.dart';

class DetailDailyWidget extends StatelessWidget {
  const DetailDailyWidget({Key? key, required this.weatherData}) : super(key: key);

  final DailyWeather weatherData;

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 160,
      margin: EdgeInsets.only(bottom: 5,top: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey)
      ),
      child: Row(
          children:[
            Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(Jiffy(weatherData.dtTxt).format("HH:mm"), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          weatherData.main.tempMax.round().toString() + " \u2103",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          weatherData.main.tempMin.round().toString() + " \u2103",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(weatherData.weather[0].description),
                  ],
                )
            ),

            Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Humidty"),
                    Text("${weatherData.main.humidity}%"),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Wind Speed"),
                    Text("${weatherData.wind.speed} km/h")
                  ],
                )
            ),

            Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 100,
                      child: CachedNetworkImage(
                        imageUrl: "http://openweathermap.org/img/wn/${weatherData.weather[0].icon}@2x.png",
                      ),
                    ),
                  ],
                )
            ),
          ]
      ),
    );
  }

}