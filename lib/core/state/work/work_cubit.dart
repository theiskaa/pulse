import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse/core/constants.dart';
import 'package:pulse/core/models/pulse_data.dart';
import 'package:pulse/core/services/fire.dart';
import 'package:pulse/core/state/work/work_state.dart';
import 'package:pulse_kit/pulse_kit.dart';

export 'work_state.dart';

/// The main state manager cubit for work pulse data management.
class WorkCubit extends Cubit<WorkCubitState> {
  final pulsekit = PulseKit();
  final fireService = FirestoreService();

  WorkCubit() : super(const WorkCubitState()) {
    pulsekit.stream.listen((event) async {
      switch (event.feature) {
        case PulseWorkoutType.unknown:
          return;
        case PulseWorkoutType.heartRate:
          await pulseEvent(heartRate: event.value);
          break;
        case PulseWorkoutType.calories:
          await pulseEvent(calories: event.value);
          break;
        case PulseWorkoutType.steps:
          await pulseEvent(steps: event.value);
          break;
        case PulseWorkoutType.distance:
          await pulseEvent(distance: event.value);
          break;
        case PulseWorkoutType.speed:
          await pulseEvent(speed: event.value);
          break;
      }
    });
  }

  /// Method that is used to execute start of working process.
  Future<void> startWork() async {
    final result = await pulsekit.start(
      enableGps: true,
      exerciseType: PulseType.walking,
      features: workfeatures,
    );

    if (result.unsupportedWorkoutTypes.isNotEmpty) {
      emit(state.copyWith(error: 'There is unsupported workout types: ${result.unsupportedWorkoutTypes}'));
    }

    if (workfeatures.length >= result.unsupportedWorkoutTypes.length) {
      emit(state.copyWith(progress: true));
    }
  }

  /// Method that is used to execute stop of working process.
  Future<void> stopWork() async {
    await pulsekit.stop();
    emit(state.copyWith(progress: false));
  }

  /// A event handler method that will be triggered any time we got new event
  /// from body sensors of wearable device.
  Future<void> pulseEvent({
    double? heartRate,
    double? calories,
    double? steps,
    double? distance,
    double? speed,
  }) async {
    final updated = state.pulseData.copyWith(
      heartRate: heartRate,
      calories: calories,
      steps: steps,
      distance: distance,
      speed: speed,
    );

    emit(state.copyWith(pulseData: updated));
    await sendInformation(updated);
  }

  /// A method that updates pulse data on each event.
  Future<void> sendInformation(PulseData pulse) async {
    await fireService.updatePulseData(pulse);
  }
}
