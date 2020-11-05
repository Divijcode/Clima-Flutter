import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/weather.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  double latitude,longitude;

  @override
  void initState(){
    super.initState();
    WeatherModel weatherModel=WeatherModel();
    weatherModel.getWeatherLocation();
  }


  void getData() async {

    var weatherdata= await weatherModel.getWeatherLocation();

      Navigator.push(context, MaterialPageRoute(builder: (context){
        return LocationScreen(weatherLocation: weatherdata);
      }));

    }


  @override
  Widget build(BuildContext context) {
      getData();
    return Scaffold(
      body: Center(
        child: SpinKitChasingDots(
          color: Colors.white,
          size: 50.0,

        ),
      ),
    );
  }
}
