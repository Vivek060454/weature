import 'package:flutter/material.dart';

import '../model/dailyW.dart';
import 'dailyweaturewidget.dart';

class DailyWeatherListWidget extends StatefulWidget {
  const DailyWeatherListWidget({Key? key, required this.dailyWeather}) : super(key: key);

  final List<DailyWeather>? dailyWeather;

  @override
  State<DailyWeatherListWidget> createState() => _DailyWeatherListWidgetState();
}

class _DailyWeatherListWidgetState extends State<DailyWeatherListWidget> {


  Future<List<DailyWeather>> sortDates() async{

    List<DailyWeather> sortedDailyList = [];

    DateTime todayNine = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,9,00,00);
    DateTime earliestDateOnVM = widget.dailyWeather![0].dtTxt;

    if(earliestDateOnVM.isBefore(todayNine)){
      //take all 9am

      for(int i = 0; i <= widget.dailyWeather!.length - 1; i++){

        if(widget.dailyWeather![i].dtTxt == todayNine){
          sortedDailyList.add(widget.dailyWeather![i]);
          todayNine = todayNine.add(Duration(days: 1));
        }

      }

    }
    else{
      //take first datetime, then all following 9am
      sortedDailyList.add(widget.dailyWeather![0]);
      todayNine = todayNine.add(Duration(days: 1));

      for(int i = 1; i <= widget.dailyWeather!.length -1; i++){

        if(widget.dailyWeather![i].dtTxt == todayNine){
          sortedDailyList.add(widget.dailyWeather![i]);
          todayNine = todayNine.add(Duration(days: 1));
        }

      }
    }

    return sortedDailyList;

  }

  @override
  Widget build(BuildContext context) {

    return Container(
        child: FutureBuilder<List<DailyWeather>>(
          future: sortDates(),
          builder: (BuildContext context, snapshot) {

            if( snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: 60,
                  width: 60,
                  child: Image.asset("images/cloud.png"),
                ),
              );
            }
            else{
              if (snapshot.hasError){
                return Text('An error occured.');
              }
              else if (snapshot.hasData  && snapshot.data!.length > 0) {

                List<DailyWeather>? data = snapshot.data;

                return ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (BuildContext context, int index){

                      return DailyWeatherWidget(weatherData:data[index]);
                    });

              }
            }

            return Container();
          },
        )
    );
  }
}