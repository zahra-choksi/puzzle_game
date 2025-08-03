import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/game_screen.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Master Clone',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const GameScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
