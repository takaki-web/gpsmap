import 'package:connectivity/connectivity.dart';
import 'package:location/location.dart';

void _getLocation() async {
  Location location = new Location();
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

  _locationData = await location.getLocation();
  print(_locationData);
}

void _checkConnectivity() async {
  Connectivity connectivity = new Connectivity();
  ConnectivityResult connectivityResult = await connectivity.checkConnectivity();

  if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
    // I am connected to a network.
    _getLocation();
  }
}
