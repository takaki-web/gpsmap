import 'package:location/location.dart';

void _getLocation() async {
  Location location = new Location();

  // Set the location update interval and accuracy
  location.changeSettings(
    interval: 1000, // Update location every 1000 milliseconds
    accuracy: LocationAccuracy.high, // Use high accuracy location
  );

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  // Listen for location updates
  location.onLocationChanged.listen((LocationData currentLocation) {
    _locationData = currentLocation;
    print(_locationData);
  });
}
