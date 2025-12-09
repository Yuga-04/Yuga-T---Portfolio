import 'package:flutter/material.dart';
import 'package:portfolio/widgets/animated_card.dart';
import 'package:portfolio/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' show cos, sin, pi;

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen>
    with SingleTickerProviderStateMixin {
  bool _showAll = false;
  late AnimationController _animationController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat(min: 0.0, max: 1.0, period: const Duration(seconds: 25));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  void _toggleShowAll() {
    setState(() {
      _showAll = !_showAll;
    });

    if (!_showAll) {
      // Scroll to the top of this widget's position in the main scroll
      // Safe scroll after UI stabilizes
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 50), () {
          if (mounted) {
            Scrollable.ensureVisible(
              context,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOutCubic,
              alignment: 0.0,
            );
          }
        });
      });
    }

    // Always reset scroll position
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height - 65;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    final projects = [
      {
        'title': 'Torrq',
        'description':
            'A lightweight torrent management app that uses an online cloud torrenting service to fetch and process magnet links. It lets users quickly add torrents and generate direct download links through a clean, minimal interface.',
        'tech': ['Flutter', 'Dart'],
        'icon': Icons.download,
        'img': 'assets/project1.jpg',
        'url': 'https://github.com/Yuga-04/Torrq-Latest-Flutter',
      },
      {
        'title': 'Expense Tracker',
        'description':
            'A clean and user-friendly expense tracker to record and manage daily spending. Track expenses easily and gain insights to stay in control of your budget.',
        'tech': ['Flutter', 'Dart', 'Hive'],
        'icon': Icons.currency_rupee,
        'img': 'assets/project2.jpeg',
        'url': 'https://github.com/Yuga-04/Flutter-Expense-Tracker',
      },
      {
        'title': 'Employee Management Portal',
        'description':
            'A simple and efficient Employee Management System with separate employee and manager access. It helps manage tasks, profiles, and leave requests with an intuitive dashboard experience.',
        'tech': ['NextJS', 'Local Storage', 'Netlify'],
        'icon': Icons.emoji_people,
        'img': 'assets/project3.png',
        'url': 'https://github.com/Yuga-04/EmployeeManagement/tree/main',
      },
      {
        'title': 'Online Voting System',
        'description':
            'This online voting system demo provides a secure platform to cast votes remotely and increase voter participation. It ensures authentication using Aadhaar and OTP while preventing duplicate voting. The system includes admin controls for result monitoring and voter verification, along with voice-based voting support for accessibility.',
        'tech': ['HTML', 'CSS', 'JS', 'GitHub'],
        'icon': Icons.poll,
        'img': 'assets/project4.png',
        'url': 'https://github.com/Yuga-04/Online-Voting-System/tree/main',
      },
      {
        'title': 'IP Calculator',
        'description':
            'This lightweight command-line tool calculates network details like subnet, broadcast, host range, and CIDR from any given IP. It brings a Linux-style ipcalc experience to Windows with fast and clean output.',
        'tech': ['Python', 'CMD'],
        'icon': Icons.code,
        'img': 'assets/project5.png',
        'url': 'https://github.com/Yuga-04/IP-Calculator-for-windows',
      },
      {
        'title': 'Termux Developer Automation Toolkit',
        'description':
            'This project includes a URL shortener function, a local web server launcher, QR-based network sharing, a file receive server, a LeetCode daily folder generator, Git auto-commit and push automation, an SSH access shortcut, public tunneling for localhost access, system IP auto-detection, and multiple custom productivity aliases.',
        'tech': [
          'Bash',
          'cURL',
          'LocalTunnel & HTTP-Server',
          'npx qrcode-terminal',
        ],
        'icon': Icons.terminal,
        'img': 'assets/project6.png',
        'url': 'https://github.com/Yuga-04/',
      },
    ];

    final displayedProjects = _showAll ? projects : projects.take(2).toList();
    final remainingCount = projects.length - 2;

    return Container(
      width: screenWidth,
      constraints: BoxConstraints(minHeight: screenHeight),
      child: Stack(
        children: [
          // Animated Background
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment(
                        -0.3 + (_animationController.value * 0.6),
                        -0.5 + (_animationController.value * 1.0),
                      ),
                      radius: 1.5,
                      colors: const [
                        Color(0xFF1a1a1a),
                        Color(0xFF0a0a0a),
                        Color(0xFF000000),
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                );
              },
            ),
          ),

          // Animated grid pattern overlay
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return CustomPaint(
                  painter: GeometricPatternPainter(_animationController.value),
                );
              },
            ),
          ),

          // Main Content - Scrollable with proper constraints
          SingleChildScrollView(
            controller: _scrollController,
            physics: const ClampingScrollPhysics(),
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
                    // Header
                    Text(
                      'Featured Projects',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 28 : 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Some of my most recent project works',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 13 : 15,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: isMobile ? 40 : 50),

                    // Projects Grid with Animation
                    AnimatedSize(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOutCubic,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isMobile ? 1 : 2,
                          crossAxisSpacing: isMobile ? 16 : 24,
                          mainAxisSpacing: isMobile ? 16 : 24,
                          childAspectRatio: isMobile
                              ? 1.5
                              : isTablet
                              ? 1.7
                              : 1.9,
                        ),
                        itemCount: displayedProjects.length,
                        itemBuilder: (context, index) {
                          final project = displayedProjects[index];
                          return AnimatedCard(
                            delay: index,
                            child: _ProjectCard(
                              project: project,
                              isMobile: isMobile,
                              onTap: () => _launchURL(project['url'] as String),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Show More/Less Button
                    Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: ScaleTransition(
                              scale: animation,
                              child: child,
                            ),
                          );
                        },
                        child: _showAll
                            ? TextButton.icon(
                                key: const ValueKey('showLess'),
                                onPressed: _toggleShowAll,
                                style: ButtonStyle(
                                  overlayColor: WidgetStateProperty.all(
                                    Colors.white.withOpacity(0.1),
                                  ),
                                  foregroundColor:
                                      WidgetStateProperty.resolveWith((states) {
                                        if (states.contains(
                                          WidgetState.hovered,
                                        )) {
                                          return Colors.white; // hover color
                                        }
                                        return AppTheme.pureWhite.withOpacity(
                                          0.5,
                                        );
                                      }),
                                ),
                                icon: Icon(
                                  Icons.keyboard_arrow_up_rounded,
                                  color: AppTheme.pureWhite.withOpacity(0.7),
                                ),
                                label: Text(
                                  'Show Less',
                                  style: TextStyle(
                                    fontSize: isMobile ? 10 : 12,
                                    color: AppTheme.pureWhite.withOpacity(0.7),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            : TextButton.icon(
                                key: const ValueKey('showMore'),
                                onPressed: _toggleShowAll,
                                style: ButtonStyle(
                                  overlayColor: WidgetStateProperty.all(
                                    Colors.white.withOpacity(
                                      0.1,
                                    ), // click/press effect
                                  ),
                                  foregroundColor:
                                      WidgetStateProperty.resolveWith((states) {
                                        if (states.contains(
                                          WidgetState.hovered,
                                        )) {
                                          return Colors.white; // hover color
                                        }
                                        return AppTheme.pureWhite.withOpacity(
                                          0.5,
                                        );
                                      }),
                                ),
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: AppTheme.pureWhite.withOpacity(0.7),
                                ),
                                label: Text(
                                  'Show More +$remainingCount',
                                  style: TextStyle(
                                    fontSize: isMobile ? 10 : 12,
                                    color: AppTheme.pureWhite.withOpacity(0.7),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final Map<String, dynamic> project;
  final bool isMobile;
  final VoidCallback onTap;

  const _ProjectCard({
    required this.project,
    required this.isMobile,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Image.asset(
              project['img'] as String,
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(.35),
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF1a1a2e), Color(0xFF16213e)],
                    ),
                  ),
                );
              },
            ),

            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(.85),
                  ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
            ),

            // Content
            Padding(
              padding: EdgeInsets.all(isMobile ? 16 : 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        project['icon'] as IconData,
                        color: AppTheme.softWhite,
                        size: 24,
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: onTap,
                        icon: const Icon(
                          Icons.arrow_forward_rounded,
                          color: AppTheme.pureWhite,
                        ),
                        padding: const EdgeInsets.all(8),
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  Text(
                    project['title'] as String,
                    style: TextStyle(
                      fontSize: isMobile ? 18 : 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.8),
                          offset: const Offset(0, 2),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Text(
                      project['description'] as String,
                      style: TextStyle(
                        fontSize: isMobile ? 13 : 15,
                        color: Colors.white.withOpacity(0.95),
                        height: 1.4,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.8),
                            offset: const Offset(0, 1),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: (project['tech'] as List<String>).map((tech) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          border: Border.all(
                            color: AppTheme.pureWhite.withOpacity(0.4),
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          tech,
                          style: TextStyle(
                            fontSize: isMobile ? 10 : 11,
                            color: AppTheme.pureWhite,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GeometricPatternPainter extends CustomPainter {
  final double animationValue;

  GeometricPatternPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.white.withOpacity(0.04);

    // Draw animated diagonal lines
    paint.color = Colors.white.withOpacity(0.03);
    const lineSpacing = 80.0;
    final offset = animationValue * lineSpacing;

    for (
      double i = -size.height;
      i < size.width + size.height;
      i += lineSpacing
    ) {
      final startX = i + offset;
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX - size.height, size.height),
        paint,
      );
    }

    // Draw floating geometric shapes
    paint.style = PaintingStyle.fill;

    // Circle 1
    paint.color = Colors.white.withOpacity(0.02);
    final circle1X = size.width * (0.2 + animationValue * 0.3);
    final circle1Y = size.height * (0.3 - animationValue * 0.2);
    canvas.drawCircle(Offset(circle1X, circle1Y), 100, paint);

    // Circle 2
    paint.color = Colors.white.withOpacity(0.015);
    final circle2X = size.width * (0.8 - animationValue * 0.3);
    final circle2Y = size.height * (0.7 + animationValue * 0.2);
    canvas.drawCircle(Offset(circle2X, circle2Y), 150, paint);

    // Hexagon shape
    paint.color = Colors.white.withOpacity(0.02);
    final hexagonCenter = Offset(
      size.width * (0.6 + animationValue * 0.2),
      size.height * (0.4 + animationValue * 0.3),
    );
    _drawHexagon(canvas, paint, hexagonCenter, 80);

    // Small dots pattern
    const dotSpacing = 60.0;
    for (double x = 0; x < size.width; x += dotSpacing) {
      for (double y = 0; y < size.height; y += dotSpacing) {
        final dotOffset = (x + y) / dotSpacing * 0.1;
        final opacity = (animationValue + dotOffset) % 1.0;
        paint.color = Colors.white.withOpacity(0.02 * opacity);
        canvas.drawCircle(Offset(x, y), 2, paint);
      }
    }
  }

  void _drawHexagon(Canvas canvas, Paint paint, Offset center, double radius) {
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (i * 60 - 30) * pi / 180;
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant GeometricPatternPainter oldDelegate) {
    return false;
  }
}
