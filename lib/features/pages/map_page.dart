
import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({Key? key}) : super(key: key);

  @override
  State<CurrentLocation> createState() => _CurrentLocation();
}

class _CurrentLocation extends State<CurrentLocation> {
  final Completer<GoogleMapController> _controller = Completer();
// on below line we have specified camera position
  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(24.782883826348524, 90.3624875299672),//24.782883826348524, 90.3624875299672
    zoom: 14.4746,
  );
  final List<Marker> _markers = <Marker>[
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(22.3475365, 91.81233240000006),
        infoWindow: InfoWindow(
          title: 'My Position',
        )),
  ];
  // Future<Position> getUserCurrentLocation() async {
  //   await Geolocator.requestPermission()
  //       .then((value) {})
  //       .onError((error, stackTrace) async {
  //     await Geolocator.requestPermission();
  //     //print("ERROR" + error.toString());
  //   });
  //   return await Geolocator.getCurrentPosition();
  // }


  Future<Position?> getCurrentLocation() async{
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission==LocationPermission.denied || permission == LocationPermission.deniedForever)
    {

      log("Location denied");
      LocationPermission ask = await Geolocator.requestPermission();
    }
    else{

      Position currentPosition  = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      log("latitute : ${currentPosition.latitude} and longitute : ${currentPosition.longitude}");
      return currentPosition;
    }
    return null;


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        // on below line we have given title of app
        title: const Text("My Location",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Container(
        child: SafeArea(
          // on below line creating google maps
          child: GoogleMap(
            // on below line setting camera position
            initialCameraPosition: _kGoogle,
            // on below line we are setting markers on the map
            markers: Set<Marker>.of(_markers),
            // on below line specifying map type.
            mapType: MapType.normal,
            // on below line setting user location enabled.
            myLocationEnabled: true,
            // on below line setting compass enabled.
            compassEnabled: true,
            // on below line specifying controller on map complete.
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
      ),
      // on pressing floating action button the camera will take to user current location
      floatingActionButton: SizedBox(
        height:70,
        width: 100,

        child: FloatingActionButton(

          onPressed: () async {
            getCurrentLocation().then((value) async {
              //print(value.latitude.toString() + " " + value.longitude.toString());

              // marker added for current users location
              _markers.add(Marker(
                markerId: const MarkerId("2"),
                position: LatLng(value!.latitude, value!.longitude),
                infoWindow: const InfoWindow(
                  title: 'My Current Location',
                ),
              ));

              // specified current users location
              CameraPosition cameraPosition = CameraPosition(
                target: LatLng(value.latitude, value.longitude),
                zoom: 14,
              );

              final GoogleMapController controller = await _controller.future;
              controller
                  .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
              setState(() {});
            });
          },
          child: const Icon(Icons.location_on,size: 50,color: Colors.green,),
        ),
      ),
    );
  }
}









