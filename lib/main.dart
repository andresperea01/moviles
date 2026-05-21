import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'providers/universidad_provider.dart';
import 'screens/home_screen.dart';
import 'screens/future_screen.dart';
import 'screens/timer_screen.dart';
import 'screens/isolate_screen.dart';
import 'screens/login_screen.dart';
import 'screens/evidence_screen.dart';
import 'screens/universidades_list_screen.dart';
import 'screens/universidades_evidence_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UniversidadProvider()),
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
      title: 'Taller Móviles — Firebase',
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
        '/universidades': (context) => const UniversidadesListScreen(),
        '/universidades-evidence': (context) =>
            const UniversidadesEvidenceScreen(),
      },
    );
  }
}
