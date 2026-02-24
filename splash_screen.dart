import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

// استيراد ملفاتك الخاصة - تأكد من صحة المسارات في مشروعك
import 'login_screen.dart';
import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),

      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Colors.cyanAccent),
            ),
          );
        }

        // 2. إذا كان المستخدم "موجود" (مسجل دخول)
        if (snapshot.hasData) {
          return const ModernHomeScreen();
        }

        // 3. إذا كان المستخدم "غير موجود" (لم يسجل أو سجل خروج)
        // يتم توجيهه للسبلاش التي تقود لصفحة LoginScreen
        return const LuxurySplash();
      },
    );
  }
}

// --- صفحة الـ Splash
class LuxurySplash extends StatefulWidget {
  const LuxurySplash({super.key});

  @override
  State<LuxurySplash> createState() => _LuxurySplashState();
}

class _LuxurySplashState extends State<LuxurySplash>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _particleController;
  late Animation<double> _pulseAnimation;
  final List<Particle> _particles = List.generate(25, (index) => Particle());

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0F0C29),
                  Color(0xFF302B63),
                  Color(0xFF24243E),
                ],
              ),
            ),
          ),
          // جزيئات متحركة لإعطاء لمسة احترافية
          AnimatedBuilder(
            animation: _particleController,
            builder: (context, child) => CustomPaint(
              painter: ParticlePainter(_particles, _particleController.value),
              child: Container(),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: _pulseAnimation,
                  child: const Icon(
                    Icons.flash_on_rounded,
                    size: 120,
                    color: Colors.cyanAccent,
                  ),
                ),
                const SizedBox(height: 40),
                _buildEntryCard(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEntryCard(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Column(
            children: [
              const Text(
                "Welcome Back",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  // يذهب لصفحة تسجيل الدخول التي تملكها
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "Get Started",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Particle {
  double x = Random().nextDouble();
  double y = Random().nextDouble();
  double speed = Random().nextDouble() * 0.1 + 0.02;
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double progress;
  ParticlePainter(this.particles, this.progress);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.cyanAccent.withOpacity(0.2);
    for (var p in particles) {
      double curY = ((p.y + progress * p.speed) % 1.0) * size.height;
      canvas.drawCircle(Offset(p.x * size.width, curY), 2, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
