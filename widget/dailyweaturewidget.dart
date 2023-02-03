import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import '../model/dailyW.dart';
import '../screen/dailyweatherd.dart';


class DailyWeatherWidget extends StatelessWidget {
  const DailyWeatherWidget({Key? key, required this.weatherData}) : super(key: key);

  final DailyWeather weatherData;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        DateTime selectedDateTime = weatherData.dtTxt;
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DailyWeatherDetails(selectedDateTime: selectedDateTime)));
      },
      child: Container(
        height: 120,
        margin: EdgeInsets.only(bottom: 10),
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
                      Text(Jiffy(weatherData.dtTxt).format("dd MMMM")),
                      Text(Jiffy(weatherData.dtTxt).format("EEEE")),
                      Text(weatherData.weather[0].description),
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
              Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
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
                      )
                    ],
                  )
              )
            ]
        ),
      ),
    );
  }

}