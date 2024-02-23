import 'dart:async';
import 'package:flutter/material.dart';
import 'package:testing/animation_demo.dart';
import 'package:testing/main_screen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimationDemo(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Charging Animation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const MainScreen(),
    );
  }
}
