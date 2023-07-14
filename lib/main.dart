import 'package:flutter/material.dart';
import 'package:flutter_provider_app/pages/home_page.dart';
import 'package:flutter_provider_app/pages/login_page.dart';
import 'package:flutter_provider_app/pages/splash_page.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/counter_provider.dart';
import 'providers/second_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider()..checkAuth(),
        ),
        ChangeNotifierProvider(
          create: (context) => Counter(),
        ),
        ChangeNotifierProvider(
          create: (context) => SecondProvider(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}
