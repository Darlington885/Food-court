
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_court/screen/weather_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.blue[50],
      ),
      home: const WeatherScreen(),
    );
  }
}




// Unit Tests
// test/weather_test.dart
// import 'package:flutter_test/flutter_test.dart';
// import 'package:http/http.dart' as http;
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:weather_app/main.dart';
//
// import 'screen/weather_screen.dart';
// @GenerateMocks([http.Client])
// import 'weather_test.mocks.dart';
//
// void main() {
//   group('WeatherRepository', () {
//     late WeatherRepository repository;
//     late MockClient mockClient;
//
//     setUp(() {
//       mockClient = MockClient();
//       repository = WeatherRepository(mockClient);
//     });
//
//     test('fetchWeatherByCity returns Weather object on success', () async {
//       final mockResponse = {
//         'main': {'temp': 25.0},
//         'weather': [
//           {'description': 'clear sky', 'icon': '01d'}
//         ]
//       };
//       when(mockClient.get(any)).thenAnswer(
//             (_) async => http.Response(jsonEncode(mockResponse), 200),
//       );
//
//       final weather = await repository.fetchWeatherByCity('Lagos');
//
//       expect(weather.city, 'Lagos');
//       expect(weather.temperature, 25.0);
//       expect(weather.description, 'clear sky');
//       expect(weather.icon, '01d');
//     });
//
//     test('fetchWeatherByCity throws exception on failure', () async {
//       when(mockClient.get(any)).thenAnswer(
//             (_) async => http.Response('Not Found', 404),
//       );
//
//       expect(
//             () => repository.fetchWeatherByCity('Lagos'),
//         throwsException,
//       );
//     });
//
//     test('fetchWeatherByLocation returns Weather object on success', () async {
//       final mockResponse = {
//         'main': {'temp': 30.0},
//         'weather': [
//           {'description': 'sunny', 'icon': '01d'}
//         ]
//       };
//       when(mockClient.get(any)).thenAnswer(
//             (_) async => http.Response(jsonEncode(mockResponse), 200),
//       );
//
//       final weather = await repository.fetchWeatherByLocation(6.5244, 3.3792);
//
//       expect(weather.city, 'Current Location');
//       expect(weather.temperature, 30.0);
//       expect(weather.description, 'sunny');
//       expect(weather.icon, '01d');
//     });
//   });
// }
