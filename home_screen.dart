import 'package:flutter/material.dart';
import 'dart:ui';
import 'database_helper.dart';

class ModernHomeScreen extends StatefulWidget {
  const ModernHomeScreen({super.key});
  @override
  State<ModernHomeScreen> createState() => _ModernHomeScreenState();
}

class _ModernHomeScreenState extends State<ModernHomeScreen> {
  bool isFavorite = false;
  int index = 0;
  List<String> dynamicQuotes = [];

  @override
  void initState() {
    super.initState();
    _refreshQuotes();
  }

  void _refreshQuotes() async {
    final data = await DatabaseHelper.instance.getAllQuotes();
    setState(() {
      dynamicQuotes = data.isEmpty
          ? ["اضغطي على + لإضافة أول حكمة سحرية! ✨"]
          : data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A12),
      body: Stack(
        children: [
          _buildGlow(Colors.pinkAccent.withOpacity(0.3), -50, -50, null, null),
          _buildGlow(Colors.cyanAccent.withOpacity(0.2), null, null, -50, -50),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  _header(),
                  const Spacer(),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: dynamicQuotes.isEmpty
                        ? const CircularProgressIndicator(
                            color: Colors.cyanAccent,
                          )
                        : _glassCard(key: ValueKey<int>(index)),
                  ),
                  const Spacer(),
                  _bottomBar(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _header() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        "Inspirations ✨",
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
      ),
      IconButton(
        icon: const Icon(Icons.bookmarks_rounded, color: Colors.cyanAccent),
        onPressed: () {}, // هنا تربط صفحة المفضلة لاحقاً
      ),
    ],
  );

  Widget _glassCard({Key? key}) => ClipRRect(
    key: key,
    borderRadius: BorderRadius.circular(30),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            const Icon(Icons.format_quote, size: 50, color: Colors.cyanAccent),
            const SizedBox(height: 20),
            Text(
              dynamicQuotes[index % dynamicQuotes.length],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, color: Colors.white),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    ),
  );

  Widget _bottomBar() => Row(
    children: [
      Expanded(
        child: SizedBox(
          height: 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pinkAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () =>
                setState(() => index = (index + 1) % dynamicQuotes.length),
            child: const Text(
              "Inspire Me ✨",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
      const SizedBox(width: 15),
      GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => AddQuoteScreen(onAdd: _refreshQuotes),
          ),
        ),
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
    ],
  );

  Widget _buildGlow(Color color, double? t, double? l, double? b, double? r) =>
      Positioned(
        top: t,
        left: l,
        bottom: b,
        right: r,
        child: Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            boxShadow: [BoxShadow(color: color, blurRadius: 100)],
          ),
        ),
      );
}

// شاشة الإضافة
class AddQuoteScreen extends StatelessWidget {
  final Function onAdd;
  final TextEditingController controller = TextEditingController();

  AddQuoteScreen({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A12),
      appBar: AppBar(
        title: const Text("Create Magic"),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Write your inspiration...",
                hintStyle: const TextStyle(color: Colors.white24),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
              ),
              onPressed: () async {
                if (controller.text.isNotEmpty) {
                  await DatabaseHelper.instance.insertQuote(controller.text);
                  onAdd();
                  Navigator.pop(context);
                }
              },
              child: const Text(
                "Save to SQLite",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
