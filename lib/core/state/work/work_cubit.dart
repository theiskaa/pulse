import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse/core/constants.dart';
import 'package:pulse/core/state/work/work_state.dart';
import 'package:workout/workout.dart';

export 'work_state.dart';

/// The main state manager cubit for work pulse data management.
class WorkCubit extends Cubit<WorkCubitState> {
  final workout = Workout();

  WorkCubit() : super(const WorkCubitState()) {
    workout.stream.listen((event) {
      switch (event.feature) {
        case WorkoutFeature.unknown:
          return;
        case WorkoutFeature.heartRate:
          pulseEvent(heartRate: event.value);
          break;
        case WorkoutFeature.calories:
          pulseEvent(calories: event.value);
          break;
        case WorkoutFeature.steps:
          pulseEvent(steps: event.value);
          break;
        case WorkoutFeature.distance:
          pulseEvent(distance: event.value);
          break;
        case WorkoutFeature.speed:
          pulseEvent(speed: event.value);
          break;
      }
    });
  }

  /// Method that is used to execute start of working process.
  Future<void> startWork() async {
    final result = await workout.start(
      enableGps: true,
      exerciseType: ExerciseType.workout,
      features: workfeatures,
    );

    if (result.unsupportedFeatures.isNotEmpty) {
      emit(state.copyWith(error: 'There is unsupported features: ${result.unsupportedFeatures}'));
    }

    if (workfeatures.length >= result.unsupportedFeatures.length) {
      emit(state.copyWith(progress: true));
    }
  }

  /// Method that is used to execute stop of working process.
  Future<void> stopWork() async {
    await workout.stop();
    emit(state.copyWith(progress: false));
  }

  /// A event handler method that will be triggered any time we got new event
  /// from body sensors of wearable device.
  void pulseEvent({
    double? heartRate,
    double? calories,
    double? steps,
    double? distance,
    double? speed,
  }) {
    emit(state.copyWith(
      pulseData: state.pulseData.copyWith(
        heartRate: heartRate,
        calories: calories,
        steps: steps,
        distance: distance,
        speed: speed,
      ),
    ));
  }

  Future<void> sendInformation() async {
    // TODO:
  }
}
