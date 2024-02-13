import 'package:pulse/core/models/pulse_data.dart';
import 'package:pulse/core/state/work/work_cubit.dart';

/// A state model for [WorkCubit].
class WorkCubitState {
  final bool progress;
  final PulseData pulseData;
  final String? error;

  const WorkCubitState({
    this.progress = false,
    this.pulseData = const PulseData(),
    this.error,
  });

  WorkCubitState copyWith({bool? progress, PulseData? pulseData, String? error}) {
    return WorkCubitState(
      progress: progress ?? this.progress,
      pulseData: pulseData ?? this.pulseData,
      error: error ?? this.error,
    );
  }
}
