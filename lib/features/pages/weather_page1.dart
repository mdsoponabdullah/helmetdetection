import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }

class WeatherPage1 extends StatefulWidget {
  const WeatherPage1({super.key});

  @override
  State<WeatherPage1> createState() => _WeatherPage1();
}

class _WeatherPage1 extends State<WeatherPage1> {
  var latitute;
  var Longitute;
  String key = '01d4b4f25965b6854dea43705e0f863f';
  late WeatherFactory ws;
  List<Weather> _data = [];
  AppState _state = AppState.NOT_DOWNLOADED;
  double? lat, lon;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    ws = new WeatherFactory(key);
  }

  void queryForecast() async {
    /// Removes keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _state = AppState.DOWNLOADING;
    });

    List<Weather> forecasts = await ws.fiveDayForecastByLocation(lat!, lon!);
    setState(() {
      _data = forecasts;
      _state = AppState.FINISHED_DOWNLOADING;
    });
  }

  void queryWeather() async {
    /// Removes keyboard
    FocusScope.of(context).requestFocus(FocusNode());

    setState(() {
      _state = AppState.DOWNLOADING;
    });

    Weather weather = await ws.currentWeatherByLocation(lat!, lon!);
    setState(() {
      _data = [weather];
      _state = AppState.FINISHED_DOWNLOADING;
    });
  }

  Widget contentFinishedDownload() {
    return Container(
      child: ListView.separated(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Date :  ${_data[index].date?.day}/${_data[index].date?.month}/${_data[index].date?.year}",  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                )),Text(
                    "Time : ${_data[index].date?.hour}:${_data[index].date?.minute}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    )),
                //SizedBox(width: 3,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [


                    Text(" ${_data[index].temperature?.celsius?.round()}\u00B0C",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 100)),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                        "Sunrise : ${_data[index].sunrise?.hour}:${_data[index].sunrise?.minute}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        )),
                    //SizedBox(width: 3,),
                    Text(
                        "Sunset : ${_data[index].sunset?.hour}:${_data[index].sunset?.minute}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                            fontSize: 20
                        )),
                  ],
                ),

                //  Text("Temperature now : ${_data[index]}",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,)),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }

  Widget contentDownloading() {
    return Container(
      margin: EdgeInsets.all(25),
      child: Column(children: [
        const Text(
          'Fetching Weather...',
          style: TextStyle(fontSize: 20),
        ),
        Container(
            margin: const EdgeInsets.only(top: 50),
            child:
                const Center(child: CircularProgressIndicator(strokeWidth: 10)))
      ]),
    );
  }

  Widget contentNotDownloaded() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Press the button to download the Weather forecast',
          ),
        ],
      ),
    );
  }

  Widget _resultView() => _state == AppState.FINISHED_DOWNLOADING
      ? contentFinishedDownload()
      : _state == AppState.DOWNLOADING
          ? contentDownloading()
          : contentNotDownloaded();

  Widget _buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10),
          child: TextButton(
            onPressed: queryWeather,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue)),
            child: const Text(
              'Fetch weather',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(5),
          child: TextButton(
            onPressed: queryForecast,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue)),
            child: const Text(
              'Fetch forecast',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Weather ",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/weather2.jpg'), // Replace 'background_image.jpg' with your image file
            fit: BoxFit
                .cover, // You can set different BoxFit values based on your requirement
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
            ),
            Expanded(child: _resultView()),
            _buttons(),
          ],
        ),
      ),
    );
  }

  getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      log("Location denied");
      LocationPermission ask = await Geolocator.requestPermission();
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      log("latitute : ${currentPosition.latitude} and longitute : ${currentPosition.longitude}");
      latitute = currentPosition.latitude;
      Longitute = currentPosition.longitude;
      lat = currentPosition.latitude;
      lon = currentPosition.longitude;
      setState(() {});
    }
  }
}
