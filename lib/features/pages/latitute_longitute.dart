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

  var latitute;
  var Longitute;

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
      latitute=currentPosition.latitude ;
      Longitute = currentPosition.longitude;
      setState(() {

      });
    }


}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Latitute & Longitute ",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: getCurrentLocation,
              child: const Text("get Location",style: TextStyle(
                  color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20
              ),),
            ),
            SizedBox(height: 30),
            Center(child: Text("Latitute : $latitute" ),),
            Center(child: Text("Longitute : $Longitute"),),
          ],
        )
      )
    );
  }
}
