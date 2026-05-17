import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'screens/home_screen.dart';
import 'screens/future_screen.dart';
import 'screens/timer_screen.dart';
import 'screens/isolate_screen.dart';
import 'screens/login_screen.dart';
import 'screens/evidence_screen.dart';
import 'screens/universities_screen.dart';
import 'services/university_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Intentar inicializar Firebase con las opciones de configuración
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    UniversityService.useMock = false; // Todo bien, usar Firestore
  } catch (e) {
    debugPrint("Firebase no pudo inicializarse (es posible que las credenciales de firebase_options.dart sean placeholders): $e");
    UniversityService.useMock = true; // Activar el fallback simulado en memoria
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taller Asincronía, JWT & Firebase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/future': (context) => const FutureScreen(),
        '/timer': (context) => const TimerScreen(),
        '/isolate': (context) => const IsolateScreen(),
        '/login': (context) => const LoginScreen(),
        '/evidence': (context) => const EvidenceScreen(),
        '/universities': (context) => const UniversitiesScreen(),
      },
    );
  }
}
