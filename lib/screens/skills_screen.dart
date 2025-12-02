import 'package:flutter/material.dart';
import 'package:portfolio/theme/app_theme.dart';
import 'dart:math' as math;

class SkillsScreen extends StatefulWidget {
  const SkillsScreen({super.key});

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 15),
    )..repeat();
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height - 65;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    final technicalSkills = [
      {'name': 'Java', 'icon': Icons.code, 'level': 85},
      {'name': 'C', 'icon': Icons.code_outlined, 'level': 70},
      {'name': 'Dart', 'icon': Icons.developer_mode, 'level': 90},
      {'name': 'Python', 'icon': Icons.terminal, 'level': 40},
      {'name': 'HTML', 'icon': Icons.html, 'level': 95},
      {'name': 'CSS', 'icon': Icons.css, 'level': 90},
      {'name': 'JavaScript', 'icon': Icons.javascript, 'level': 80},
    ];

    final frameworks = [
      {'name': 'Flutter', 'icon': Icons.phone_android},
      {'name': 'Git', 'icon': Icons.source},
      {'name': 'GitHub', 'icon': Icons.hub},
      {'name': 'VS Code', 'icon': Icons.code},
      {'name': 'Firebase', 'icon': Icons.local_fire_department},
      {'name': 'Cloudflare', 'icon': Icons.cloud_queue},
      {'name': 'Postman', 'icon': Icons.send},
      {'name': 'Linux', 'icon': Icons.terminal},
      {'name': 'Figma', 'icon': Icons.design_services},
    ];

    final softSkills = [
      'Problem Solving',
      'Critical Thinking',
      'Team Collaboration',
      'Communication',
      'Leadership',
      'Fast Learner',
      'Adaptability',
    ];

    final horizontalPadding = isMobile
        ? 4.0
        : isTablet
        ? 10.0
        : 30.0;
    final verticalPadding = isMobile ? 16.0 : 20.0;

    return ClipRect(
      child: Stack(
        children: [
          // Animated Background
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _backgroundController,
              builder: (context, child) {
                return CustomPaint(
                  painter: GeometricBackgroundPainter(
                    animationValue: _backgroundController.value,
                  ),
                );
              },
            ),
          ),
          // Main Content
          Container(
            width: screenWidth,
            height: screenHeight,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Skill & Expertise',
                          style: TextStyle(
                            fontSize: isMobile ? 28 : 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Technologies, traits & tools I master',
                          style: TextStyle(
                            fontSize: isMobile ? 13 : 15,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: isMobile ? 10 : 30),
                  // Main Content Grid
                  Expanded(
                    child: isMobile
                        ? SingleChildScrollView(
                            child: Column(
                              children: [
                                _buildProgrammingLanguages(
                                  technicalSkills,
                                  isMobile,
                                  isTablet,
                                ),
                                SizedBox(height: 16),
                                _buildFrameworksTools(
                                  frameworks,
                                  isMobile,
                                  isTablet,
                                ),
                                SizedBox(height: 16),
                                _buildSoftSkills(
                                  softSkills,
                                  isMobile,
                                  isTablet,
                                ),
                              ],
                            ),
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Left Column
                              Expanded(
                                flex: 1,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      _buildFrameworksTools(
                                        frameworks,
                                        isMobile,
                                        isTablet,
                                      ),
                                      SizedBox(height: 16),
                                      _buildSoftSkills(
                                        softSkills,
                                        isMobile,
                                        isTablet,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              // Right Column
                              Expanded(
                                flex: 1,
                                child: SingleChildScrollView(
                                  child: _buildProgrammingLanguages(
                                    technicalSkills,
                                    isMobile,
                                    isTablet,
                                  ),
                                ),
                              ),
                            ],
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

  Widget _buildProgrammingLanguages(
    List<Map<String, dynamic>> skills,
    bool isMobile,
    bool isTablet,
  ) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      decoration: BoxDecoration(
        color: AppTheme.deepBlack.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderWhite, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'PROGRAMMING LANGUAGES / WEB TECHNOLOGIES',
            style: TextStyle(
              fontSize: isMobile ? 12 : 14,
              fontWeight: FontWeight.bold,
              color: AppTheme.pureWhite,
              letterSpacing: 1,
            ),
          ),
          SizedBox(height: isMobile ? 16 : 20),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 2 : 4,
              crossAxisSpacing: isMobile ? 12 : 10,
              mainAxisSpacing: isMobile ? 12 : 20,
              childAspectRatio: 1.0,
            ),
            itemCount: skills.length,
            itemBuilder: (context, index) {
              final skill = skills[index];
              return _buildCircularSkill(
                icon: skill['icon'] as IconData,
                name: skill['name'] as String,
                level: skill['level'] as int,
                isMobile: isMobile,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCircularSkill({
    required IconData icon,
    required String name,
    required int level,
    required bool isMobile,
  }) {
    final size = isMobile ? 50.0 : 70.0;
    final iconSize = isMobile ? 22.0 : 28.0;
    final fontSize = isMobile ? 9.0 : 11.0;
    final percentSize = isMobile ? 12.0 : 14.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              TweenAnimationBuilder<double>(
                duration: Duration(milliseconds: 1500),
                curve: Curves.easeOutCubic,
                tween: Tween(begin: 0.0, end: level / 100),
                builder: (context, value, child) {
                  return CustomPaint(
                    size: Size(size, size),
                    painter: CircularProgressPainter(
                      progress: value,
                      strokeWidth: 3.0,
                      backgroundColor: AppTheme.borderWhite.withOpacity(0.2),
                      progressColor: AppTheme.pureWhite,
                    ),
                  );
                },
              ),
              Icon(icon, color: AppTheme.pureWhite, size: iconSize),
            ],
          ),
        ),
        SizedBox(height: 6),
        Text(
          name,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: AppTheme.pureWhite,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 2),
        Text(
          '$level%',
          style: TextStyle(
            fontSize: percentSize,
            fontWeight: FontWeight.bold,
            color: AppTheme.pureWhite,
          ),
        ),
      ],
    );
  }

  Widget _buildFrameworksTools(
    List<Map<String, dynamic>> frameworks,
    bool isMobile,
    bool isTablet,
  ) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      decoration: BoxDecoration(
        color: AppTheme.deepBlack.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderWhite, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'FRAMEWORKS / TOOLS',
            style: TextStyle(
              fontSize: isMobile ? 12 : 14,
              fontWeight: FontWeight.bold,
              color: AppTheme.pureWhite,
              letterSpacing: 1,
            ),
          ),
          SizedBox(height: isMobile ? 16 : 20),
          Wrap(
            spacing: isMobile ? 8 : 10,
            runSpacing: isMobile ? 8 : 10,
            children: frameworks.asMap().entries.map((entry) {
              // final index = entry.key;
              final framework = entry.value;
              return _buildFrameworkChip(
                icon: framework['icon'] as IconData,
                name: framework['name'] as String,
                isMobile: isMobile,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFrameworkChip({
    required IconData icon,
    required String name,
    required bool isMobile,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 10 : 14,
        vertical: isMobile ? 6 : 8,
      ),
      decoration: BoxDecoration(
        color: AppTheme.deepBlack,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.borderWhite, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppTheme.pureWhite, size: isMobile ? 14 : 16),
          SizedBox(width: 6),
          Text(
            name,
            style: TextStyle(
              color: AppTheme.pureWhite,
              fontSize: isMobile ? 11 : 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSoftSkills(List<String> skills, bool isMobile, bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      decoration: BoxDecoration(
        color: AppTheme.deepBlack.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderWhite, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SOFT SKILLS',
            style: TextStyle(
              fontSize: isMobile ? 12 : 14,
              fontWeight: FontWeight.bold,
              color: AppTheme.pureWhite,
              letterSpacing: 1,
            ),
          ),
          SizedBox(height: isMobile ? 14 : 18),
          Wrap(
            spacing: isMobile ? 8 : 10,
            runSpacing: isMobile ? 8 : 10,
            children: skills.asMap().entries.map((entry) {
              // final index = entry.key;
              final skill = entry.value;
              return _buildSoftSkillChip(skill, isMobile);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSoftSkillChip(String skill, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 16,
        vertical: isMobile ? 8 : 8,
      ),
      decoration: BoxDecoration(
        color: AppTheme.deepBlack,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderWhite, width: 1),
      ),
      child: Text(
        skill,
        style: TextStyle(
          color: AppTheme.pureWhite,
          fontSize: isMobile ? 11 : 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// Geometric Background Painter with animated lines and dots
class GeometricBackgroundPainter extends CustomPainter {
  final double animationValue;

  GeometricBackgroundPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    // Base gradient
    final gradientPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF000000), Color(0xFF0a0a0a), Color(0xFF000000)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      gradientPaint,
    );

    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..style = PaintingStyle.fill;

    // Animated diagonal lines
    final lineCount = 8;
    for (int i = 0; i < lineCount; i++) {
      final offset = (animationValue * size.width * 0.3);
      final startY = (size.height / lineCount) * i;
      final path = Path();
      path.moveTo(-100 + offset, startY);
      path.lineTo(size.width * 0.4 + offset, startY + size.height * 0.3);
      canvas.drawPath(path, linePaint);
    }

    // Animated dots grid
    final dotSpacing = 80.0;
    final cols = (size.width / dotSpacing).ceil();
    final rows = (size.height / dotSpacing).ceil();
    for (int col = 0; col < cols; col++) {
      for (int row = 0; row < rows; row++) {
        final x =
            col * dotSpacing + (animationValue * 20 * math.sin(row * 0.5));
        final y =
            row * dotSpacing + (animationValue * 20 * math.cos(col * 0.5));
        final pulseSize =
            2.0 + math.sin(animationValue * 2 * math.pi + col + row) * 1.0;
        canvas.drawCircle(Offset(x, y), pulseSize, dotPaint);
      }
    }

    // Animated circles
    final circlePaint = Paint()
      ..color = Colors.white.withOpacity(0.04)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Circle 1 - top right
    final circle1Radius = 150 + math.sin(animationValue * 2 * math.pi) * 30;
    canvas.drawCircle(
      Offset(size.width * 0.85, size.height * 0.15),
      circle1Radius,
      circlePaint,
    );

    // Circle 2 - bottom left
    final circle2Radius = 180 + math.cos(animationValue * 2 * math.pi) * 40;
    canvas.drawCircle(
      Offset(size.width * 0.15, size.height * 0.85),
      circle2Radius,
      circlePaint,
    );

    // Circle 3 - center
    final circle3Radius = 120 + math.sin(animationValue * 2 * math.pi + 1) * 25;
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.5),
      circle3Radius,
      circlePaint,
    );

    // Animated connecting lines between some dots
    final connectionPaint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1.0;
    for (int i = 0; i < 10; i++) {
      final angle1 = animationValue * 2 * math.pi + i * 0.6;
      final angle2 = animationValue * 2 * math.pi + i * 0.8;
      final x1 = size.width * 0.5 + math.cos(angle1) * size.width * 0.3;
      final y1 = size.height * 0.5 + math.sin(angle1) * size.height * 0.3;
      final x2 = size.width * 0.5 + math.cos(angle2) * size.width * 0.25;
      final y2 = size.height * 0.5 + math.sin(angle2) * size.height * 0.25;
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), connectionPaint);
    }
  }

  @override
  bool shouldRepaint(GeometricBackgroundPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color backgroundColor;
  final Color progressColor;

  CircularProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, backgroundPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * math.pi * progress;
    if (sweepAngle > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        sweepAngle,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class NoScrollbarBehavior extends ScrollBehavior {
  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
