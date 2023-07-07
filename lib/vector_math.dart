import 'package:vector_math/vector_math.dart';

class KalmanFilter {
  Vector2 _state;  // [latitude, longitude]
  Matrix2 _errorCovariance;

  KalmanFilter(this._state, this._errorCovariance);

  void predict(double control, double controlError) {
    _state += Vector2(control, 0);
    _errorCovariance += Matrix2(controlError, 0, 0, controlError);
  }

  void correct(double measurement, double measurementError) {
    double kalmanGain = _errorCovariance[0].dot(Vector2(1, 0)) / (_errorCovariance[0].dot(Vector2(1, 0)) + measurementError);
    _state += Vector2(kalmanGain * (measurement - _state[0]), 0);
    _errorCovariance = (Matrix2.identity() - Matrix2.columns(Vector2(kalmanGain, 0), Vector2(0, kalmanGain))) * _errorCovariance;
  }

  Vector2 get state => _state;
}

void main() {
  KalmanFilter filter = KalmanFilter(Vector2(0, 0), Matrix2.identity());

  // 予測ステップ
  filter.predict(1, 0.01);

  // 更新ステップ
  filter.correct(1.1, 0.01);

  print(filter.state);  // フィルタリングされた状態を出力
}
