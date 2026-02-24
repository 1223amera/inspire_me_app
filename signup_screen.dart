import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // سطر الاستيراد الضروري

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key}); // حذفنا const من هنا عشان المجسات

  // 1. المجسات (Controllers)
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("إنشاء حساب جديد")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // 2. خانة البريد
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "البريد الإلكتروني"),
            ),
            // 3. خانة الباسورد
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "كلمة السر"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            // 4. الزر السحري
            ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
                  print("تم إنشاء الحساب بنجاح في Firebase!");
                } catch (e) {
                  print("حدث خطأ: $e");
                }
              },
              child: const Text("سجل الآن"),
            ),
          ],
        ),
      ),
    );
  }
}
