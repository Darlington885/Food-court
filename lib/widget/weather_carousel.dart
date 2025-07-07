
import 'package:flutter/material.dart';
import 'package:food_court/model/weather_model.dart';

class WeatherCarousel extends StatelessWidget {
  final List<Weather> weathers;

  const WeatherCarousel({required this.weathers, super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: weathers.length,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            labelColor: Colors.blue[900],
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue[900],
            tabs: weathers.map((weather) => Tab(text: weather.city)).toList(),
          ),
          Expanded(
            child: TabBarView(
              children: weathers.map((weather) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            weather.city,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Image.network(
                            'http://openweathermap.org/img/wn/${weather.icon}@2x.png',
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '${weather.temperature.toStringAsFixed(1)}°C',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            weather.description.replaceFirstMapped(
                              RegExp(r'^\w'),
                                  (match) => match.group(0)!.toUpperCase(),
                            ),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
