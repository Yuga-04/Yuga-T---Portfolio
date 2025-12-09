// lib/screens/about_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'package:portfolio/theme/app_theme.dart';

typedef HoverChangedCallback = void Function(bool hovering);

// Animated Background Widget
class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;
  late AnimationController _controller4;
  late AnimationController _controller5;
  late AnimationController _particleController;
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();

    _controller1 = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _controller2 = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();

    _controller3 = AnimationController(
      duration: const Duration(seconds: 25),
      vsync: this,
    )..repeat();

    _controller4 = AnimationController(
      duration: const Duration(seconds: 18),
      vsync: this,
    )..repeat();

    _controller5 = AnimationController(
      duration: const Duration(seconds: 22),
      vsync: this,
    )..repeat();

    _particleController = AnimationController(
      duration: const Duration(seconds: 12),
      vsync: this,
    )..repeat();

    _waveController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    _controller5.dispose();
    _particleController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // Animated wave lines in background
        ...List.generate(5, (index) {
          return AnimatedBuilder(
            animation: _waveController,
            builder: (context, child) {
              return CustomPaint(
                size: Size(screenWidth, screenHeight),
                painter: WavePainter(
                  progress: _waveController.value,
                  waveIndex: index,
                ),
              );
            },
          );
        }),

        // Gradient orb 1
        AnimatedBuilder(
          animation: _controller1,
          builder: (context, child) {
            return Positioned(
              left: -100 + (250 * math.sin(_controller1.value * 2 * math.pi)),
              top: -100 + (180 * math.cos(_controller1.value * 2 * math.pi)),
              child: Container(
                width: 450,
                height: 450,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.white.withOpacity(0.12),
                      Colors.white.withOpacity(0.06),
                      Colors.white.withOpacity(0.02),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            );
          },
        ),

        // Gradient orb 2
        AnimatedBuilder(
          animation: _controller2,
          builder: (context, child) {
            return Positioned(
              right: -150 + (200 * math.cos(_controller2.value * 2 * math.pi)),
              top: 100 + (250 * math.sin(_controller2.value * 2 * math.pi)),
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.white.withOpacity(0.1),
                      Colors.white.withOpacity(0.04),
                      Colors.white.withOpacity(0.01),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            );
          },
        ),

        // Gradient orb 3
        AnimatedBuilder(
          animation: _controller3,
          builder: (context, child) {
            return Positioned(
              left:
                  screenWidth / 2 -
                  250 +
                  (180 * math.sin(_controller3.value * 2 * math.pi * 0.5)),
              bottom: -150 + (120 * math.cos(_controller3.value * 2 * math.pi)),
              child: Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.white.withOpacity(0.11),
                      Colors.white.withOpacity(0.05),
                      Colors.white.withOpacity(0.02),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            );
          },
        ),

        // Gradient orb 4
        AnimatedBuilder(
          animation: _controller4,
          builder: (context, child) {
            return Positioned(
              left:
                  screenWidth * 0.7 +
                  (150 * math.cos(_controller4.value * 2 * math.pi)),
              bottom:
                  50 + (100 * math.sin(_controller4.value * 2 * math.pi * 0.7)),
              child: Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.white.withOpacity(0.09),
                      Colors.white.withOpacity(0.04),
                      Colors.white.withOpacity(0.01),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            );
          },
        ),

        // Gradient orb 5
        AnimatedBuilder(
          animation: _controller5,
          builder: (context, child) {
            return Positioned(
              left:
                  screenWidth * 0.2 +
                  (120 * math.sin(_controller5.value * 2 * math.pi * 0.6)),
              top:
                  screenHeight * 0.6 +
                  (140 * math.cos(_controller5.value * 2 * math.pi * 0.8)),
              child: Container(
                width: 380,
                height: 380,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.white.withOpacity(0.08),
                      Colors.white.withOpacity(0.03),
                      Colors.white.withOpacity(0.01),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            );
          },
        ),

        // Floating particles - increased count
        ...List.generate(20, (index) {
          return AnimatedBuilder(
            animation: _particleController,
            builder: (context, child) {
              final offset = (index * 0.05 + _particleController.value) % 1.0;
              final x =
                  screenWidth * math.sin(offset * 2 * math.pi + index * 0.5);
              final y = screenHeight * offset;
              final size = 3.0 + (index % 3) * 1.5;

              return Positioned(
                left: (screenWidth / 2 + x).clamp(0.0, screenWidth),
                top: y,
                child: Opacity(
                  opacity: (0.4 * math.sin(offset * math.pi)).abs(),
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.4),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }),

        // Diagonal floating particles
        ...List.generate(15, (index) {
          return AnimatedBuilder(
            animation: _controller1,
            builder: (context, child) {
              final progress = (_controller1.value + index * 0.067) % 1.0;
              final x = screenWidth * progress;
              final y =
                  screenHeight * 0.3 +
                  (100 * math.sin(progress * math.pi * 4 + index));

              return Positioned(
                left: x,
                top: y,
                child: Opacity(
                  opacity: (0.5 * math.sin(progress * math.pi)).abs(),
                  child: Container(
                    width: 2.5,
                    height: 2.5,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.3),
                          blurRadius: 4,
                          spreadRadius: 0.5,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }),

        // Pulsing rings
        ...List.generate(3, (index) {
          return AnimatedBuilder(
            animation: _controller2,
            builder: (context, child) {
              final progress = (_controller2.value + index * 0.33) % 1.0;
              final scale = 0.5 + progress * 2;
              final positions = [
                Offset(screenWidth * 0.15, screenHeight * 0.3),
                Offset(screenWidth * 0.85, screenHeight * 0.7),
                Offset(screenWidth * 0.5, screenHeight * 0.5),
              ];

              return Positioned(
                left: positions[index].dx - (100 * scale),
                top: positions[index].dy - (100 * scale),
                child: Opacity(
                  opacity: (0.3 * (1 - progress)).clamp(0.0, 1.0),
                  child: Container(
                    width: 200 * scale,
                    height: 200 * scale,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),

        // Rotating dots pattern
        AnimatedBuilder(
          animation: _controller3,
          builder: (context, child) {
            return Stack(
              children: List.generate(12, (index) {
                final angle =
                    (2 * math.pi / 12) * index +
                    (_controller3.value * 2 * math.pi);
                final radius = 150.0;
                final x = screenWidth / 2 + radius * math.cos(angle);
                final y = screenHeight / 2 + radius * math.sin(angle);

                return Positioned(
                  left: x - 3,
                  top: y - 3,
                  child: Opacity(
                    opacity:
                        0.15 +
                        (0.15 *
                            math.sin(_controller3.value * 2 * math.pi + index)),
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.3),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ),

        // Horizontal scanning lines
        ...List.generate(4, (index) {
          return AnimatedBuilder(
            animation: _waveController,
            builder: (context, child) {
              final progress = (_waveController.value + index * 0.25) % 1.0;
              final y = screenHeight * progress;

              return Positioned(
                left: 0,
                top: y,
                child: Opacity(
                  opacity: (0.15 * math.sin(progress * math.pi)).abs(),
                  child: Container(
                    width: screenWidth,
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.white.withOpacity(0.3),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }
}

// Custom painter for wave lines
class WavePainter extends CustomPainter {
  final double progress;
  final int waveIndex;

  WavePainter({required this.progress, required this.waveIndex});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.03 + (waveIndex * 0.01))
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path = Path();
    final waveHeight = 40.0 + (waveIndex * 10);
    final waveLength = size.width / 3;
    final offset = progress * waveLength;
    final verticalOffset = size.height * (0.2 + waveIndex * 0.15);

    path.moveTo(-waveLength + offset, verticalOffset);

    for (double x = -waveLength; x <= size.width + waveLength; x += 10) {
      final adjustedX = x + offset;
      final y =
          verticalOffset +
          waveHeight * math.sin((adjustedX / waveLength) * 2 * math.pi);
      path.lineTo(adjustedX, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) => true;
}

class AnimatedCard extends StatefulWidget {
  final Widget child;
  final int delay;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final HoverChangedCallback? onHoverChanged;

  const AnimatedCard({
    super.key,
    required this.child,
    this.delay = 0,
    this.height,
    this.padding,
    this.onHoverChanged,
  });

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  bool _isHovered = false;

  void _handleEnter(PointerEnterEvent event) {
    setState(() => _isHovered = true);
    widget.onHoverChanged?.call(true);
  }

  void _handleExit(PointerExitEvent event) {
    setState(() => _isHovered = false);
    widget.onHoverChanged?.call(false);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    final card = MouseRegion(
      onEnter: _handleEnter,
      onExit: _handleExit,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: widget.height,
        transform: _isHovered && !isMobile
            ? (Matrix4.identity()..translate(0.0, -8.0))
            : Matrix4.identity(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovered ? AppTheme.pureWhite : AppTheme.borderWhite,
              width: 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppTheme.pureWhite.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.glassWhite,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: widget.padding ?? const EdgeInsets.all(0),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );

    return card
        .animate()
        .fadeIn(duration: 600.ms, delay: (widget.delay * 100).ms)
        .slideY(
          begin: 0.3,
          end: 0,
          duration: 600.ms,
          delay: (widget.delay * 100).ms,
        );
  }
}

class AboutScreen extends StatelessWidget {
  final HoverChangedCallback? onInnerHoverChanged;

  const AboutScreen({super.key, this.onInnerHoverChanged});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height + 65;
    final isDesktop = screenWidth > 900;
    final isTablet = screenWidth > 600 && screenWidth <= 900;

    return SizedBox(
      width: double.infinity,
      height: screenHeight,
      child: Stack(
        children: [
          // Animated background layer
          const Positioned.fill(child: AnimatedBackground()),

          // Content layer
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.all(
                isDesktop ? 30.0 : (isTablet ? 30.0 : 20.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildHeader(isDesktop),
                  SizedBox(height: isDesktop ? 20 : 20),
                  if (isDesktop)
                    Expanded(child: _buildDesktopGrid(context, isDesktop))
                  else
                    _buildMobileLayout(isDesktop),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ========== ADJUSTMENT PANEL ==========
  /// Change these values to customize the grid layout

  // Card dimensions
  static const double desktopCardHeight = 380.0;
  static const double cardWidthFactor = 0.90;
  static const double horizontalSpacing = 0.0;

  // Vertical offsets for staggered positioning
  static const double card1Offset = 20.0;
  static const double card2Offset = 100.0;
  static const double card3Offset = 20.0;
  static const double card4Offset = 100.0;

  /// ======================================

  Widget _buildDesktopGrid(BuildContext context, bool isDesktop) {
    final cardHeight = desktopCardHeight;

    final maxOffset = [
      card1Offset,
      card2Offset,
      card3Offset,
      card4Offset,
    ].reduce((a, b) => a > b ? a : b);
    final gridHeight = cardHeight + maxOffset + 20;

    return SizedBox(
      height: gridHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Card 1 - Bio
          Flexible(
            child: Transform.translate(
              offset: Offset(0, card1Offset),
              child: Align(
                alignment: Alignment.topCenter,
                child: FractionallySizedBox(
                  widthFactor: cardWidthFactor,
                  child: AnimatedCard(
                    delay: 1,
                    height: cardHeight,
                    padding: const EdgeInsets.all(20),
                    onHoverChanged: onInnerHoverChanged,
                    child: ScrollableContent(
                      title: 'Bio',
                      isDesktop: true,
                      richText: TextSpan(
                        style: TextStyle(fontSize: 15, height: 1.6),
                        children: [
                          TextSpan(
                            text: "A passionate ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text: "developer and technology enthusiast",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: ", currently pursuing ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text:
                                "B.Tech in Information Technology (2023–2027)",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text:
                                " at St. Joseph's Institute of Technology, Chennai. My journey into technology started with curiosity and grew into a mindset of ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text:
                                "building, experimenting, breaking, and improving.",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: "\n\nI explore ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text:
                                "modern tech stacks, cloud systems, automation, DevOps workflows",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: ", and scalable ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text: "software architectures.",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text:
                                " I enjoy understanding how things work under the hood — not just using technology but engineering it.",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text: "\n\nWhether it's deploying ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text: "self-hosted systems",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: ", creating optimized ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text: "automation pipelines",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: ", or building scalable and maintainable ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text: "web and mobile applications",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text:
                                ", my focus is always on performance, structure, and real-world utility.",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text:
                                "\n\nI believe in writing clean systems over just writing code — with principles like ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text:
                                "scalability, automation, reliability, maintainability",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: " guiding every project.",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text:
                                "\n\nThis is just the start — the long-term goal is to build, innovate, and contribute to systems that scale beyond individuals.",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: horizontalSpacing),

          // Card 2 - Strengths
          Flexible(
            child: Transform.translate(
              offset: Offset(0, card2Offset),
              child: Align(
                alignment: Alignment.topCenter,
                child: FractionallySizedBox(
                  widthFactor: cardWidthFactor,
                  child: AnimatedCard(
                    delay: 2,
                    height: cardHeight,
                    padding: const EdgeInsets.all(20),
                    onHoverChanged: onInnerHoverChanged,
                    child: ScrollableContent(
                      title: 'Strengths',
                      isDesktop: true,
                      richText: TextSpan(
                        style: const TextStyle(fontSize: 15, height: 1.6),
                        children: [
                          TextSpan(
                            text: "One of my strongest qualities is being a ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text: "fast learner",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text:
                                ", with the ability to quickly adapt to new environments, tools, and evolving technologies. I thrive in spaces where challenges push boundaries, and I enjoy exploring problems from a deeper technical perspective.",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text: "\n\nI'm deeply passionate about ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text:
                                "system architecture, automation, DevOps thinking, and structured problem-solving.",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text:
                                " I constantly analyze systems not just for how they work — but how they can be optimized, automated, or scaled with purpose.",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text:
                                "\n\nConsistency and discipline play a big role in how I work. I value ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text:
                                "clarity, structured learning, and meaningful progress",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text:
                                " over speed or shortcuts. Whether it's debugging a system, learning a new framework, or refining a solution, I approach it with focus, patience, and intentional depth.",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text:
                                "\n\nFuelled by curiosity and a drive to continuously improve, I believe real growth happens by staying consistent — learning, refining, and building a little better than yesterday.",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: horizontalSpacing),

          // Card 3 - Experience
          Flexible(
            child: Transform.translate(
              offset: Offset(0, card3Offset),
              child: Align(
                alignment: Alignment.topCenter,
                child: FractionallySizedBox(
                  widthFactor: cardWidthFactor,
                  child: AnimatedCard(
                    delay: 3,
                    height: cardHeight,
                    padding: const EdgeInsets.all(20),
                    onHoverChanged: onInnerHoverChanged,
                    child: ScrollableContent(
                      title: 'Experience',
                      isDesktop: true,
                      richText: TextSpan(
                        style: const TextStyle(fontSize: 15, height: 1.6),
                        children: [
                          TextSpan(
                            text: "I recently worked at ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text:
                                "Ethical Intelligent Technologies (EIT), Chennai",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: " for a period of ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text: "two months",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: ", where I worked as a ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text: "Team Lead",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: " on a full-scale ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text: "self-hosted ERPNext implementation.",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text:
                                " This role involved managing deployment, customization, modular configuration, and workflow automation while ensuring stable and scalable system behavior. Leading a team taught me decision-making, structured task delegation, and handling development with responsibility and clarity.",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text:
                                "\n\nBeyond professional work, my experience spans building practical solutions, exploring automation, and deploying self-hosted systems. I've worked on projects involving ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text:
                                "URL shorteners, media streaming pipelines, automation scripts,",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text:
                                " and custom workflows — focusing on reliability, structure, and real-world usage.",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text: "\n\nI've also integrated platforms like ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text: "ERPNext and Zoho Mail using APIs",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text:
                                ", enabling automated lead creation, attachment processing, and synchronized communication pipelines — deepening my understanding of API architecture and backend automation.",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text:
                                "\n\nOn the development side, I've worked with ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text: "Angular and Spring Boot",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text:
                                ", building modular frontend components and optimized backend services with clear separation of concerns and scalable patterns.",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text:
                                "\n\nI also maintain a consistently organized ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text: "LeetCode repository",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text:
                                " with automation around tracking problem-solving progress — improving my algorithmic thinking, patterns, and coding discipline.",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text:
                                "\n\nEvery project, deployment, and collaboration has strengthened not only my technical skillset but also my mindset — focusing on structure, clarity, responsibility, and systems that scale.",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: horizontalSpacing),

          // Card 4 - Hobbies
          Flexible(
            child: Transform.translate(
              offset: Offset(0, card4Offset),
              child: Align(
                alignment: Alignment.topCenter,
                child: FractionallySizedBox(
                  widthFactor: cardWidthFactor,
                  child: AnimatedCard(
                    delay: 4,
                    height: cardHeight,
                    padding: const EdgeInsets.all(20),
                    onHoverChanged: onInnerHoverChanged,
                    child: ScrollableContent(
                      title: 'Hobbies',
                      isDesktop: true,
                      richText: TextSpan(
                        style: const TextStyle(fontSize: 15, height: 1.6),
                        children: [
                          TextSpan(
                            text:
                                "Outside structured learning and development, I spend time exploring technology from a more experimental and creative side. A large part of my free time goes into ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text:
                                "coding, automation concepts, and solving technical challenges",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text:
                                " — not because I have to, but because I genuinely enjoy the process of building and optimizing things.",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text: "\n\nI also enjoy experimenting with ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text:
                                "UI/UX design in Flutter and frontend frameworks,",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text:
                                " where I get to convert ideas into clean interfaces and animations. This helps me balance creativity with technical thinking.",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text: "\n\nAnother area I enjoy is working with ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text:
                                "self-hosted systems and deployment environments",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text:
                                " — experimenting with servers, networking, and containerized services. Exploring how deployment pipelines, security, and system configuration work gives me a deeper understanding of how software behaves beyond just development.",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text:
                                "\n\nTo stay sharp in logic and pattern recognition, I regularly practice ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text: "algorithms and problem-solving on LeetCode,",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text:
                                " improving my analytical thinking and coding patterns over time.",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text:
                                "\n\nWhen I'm not building or solving something, I spend time learning passively through ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text:
                                "tech reviews, system design discussions, developer podcasts, and deep-dive content.",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text:
                                " This helps me stay updated with evolving trends, best practices, and perspectives from experienced engineers.",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          TextSpan(
                            text:
                                "\n\nOverall, my hobbies reflect curiosity — exploring technology not just as a career path but as something I genuinely enjoy learning, experimenting with, and growing alongside.",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(bool isDesktop) {
    const bioHeight = 300.0;
    const strengthsHeight = 280.0;
    const experienceHeight = 300.0;
    const hobbiesHeight = 300.0;

    return Column(
      children: [
        AnimatedCard(
          delay: 1,
          padding: const EdgeInsets.all(16),
          height: bioHeight,
          onHoverChanged: onInnerHoverChanged,
          child: const ScrollableContent(
            title: 'Bio',
            content:
                "A passionate developer and technology enthusiast, currently pursuing B.Tech in Information Technology (2023–2027) at St. Joseph's Institute of Technology, Chennai. I explore modern tech stacks, cloud systems, automation, and scalable architectures. I'm driven by curiosity and enjoy building systems from scratch — whether it's self-hosted services, automation scripts, or modern web/mobile applications.",
            isDesktop: false,
          ),
        ),
        const SizedBox(height: 14),
        AnimatedCard(
          delay: 2,
          padding: const EdgeInsets.all(16),
          height: strengthsHeight,
          onHoverChanged: onInnerHoverChanged,
          child: const ScrollableContent(
            title: 'Strengths',
            isDesktop: false,
            bulletPoints: [
              'Fast learner with strong adaptability to new tools and technologies',
              'Passionate about system architecture, automation, and problem solving',
              'Consistent, disciplined, and focused on continuous improvement',
            ],
          ),
        ),
        const SizedBox(height: 14),
        AnimatedCard(
          delay: 3,
          padding: const EdgeInsets.all(16),
          height: experienceHeight,
          onHoverChanged: onInnerHoverChanged,
          child: const ScrollableContent(
            title: 'Experience',
            isDesktop: false,
            bulletPoints: [
              'Built and deployed self-hosted systems like URL shorteners, automation scripts, Cloudflare HLS streaming, and custom workflows',
              'Integrated ERPNext with external platforms like Zoho Mail using APIs and automation',
              'Developed full-stack projects using Angular + Spring Boot and optimized backend workflows',
              'Maintains a structured LeetCode repository with automation for daily problem solving',
            ],
          ),
        ),
        const SizedBox(height: 14),
        AnimatedCard(
          delay: 4,
          padding: const EdgeInsets.all(16),
          height: hobbiesHeight,
          onHoverChanged: onInnerHoverChanged,
          child: const ScrollableContent(
            title: 'Hobbies',
            isDesktop: false,
            bulletPoints: [
              'Coding and exploring automation ideas',
              'UI/UX experimentation in Flutter',
              'Self-hosting servers and configuring deployments',
              'Practicing algorithms and solving LeetCode',
              'Watching tech reviews, system design content, and developer podcasts',
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'About Me',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isDesktop ? 35 : 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: -1,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "Build. Break. Learn. Repeat.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isDesktop ? 15 : 14,
            color: Colors.white.withOpacity(0.7),
            // fontStyle: FontStyle.italic,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

class ScrollableContent extends StatefulWidget {
  final String title;
  final String? content;
  final TextSpan? richText;
  final bool isDesktop;
  final List<String>? bulletPoints;

  const ScrollableContent({
    super.key,
    required this.title,
    this.content,
    this.richText,
    required this.isDesktop,
    this.bulletPoints,
  });

  @override
  State<ScrollableContent> createState() => _ScrollableContentState();
}

class _ScrollableContentState extends State<ScrollableContent> {
  final ScrollController _scrollController = ScrollController();
  double _scrollProgress = 0.0;
  double _maxTitleWidth = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    setState(() {
      _scrollProgress = maxScroll > 0
          ? (currentScroll / maxScroll).clamp(0.0, 1.0)
          : 0.0;
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
      fontSize: widget.isDesktop ? 22 : 18,
      fontWeight: FontWeight.bold,
      letterSpacing: -0.5,
      color: Colors.white,
    );

    final textPainter = TextPainter(
      text: TextSpan(text: widget.title, style: titleStyle),
      textDirection: TextDirection.ltr,
    )..layout();

    _maxTitleWidth = textPainter.width + 18;

    final headerWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.white.withOpacity(0.6)],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(widget.title, style: titleStyle),
          ],
        ),
        const SizedBox(height: 8),
        AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          height: 2,
          width: _maxTitleWidth * _scrollProgress.clamp(0.15, 1.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.white.withOpacity(0.6)],
            ),
            borderRadius: BorderRadius.circular(1),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.3),
                blurRadius: 4,
                spreadRadius: 0.5,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final parentHasBoundedHeight =
            constraints.maxHeight.isFinite && constraints.maxHeight > 0;

        if (parentHasBoundedHeight) {
          return SizedBox(
            height: constraints.maxHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headerWidget,
                Expanded(
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(
                      context,
                    ).copyWith(scrollbars: false),
                    child: ListView(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: _buildContentColumn(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [headerWidget, _buildContentColumn()],
          );
        }
      },
    );
  }

  Widget _buildContentColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.richText != null) RichText(text: widget.richText!),

        if (widget.richText == null && widget.content != null)
          Text(
            widget.content!,
            style: TextStyle(
              fontSize: widget.isDesktop ? 15 : 14,
              color: Colors.white.withOpacity(0.85),
              height: 1.7,
              letterSpacing: 0.3,
            ),
          ),

        if (widget.bulletPoints != null)
          ...widget.bulletPoints!.asMap().entries.map((entry) {
            final idx = entry.key;
            final point = entry.value;
            return TweenAnimationBuilder<double>(
              duration: Duration(milliseconds: 300 + (idx * 50)),
              tween: Tween(begin: 0.0, end: 1.0),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(20 * (1 - value), 0),
                    child: child,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.8),
                              Colors.white.withOpacity(0.4),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.2),
                              blurRadius: 4,
                              spreadRadius: 0.5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        point,
                        style: TextStyle(
                          fontSize: widget.isDesktop ? 15 : 14,
                          color: Colors.white.withOpacity(0.85),
                          height: 1.7,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        const SizedBox(height: 8),
      ],
    );
  }
}
