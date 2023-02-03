import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';


import '../Cubit/waekweaturestate.dart';
import '../Cubit/weakweaturecubit.dart';
import '../model/dailyW.dart';
import '../widget/detailsdailywiget.dart';

class DailyWeatherDetails extends StatelessWidget {
  const DailyWeatherDetails({Key? key, required this.selectedDateTime}) : super(key: key);

  final DateTime selectedDateTime;

  Future<List<DailyWeather>> sortDates(List<DailyWeather> dailyWeather) async{

    List<DailyWeather> sortedDailyWeather= [];

    int selectedYear = selectedDateTime.year;
    int selectedMonth = selectedDateTime.month;
    int selectedDay = selectedDateTime.day;

    for(int i = 0; i <= dailyWeather.length -1;i++){

      DateTime modelDate = dailyWeather[i].dtTxt;

      int modelDateYear = modelDate.year;
      int modelDateMonth = modelDate.month;
      int modelDateDay = modelDate.day;

      if(selectedYear == modelDateYear && selectedMonth == modelDateMonth && selectedDay == modelDateDay){
        sortedDailyWeather.add(dailyWeather[i]);
      }
    }

    return sortedDailyWeather;
  }

  @override
  Widget build(BuildContext context) {


    WeeksweatherCubit weeksweatherCubit = BlocProvider.of<WeeksweatherCubit>(context);
    List<DailyWeather> fiveDayWeather = (weeksweatherCubit.state as WeeksweatherLoaded).fiveDayWeather;

    return Scaffold(
        appBar: AppBar(
          title: Text(Jiffy(selectedDateTime).format("dd MMMM yyyy")),
          backgroundColor: Colors.grey,
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
            child: FutureBuilder<List<DailyWeather>>(
                future: sortDates(fiveDayWeather),
                builder: (BuildContext context, snapshot) {

                  if( snapshot.connectionState == ConnectionState.waiting){
                    return Text("Sorting list");
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

                            return DetailDailyWidget(weatherData:data[index]);
                          });

                    }
                  }

                  return Container();
                }
            )
        )
    );
  }
}