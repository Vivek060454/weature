import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import '../model/todatW.dart';



class TodayWeatherWidget extends StatelessWidget {

  const TodayWeatherWidget({Key? key, required this.todayWeather}) : super(key: key);

  final TodayWeather? todayWeather;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                Jiffy(DateTime.now()).format("EE, MMM dd, yyyy"),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Container(
                      width: 150,
                      height: 100,
                      child: CachedNetworkImage(
                        imageUrl: "http://openweathermap.org/img/wn/${todayWeather!.weather[0].icon}@2x.png",
                      )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          todayWeather!.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              todayWeather!.main.tempMax.round().toString() + " \u2103",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              todayWeather!.main.tempMin.round().toString() + " \u2103",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),
                            ),
                          ],
                        ),
                        Text(
                          todayWeather!.weather[0].description,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                          ),
                        )

                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        )

    );
  }
}