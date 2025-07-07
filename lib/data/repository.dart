
// Data Repository
import 'dart:convert';

import 'package:food_court/model/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherRepository {
  final http.Client client;
  final String apiKey = '72ff4257eaeb0e280f5fa9985e05706d'; // Replace with your OpenWeatherMap API key

  WeatherRepository(this.client);

  Future<Weather> fetchWeatherByCity(String city) async {
    final response = await client.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body), city);
    } else {
      throw Exception('Failed to load weather for $city');
    }
  }

  Future<Weather> fetchWeatherByLocation(double lat, double lon) async {
    final response = await client.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body), 'Current Location');
    } else {
      throw Exception('Failed to load weather for current location');
    }
  }
}
