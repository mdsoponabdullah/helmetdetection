import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LatituteLogitute extends StatefulWidget {
  const LatituteLogitute({super.key});

  @override
  State<LatituteLogitute> createState() => _LatituteLogitute();
}

class _LatituteLogitute extends State<LatituteLogitute> {

  getCurrentLocation() async{
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission==LocationPermission.denied || permission == LocationPermission.deniedForever)
      {

        log("Location denied");
        LocationPermission ask = await Geolocator.requestPermission();
      }
    else{

      Position currentPosition  = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      log("latitute : ${currentPosition.latitude} and longitute : ${currentPosition.longitude}");
    }


}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("jkjxks"),
      ),
      body: Center(
        child: GestureDetector(
          onTap: getCurrentLocation,
          child: const Text("get Location",style: TextStyle(
            color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 50
          ),),
        ),
      )
    );
  }
}
