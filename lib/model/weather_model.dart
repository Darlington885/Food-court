// Data Models
class Weather {
  final String city;
  final double temperature;
  final String description;
  final String icon;

  Weather({
    required this.city,
    required this.temperature,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json, String city) {
    return Weather(
      city: city,
      temperature: (json['main']['temp'] as num).toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }
}
