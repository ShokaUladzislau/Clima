import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = '743a85cbeabd768cf2ab18aff2d4d80c';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();

    try {
      await location.getCurrentLocation();
    } catch (e) {
      return null;
    }

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    switch (condition) {
      case < 300:
        return '🌩';
      case < 400:
        return '🌧';
      case < 600:
        return '☔️';
      case < 700:
        return '☃️';
      case < 800:
        return '🌫';
      case == 800:
        return '☀️';
      case <= 804:
        return '☁️';
      default:
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
