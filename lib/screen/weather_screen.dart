
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_court/data/vm.dart';
import 'package:food_court/widget/weather_carousel.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  final List<String> availableCities = const [
    'Lagos',
    'Abuja',
    'Port Harcourt',
    'Kano',
    'Ibadan',
    'Kaduna',
    'Benin City',
    'Jos',
    'Ilorin',
    'Enugu',
    'Zaria',
    'Aba',
    'Onitsha',
    'Warri',
    'Sokoto',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: () => ref.refresh(currentLocationWeatherProvider),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCitySelectionDialog(context, ref),
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final weatherAsync = ref.watch(weatherProvider);
          final locationWeatherAsync = ref.watch(currentLocationWeatherProvider);

          return weatherAsync.when(
            data: (weathers) => locationWeatherAsync.when(
              data: (locationWeather) => WeatherCarousel(
                weathers: [...weathers, if (locationWeather != null) locationWeather],
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
          );
        },
      ),
    );
  }

  void _showCitySelectionDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Cities'),
          content: SingleChildScrollView(
            child: Consumer(
              builder: (context, ref, child) {
                final selectedCities = ref.watch(selectedCitiesProvider);
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: availableCities.map((city) {
                    return CheckboxListTile(
                      title: Text(city),
                      value: selectedCities.contains(city),
                      onChanged: (value) {
                        final newCities = List<String>.from(selectedCities);
                        if (value == true && !newCities.contains(city)) {
                          newCities.add(city);
                        } else if (value == false) {
                          newCities.remove(city);
                        }
                        ref.read(selectedCitiesProvider.notifier).updateCities(newCities);
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }
}