import 'package:sensors/sensors.dart';

void _getSensorData() {
  accelerometerEvents.listen((AccelerometerEvent event) {
    print(event);
  });

  gyroscopeEvents.listen((GyroscopeEvent event) {
    print(event);
  });

  userAccelerometerEvents.listen((UserAccelerometerEvent event) {
    print(event);
  });
}
