// ignore_for_file: public_member_api_docs, sort_constructors_first
//import 'dart:async'; // Import this package for Future
//import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart'; // Import this package for rootBundle
import 'profile_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); 
  runApp(const MyApp()); 
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true, ),
        home: const ProfileWiew(),
      );
    }
}