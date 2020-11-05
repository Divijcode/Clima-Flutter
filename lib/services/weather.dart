import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clima/screens/loading_screen.dart';
import 'package:clima/services/location.dart';

class WeatherModel {

double latitude,longitude;

  Future<dynamic> getWeatherLocation() async{
    Location loc =Location();
    await loc.location();
    latitude=loc.latitude;
    longitude=loc.longitude;

    try {
      http.Response response = await http.get(
          'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric&appid=e7434204586cebab6a542fc53fadf46c');
      if (response.statusCode == 200) {
        String data = response.body;
        var weatherdata = jsonDecode(data);
        return weatherdata;
      }
      else{
        print(response.statusCode);
      }
    }
    catch(e){
      print(e);
    }
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
