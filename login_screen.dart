import 'package:flutter/material.dart';
import 'home_screen.dart'; // تأكدي إن اسم الملف عندك هيك بالظبط

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // خلفية غامقة عشان تبرز ألوان النيون اللي طلبتها نور
      backgroundColor: const Color(0xFF0A0E21),
      body: Stack(
        children: [
          // إضافة لمسة جمالية (دوائر ضبابية خلفية)
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.cyanAccent.withOpacity(0.1),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // أيقونة متوهجة باللون النيون
                  const Icon(
                    Icons.lightbulb_outline,
                    size: 80,
                    color: Colors.cyanAccent,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Inspire Me",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyanAccent,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 50),

                  // حقل الإيميل (بالستايل اللي بعتته نور)
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "البريد الإلكتروني",
                      filled: true,
                      fillColor: Colors.white10,
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.cyanAccent,
                      ),
                      hintStyle: const TextStyle(color: Colors.white24),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.cyanAccent.withOpacity(0.3),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.cyanAccent),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // حقل كلمة المرور (بالستايل اللي بعتته نور)
                  TextField(
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "كلمة المرور",
                      filled: true,
                      fillColor: Colors.white10,
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.cyanAccent,
                      ),
                      hintStyle: const TextStyle(color: Colors.white24),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.cyanAccent.withOpacity(0.3),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.cyanAccent),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // زر الدخول النيون
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyanAccent,
                        foregroundColor: const Color(0xFF0A0E21),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 10,
                        shadowColor: Colors.cyanAccent.withOpacity(0.5),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ModernHomeScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "تسجيل الدخول",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
