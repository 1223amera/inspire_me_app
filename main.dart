import 'splash_screen.dart'; // هذا هو الاسم اللي اخترتيه
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyB2WH-UcqHyuEGkX4ZTmVoBXlWrxuLGxGE",
      appId: "1:1068892391377:web:f9b8cf91d10021668802f0",
      messagingSenderId: "1068892391377",
      projectId: "inspire-me-app-9e985",
      authDomain: "inspire-me-app-9e985.firebaseapp.com",
      storageBucket: "inspire-me-app-9e985.firebasestorage.app",
    ),
  );
  runApp(const InspireMeApp());
}

class InspireMeApp extends StatelessWidget {
  const InspireMeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inspire Me App',
      theme: ThemeData(primaryColor: Colors.blue, useMaterial3: true),
      home: LuxurySplash(),
    );
  }
}
