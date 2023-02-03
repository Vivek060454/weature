import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'locationstate.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  late Position userLocation;

  Future<bool> getLocation() async {

    bool gotLocation = false;
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(LocationFailed());
      return gotLocation;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      emit(LocationFailed());
      return gotLocation;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        emit(LocationFailed());
        return gotLocation;
      }
    }

    gotLocation = true;
    userLocation = await Geolocator.getCurrentPosition();
    emit(LocationLoaded(userLocation: userLocation));

    return gotLocation;

  }
}
