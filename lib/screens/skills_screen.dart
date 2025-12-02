import 'package:flutter/material.dart';
import 'dart:math' as math;

class SkillsScreen extends StatefulWidget {
  const SkillsScreen({super.key});

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final technicalSkills = const [
    {'name': 'Java', 'level': 85},
    {'name': 'Dart', 'level': 90},
    {'name': 'JavaScript', 'level': 82},
    {'name': 'C', 'level': 70},
    {'name': 'Python', 'level': 60},
    {'name': 'HTML', 'level': 95},
    {'name': 'CSS', 'level': 89},
  ];

  final tools = const [
    'Flutter',
    'Git',
    'GitHub',
    'VS Code',
    'Firebase',
    'Cloudflare',
    'Postman',
    'Linux',
    'Figma',
  ];

  final softSkills = const [
    'Problem Solving',
    'Critical Thinking',
    'Team Collaboration',
    'Communication',
    'Leadership',
    'Fast Learner',
    'Adaptability',
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height - 65;
    final isMobile = screenWidth < 750;
    final isTablet = screenWidth >= 750 && screenWidth < 1100;

    return SizedBox(
      width: screenWidth,
      child: Stack(
        children: [
          /// 🔥 Animated Background
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (_, __) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment(
                        -0.3 + (_animationController.value * 0.7),
                        -0.4 + (_animationController.value * 0.9),
                      ),
                      radius: 1.6,
                      colors: const [
                        Color(0xFF111111),
                        Color(0xFF080808),
                        Colors.black,
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Positioned.fill(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (_, __) => CustomPaint(
                painter: FullEffectBackgroundPainter(
                  _animationController.value,
                ),
              ),
            ),
          ),

          /// 📌 Scroll content
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: screenHeight),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile
                        ? 20
                        : isTablet
                        ? 40
                        : 80,
                    vertical: isMobile ? 30 : 30,
                  ),
                  child: Column(
                    children: [
                      // --- Header + UI ---
                      Text(
                        'Skill & Expertise',
                        style: TextStyle(
                          fontSize: isMobile ? 28 : 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Technologies, traits & tools I master',
                        style: TextStyle(
                          fontSize: isMobile ? 13 : 15,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),

                      isMobile ? _mobileLayout() : _desktopLayout(screenHeight),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ====== DESKTOP VIEW ======
  Widget _desktopLayout(double screenHeight) {
    return SizedBox(
      // height: screenHeight - 200,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _title("=> Technical Skills"),
                const SizedBox(height: 20),
                ...technicalSkills.map(_progress),
              ],
            ),
          ),
          Container(
            width: 1,
            margin: const EdgeInsets.symmetric(horizontal: 50),
            height: screenHeight / 2 - 10,
            color: Colors.white24,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _title("=> Tools & Platforms"),
                const SizedBox(height: 15),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: tools.map(_chip).toList(),
                ),
                const SizedBox(height: 30),
                _title("=> Soft Skills"),
                const SizedBox(height: 15),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: softSkills.map(_chip).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ====== MOBILE VIEW ======
  Widget _mobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title("Technical Skills"),
        const SizedBox(height: 18),
        ...technicalSkills.map(_progress),
        const SizedBox(height: 30),
        _title("Tools & Platforms"),
        const SizedBox(height: 15),
        Wrap(spacing: 10, runSpacing: 10, children: tools.map(_chip).toList()),
        const SizedBox(height: 30),
        _title("Soft Skills"),
        const SizedBox(height: 18),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: softSkills.map(_chip).toList(),
        ),
      ],
    );
  }

  Widget _title(String text) => Text(
    text,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  );

  Widget _progress(Map skill) => Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            skill['name'],
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: skill['level'] / 100,
              minHeight: 7,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 40),
        Text("${skill['level']}%", style: const TextStyle(color: Colors.white)),
      ],
    ),
  );

  Widget _chip(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: Colors.white24),
      color: Colors.white10,
    ),
    child: Text(
      text,
      style: const TextStyle(color: Colors.white70, fontSize: 12),
    ),
  );
}

/// 🌌 FULL ANIMATED EFFECT BACKGROUND (Same as Project Page)
class FullEffectBackgroundPainter extends CustomPainter {
  final double value;
  FullEffectBackgroundPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final circlePaint = Paint()
      ..color = Colors.white.withOpacity(.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    /// Pulsing circles
    canvas.drawCircle(
      Offset(size.width * .85, size.height * .2),
      140 + math.sin(value * 6.2) * 30,
      circlePaint,
    );

    canvas.drawCircle(
      Offset(size.width * .18, size.height * .82),
      170 + math.cos(value * 6.2) * 35,
      circlePaint,
    );

    /// Diagonal animation lines
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(.05)
      ..strokeWidth = 1.5;

    for (int i = 0; i < 10; i++) {
      final off = value * size.width * .3;
      final y = (size.height / 10) * i;
      final path = Path()
        ..moveTo(-100 + off, y)
        ..lineTo(size.width * .5 + off, y + size.height * .3);
      canvas.drawPath(path, linePaint);
    }

    /// Floating dots
    final dotPaint = Paint()..color = Colors.white.withOpacity(.12);

    const spacing = 85;
    final cols = (size.width / spacing).ceil();
    final rows = (size.height / spacing).ceil();

    for (int col = 0; col < cols; col++) {
      for (int row = 0; row < rows; row++) {
        final x = col * spacing + math.sin(value * 4 + row * .6) * 25;
        final y = row * spacing + math.cos(value * 4 + col * .6) * 25;
        final r = 2.3 + math.sin(value * 9 + col + row) * 1.1;
        canvas.drawCircle(Offset(x, y), r, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(_) => true;
}
