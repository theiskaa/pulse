import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_circular_text/circular_text.dart';
import 'package:pulse/core/state/work/work_cubit.dart';
import 'package:wear/wear.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AmbientMode(
      builder: (context, mode, child) => child!,
      child: Scaffold(
        body: Center(
          child: BlocBuilder<WorkCubit, WorkCubitState>(builder: (context, state) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: !state.progress ? const Color(0xffFBF8BE) : const Color(0xff234E70),
              ),
              child: Center(
                child: Builder(builder: (context) {
                  if (!state.progress) return const Initial();
                  return Progress(state: state);
                }),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class Initial extends StatelessWidget {
  const Initial({super.key});

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(color: Colors.white, fontSize: 20);
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xff234E70),
      ),
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xffFBF8BE),
        ),
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xff234E70),
          ),
          child: Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff234E70),
            ),
            child: Stack(
              alignment: Alignment.center,
              textDirection: TextDirection.rtl,
              fit: StackFit.loose,
              clipBehavior: Clip.hardEdge,
              children: [
                CircularText(
                  children: [
                    TextItem(
                      text: const Text('Tap to Start Work', style: style),
                      space: 8,
                      startAngle: 90,
                      startAngleAlignment: StartAngleAlignment.center,
                      direction: CircularTextDirection.anticlockwise,
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    pressedOpacity: .5,
                    onPressed: () async {
                      await context.read<WorkCubit>().startWork();
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffFBF8BE),
                      ),
                      child: const Center(
                        child: Text(
                          'Start',
                          style: TextStyle(
                            color: Color(0xff234E70),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Progress extends StatelessWidget {
  final WorkCubitState state;
  const Progress({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(color: Colors.white, fontSize: 20);
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xffFBF8BE),
      ),
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff234E70),
        ),
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffFBF8BE),
          ),
          child: Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff234E70),
            ),
            child: Stack(
              alignment: Alignment.center,
              textDirection: TextDirection.rtl,
              fit: StackFit.loose,
              clipBehavior: Clip.hardEdge,
              children: [
                CircularText(
                  children: [
                    TextItem(
                      text: Text(state.pulseData.toDisplayText(), style: style),
                      space: 5,
                      startAngle: -90,
                      startAngleAlignment: StartAngleAlignment.center,
                      direction: CircularTextDirection.clockwise,
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    pressedOpacity: .5,
                    onPressed: () async {
                      await context.read<WorkCubit>().stopWork();
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffFBF8BE),
                      ),
                      child: const Center(
                        child: Text(
                          'Stop',
                          style: TextStyle(
                            color: Color(0xff234E70),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
