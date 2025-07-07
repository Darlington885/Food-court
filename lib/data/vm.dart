

// Riverpod Providers
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_court/data/repository.dart';
import 'package:food_court/model/weather_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  return WeatherRepository(http.Client());
});

final selectedCitiesProvider = StateNotifierProvider<SelectedCitiesNotifier, List<String>>((ref) {
  return SelectedCitiesNotifier(ref);
});

class SelectedCitiesNotifier extends StateNotifier<List<String>> {
  final Ref ref;
  static const _prefsKey = 'selectedCities';
  SelectedCitiesNotifier(this.ref) : super(['Lagos', 'Abuja', 'Port Harcourt']) {
    _loadPersistedCities();
  }

  Future<void> _loadPersistedCities() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCities = prefs.getStringList(_prefsKey);
    if (savedCities != null && savedCities.isNotEmpty) {
      state = savedCities;
    }
  }

  Future<void> updateCities(List<String> newCities) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_prefsKey, newCities);
    state = newCities;
  }
}

final weatherProvider = FutureProvider<List<Weather>>((ref) async {
  final repository = ref.watch(weatherRepositoryProvider);
  final cities = ref.watch(selectedCitiesProvider);
  return Future.wait(cities.map((city) => repository.fetchWeatherByCity(city)));
});

final currentLocationWeatherProvider = FutureProvider<Weather?>((ref) async {
  final repository = ref.watch(weatherRepositoryProvider);
  try {
    final position = await Geolocator.getCurrentPosition();
    return await repository.fetchWeatherByLocation(position.latitude, position.longitude);
  } catch (e) {
    return null;
  }
});
