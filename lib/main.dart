import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse/core/state/work/work_cubit.dart';
import 'package:pulse/firebase_options.dart';
import 'package:pulse/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize firebase and firebase-sub-services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  return runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pulse',
      home: BlocProvider(
        create: (context) => WorkCubit(),
        child: const Home(),
      ),
      theme: ThemeData(
        visualDensity: VisualDensity.compact,
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          primary: Colors.white24,
          onBackground: Colors.white10,
          onSurface: Colors.white10,
        ),
      ),
    );
  }
}
