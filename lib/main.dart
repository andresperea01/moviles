import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/future_screen.dart';
import 'screens/timer_screen.dart';
import 'screens/isolate_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taller Asincronía',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Definición de rutas para la navegación
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/future': (context) => const FutureScreen(),
        '/timer': (context) => const TimerScreen(),
        '/isolate': (context) => const IsolateScreen(),
      },
    );
  }
}
