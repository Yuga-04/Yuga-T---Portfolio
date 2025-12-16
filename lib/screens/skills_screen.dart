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
  bool _isVisible = false;

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
      duration: const Duration(seconds: 8),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Screen became visible
    if (ModalRoute.of(context)?.isCurrent == true) {
      _startAnimation();
    } else {
      _stopAnimation();
    }
  }

  void _startAnimation() {
    if (!_isVisible) {
      _isVisible = true;
      _animationController.repeat();
    }
  }

  void _stopAnimation() {
    if (_isVisible) {
      _isVisible = false;
      _animationController.stop();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = width < 750;
    final isDesktop = width >= 1100;

    return ClipRect(
      child: Container(
        width: width,
        height: isDesktop ? screenHeight : null, // 👈 FIX HERE
        color: Colors.black,
        child: Stack(
          children: [
            if (_isVisible)
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

            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20 : 90,
                  vertical: isMobile ? 20 : 40,
                ),
                child: isMobile ? _mobileView() : _desktopView(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------- MOBILE --------------------------
  Widget _mobileView() {
    return Center(
      // <-- FIX: Center content
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _header(true),
          const SizedBox(height: 20),

          _mobileSection(
            "Technical Skills",
            Icons.code,
            Column(children: technicalSkills.map(_mobileProgress).toList()),
          ),
          const SizedBox(height: 20),

          _mobileSection(
            "Tools & Platforms",
            Icons.build_circle,
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center, // center chips
              children: tools.map(_mobileChip).toList(),
            ),
          ),

          const SizedBox(height: 20),

          _mobileSection(
            "Soft Skills",
            Icons.psychology,
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: softSkills.map(_mobileChip).toList(),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _mobileSection(String title, IconData icon, Widget child) {
    return Container(
      width: 350, // <-- Center width so it doesn't stretch left
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  // -------------------------- DESKTOP --------------------------
  Widget _desktopView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _header(false),
          const SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    _title("=> Technical Skills"),
                    const SizedBox(height: 20),
                    ...technicalSkills.map(_progress),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 300,
                color: Colors.white24,
                margin: const EdgeInsets.symmetric(horizontal: 50),
              ),
              Expanded(
                child: Column(
                  children: [
                    _title("=> Tools & Platforms"),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: tools.map(_chip).toList(),
                    ),
                    const SizedBox(height: 40),
                    _title("=> Soft Skills"),
                    const SizedBox(height: 20),
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
        ],
      ),
    );
  }

  // ---------------- REUSABLE UI ----------------
  Widget _header(bool mobile) => Column(
    children: [
      Text(
        'Skill & Expertise',
        style: TextStyle(
          fontSize: mobile ? 26 : 34,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 6),
      const Text(
        'Technologies, traits & tools I master',
        style: TextStyle(color: Colors.white70, fontSize: 14),
      ),
    ],
  );

  Widget _title(String txt) => Align(
    alignment: Alignment.centerLeft,
    child: Text(
      txt,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
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
            style: const TextStyle(color: Colors.white70),
          ),
        ),
        Expanded(
          child: LinearProgressIndicator(
            value: skill['level'] / 100,
            backgroundColor: Colors.white24,
            color: Colors.white,
            minHeight: 6,
          ),
        ),
        const SizedBox(width: 20),
        Text("${skill['level']}%", style: const TextStyle(color: Colors.white)),
      ],
    ),
  );

  Widget _mobileProgress(Map skill) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(skill['name'], style: const TextStyle(color: Colors.white)),
      const SizedBox(height: 6),
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: LinearProgressIndicator(
          value: skill['level'] / 100,
          backgroundColor: Colors.white24,
          color: Colors.white,
          minHeight: 6,
        ),
      ),
      const SizedBox(height: 14),
    ],
  );

  Widget _chip(String t) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white24),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Text(t, style: const TextStyle(color: Colors.white70)),
  );

  Widget _mobileChip(String t) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white10,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(t, style: const TextStyle(color: Colors.white)),
  );
}

// Faster animation
class FullEffectBackgroundPainter extends CustomPainter {
  final double v;
  FullEffectBackgroundPainter(this.v);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(.15);

    for (double x = 0; x < size.width; x += 80) {
      for (double y = 0; y < size.height; y += 80) {
        canvas.drawCircle(
          Offset(
            x + math.sin(v * 6 + y * .4) * 20, // increased speed
            y + math.cos(v * 6 + x * .4) * 20,
          ),
          2.4,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_) => true;
}
