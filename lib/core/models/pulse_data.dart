/// A model to store data retrieved from body sensors of Wear/Tizen OS.
class PulseData {
  final double heartRate;
  final double calories;
  final double steps;
  final double distance;
  final double speed;

  const PulseData({
    this.heartRate = 0,
    this.calories = 0,
    this.steps = 0,
    this.distance = 0,
    this.speed = 0,
  });

  PulseData copyWith({
    double? heartRate,
    double? calories,
    double? steps,
    double? distance,
    double? speed,
  }) {
    return PulseData(
      heartRate: heartRate ?? this.heartRate,
      calories: calories ?? this.calories,
      steps: steps ?? this.steps,
      distance: distance ?? this.distance,
      speed: speed ?? this.speed,
    );
  }

  Map<String, dynamic> toJson() => {
        'heart_rate': heartRate,
        'calories': calories,
        'steps': steps,
        'distance': distance,
        'speed': speed,
      };

  String toDisplayText() {
    return 'Heart Rate: $heartRate | Calories: ${calories.toStringAsFixed(2)} | $steps Steps | Distance: ${distance.toStringAsFixed(2)}';
  }
}
