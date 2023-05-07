

## Flutter Weather App

This Flutter Weather App is a simple project that demonstrates how to use Cubit for state management and GetIt for service locator in a Flutter app. The app uses the OpenWeatherMap API to get the current weather data for the user's current location, which is retrieved using the Geolocator package.

**Note:** To use this app, you will need to obtain an API key from OpenWeatherMap and add it `lib/data/weather_api.dart` file with your own API key.

### Getting Started

To run this app on your local machine, you will need to have Flutter installed. You can download and install Flutter by following the instructions in the [Flutter Documentation](https://flutter.dev/docs/get-started/install).

Once you have Flutter installed, clone this repository and run the following command in the project directory:

```
flutter pub get
```

This will download all the dependencies required for this project.

### Running the App

To run the app on an Android device or emulator, run the following command:

```
flutter run
```


### How to Use the App

When you launch the app, it will request permission to access your location. Once you grant permission, the app will use the Geolocator package to retrieve your current location coordinates and use these coordinates to fetch the current weather data from the OpenWeatherMap API.

The app will display the current weather conditions for your location, including the temperature.

please note that the app whas build on an android device and not tested yet on IOS device.

### references

https://app.quicktype.io/
https://blog.logrocket.com/implementing-repository-pattern-flutter/
https://resocoder.com/2020/08/04/flutter-bloc-cubit-tutorial/
https://www.digitalocean.com/community/tutorials/flutter-flutter-http
