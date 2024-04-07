
This Dart script fetches weather forecast data from the WeatherAPI and displays it for a specified city.

## Installation

1. Clone the repository or download the `weather.dart` file.
2. Make sure you have Dart installed on your system. If not, you can download and install it from the [Dart website](https://dart.dev/get-dart).
3. Install dependencies by running `pub get` in your terminal within the directory containing the `weather.dart` file.
4. Create a `.env` file in the same directory as `weather.dart` and add your [WeatherAPI.com](https://www.weatherapi.com/) key as follows:
```
API_KEY=your_weather_api_key
```
## Usage

Run the script using the Dart VM with the following command:
```zsh
dart weather.dart <city> <unit> [days]
```
Replace `<city>` with the name of the city for which you want to fetch the weather forecast.

Replace `<unit>` with either 'c' for Celsius or 'f' for Fahrenheit to specify the temperature unit.

`[days]` is an optional argument representing the number of days for which you want to retrieve the forecast. If not provided, the default is 1.

Example:

```zsh
dart weather.dart "New York" c 3
```

This will fetch the weather forecast for New York in Celsius for the next 3 days.

## Dependencies

- `http`: A package for making HTTP requests.
- `dotenv`: A package for loading environment variables from a `.env` file.

## License

This project is licensed under the [MIT License](https://github.com/furthestgoose/Weather-CLI-App/blob/main/LICENSE)
