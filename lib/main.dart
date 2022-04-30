import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_manager/providers/auth_provider.dart';
import 'package:task_manager/screens/home_screen.dart';
import 'package:task_manager/screens/launch_screen.dart';
import 'package:task_manager/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      routes: {
        'splash': (_) => const SplashScreen(),
        'launch': (_) => const LaunchScreen(),
        'home': (_) => const HomeScreen()
      },
      initialRoute: 'splash',
    );
  }
}
