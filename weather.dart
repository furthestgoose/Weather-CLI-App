import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dotenv/dotenv.dart';

Future<void> main(List<String> arguments) async {
  try {
    // Load the API key from the .env file
    var env = DotEnv(includePlatformEnvironment: true)..load();

    // Check if the user provided a city name and a unit as arguments
    if (arguments.length < 2 || arguments.length > 3) {
      print('Usage: dart weather.dart <city> <unit> [days]');
      print('Example: dart weather.dart "New York" c 3');
      return;
    }

    final cityName = arguments[0];
    final unit = arguments[1].toLowerCase();
    final days = arguments.length == 3 ? int.tryParse(arguments[2]) : 1;
    final apiKey = env['API_KEY'];

    if (apiKey == null) {
      print('API key not found in the .env file.');
      return;
    }

    if (days == null || days <= 0) {
      print('Invalid number of days. Please provide a positive integer.');
      return;
    }

    // Construct the API URL for forecast data
    final apiUrl =
        'https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=${Uri.encodeComponent(cityName)}&days=$days';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final locationName = data['location']['name'];

      final forecastDays = data['forecast']['forecastday'];
      for (var forecastDay in forecastDays) {
        final date = forecastDay['date'];
        final day = forecastDay['day'];
        final maxTempC = day['maxtemp_c'];
        final minTempC = day['mintemp_c'];
        final chanceOfRain = day['daily_chance_of_rain'];
        final weatherDescription = day['condition']['text'];

        print('Weather forecast for $locationName on $date:');
        if (unit == 'c') {
          print('Maximum Temperature: $maxTempC°C');
          print('Minimum Temperature: $minTempC°C');
        } else if (unit == 'f') {
          final maxTempF = celsiusToFahrenheit(maxTempC);
          final minTempF = celsiusToFahrenheit(minTempC);
          print('Maximum Temperature: $maxTempF°F');
          print('Minimum Temperature: $minTempF°F');
        } else {
          print(
              'Invalid unit. Please use "c" for Celsius or "f" for Fahrenheit.');
          return;
        }
        print('Chance of Rain: $chanceOfRain%');
        print('Description: $weatherDescription');
        print('---------------------');
      }
    } else {
      print(
          'Failed to fetch weather forecast data. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
}

double celsiusToFahrenheit(double celsius) {
  return (celsius * 9 / 5) + 32;
}
