import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio/widgets/social_icon_button.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  // const HomeScreen({Key? key}) : super(key: key);
  final Function(int)? onNavigate;

  const HomeScreen({super.key, this.onNavigate});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );

    // Start animation only AFTER layout + first render
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _controller.repeat(period: const Duration(seconds: 28));
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height - 65;
    final bool isMobile = screenWidth < 768;
    final bool isTablet = screenWidth >= 768 && screenWidth < 1024;

    return GestureDetector(
      child: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            // Background Gradient
            Positioned.fill(
              child: Container(
                height: screenHeight,
                width: screenWidth,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.primaryBlack,
                      AppTheme.deepBlack,
                      AppTheme.richBlack,
                    ],
                  ),
                ),
              ),
            ),

            // ENHANCED ANIMATED DOTS
            ...List.generate(
              isMobile
                  ? 20
                  : isTablet
                  ? 30
                  : 40,
              (index) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    final offset = _controller.value * 2 * math.pi;
                    // Spread dots more evenly across the entire screen
                    final x =
                        screenWidth *
                        (0.1 +
                            0.8 *
                                math.sin(offset + index * 0.8) *
                                math.cos(index * 0.5));
                    final y =
                        screenHeight *
                        (0.1 +
                            0.8 *
                                math.cos(offset + index * 0.8) *
                                math.sin(index * 0.5));
                    return Positioned(
                      left: x,
                      top: y,
                      child: Container(
                        width: isMobile ? 4 : 3,
                        height: isMobile ? 4 : 3,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.pureWhite.withOpacity(0.15),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.pureWhite.withOpacity(0.5),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),

            // Top Right Glowing Circle
            Positioned(
              top: screenHeight * 0.05,
              right: screenWidth * 0.05,
              child:
                  Container(
                        width: isMobile
                            ? 100
                            : isTablet
                            ? 150
                            : 250,
                        height: isMobile
                            ? 100
                            : isTablet
                            ? 150
                            : 250,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              AppTheme.pureWhite.withOpacity(0.05),
                              AppTheme.pureWhite.withOpacity(0.01),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      )
                      .animate(onPlay: (controller) => controller.repeat())
                      .fadeIn(duration: 2.seconds)
                      .scale(
                        begin: const Offset(0.8, 0.8),
                        end: const Offset(1.2, 1.2),
                        duration: 4.seconds,
                      ),
            ),

            // Bottom Left Glowing Circle
            Positioned(
              bottom: screenHeight * 0.1,
              left: screenWidth * 0.02,
              child:
                  Container(
                        width: isMobile
                            ? 120
                            : isTablet
                            ? 200
                            : 300,
                        height: isMobile
                            ? 120
                            : isTablet
                            ? 200
                            : 300,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              AppTheme.pureWhite.withOpacity(0.04),
                              AppTheme.pureWhite.withOpacity(0.01),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      )
                      .animate(onPlay: (controller) => controller.repeat())
                      .fadeIn(duration: 2.seconds, delay: 1.seconds)
                      .scale(
                        begin: const Offset(1.0, 1.0),
                        end: const Offset(1.3, 1.3),
                        duration: 5.seconds,
                      ),
            ),

            // Profile Image - Positioned on right center for desktop
            if (!isMobile && !isTablet)
              Positioned(
                right: screenWidth * 0.1,
                top: screenHeight * 0.5 - 150, // Center vertically
                child:
                    Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppTheme.pureWhite.withOpacity(0.3),
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.pureWhite.withOpacity(0.2),
                                blurRadius: 30,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/profile.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: AppTheme.pureWhite.withOpacity(0.1),
                                  child: Icon(
                                    Icons.person,
                                    size: 150,
                                    color: AppTheme.pureWhite.withOpacity(0.7),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 800.ms)
                        .scale(begin: const Offset(0.5, 0.5))
                        .then()
                        .shimmer(
                          duration: 2.seconds,
                          color: AppTheme.pureWhite.withOpacity(0.3),
                        ),
              ),

            // Main Content (without SingleChildScrollView)
            Positioned(
              top: isMobile || isTablet ? 0 : screenHeight * 0.5 - 200,
              left: isMobile || isTablet ? 0 : 40,
              right: isMobile || isTablet ? 0 : null,
              child: Padding(
                padding: EdgeInsets.only(
                  left: isMobile
                      ? 16
                      : isTablet
                      ? 24
                      : 0,
                  right: isMobile
                      ? 16
                      : isTablet
                      ? 24
                      : 0,
                  top: isMobile
                      ? 12
                      : isTablet
                      ? 14
                      : 0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Image - Only show for mobile and tablet
                    if (isMobile || isTablet)
                      Container(
                            width: isMobile
                                ? 75
                                : isTablet
                                ? 100
                                : 120,
                            height: isMobile
                                ? 75
                                : isTablet
                                ? 100
                                : 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppTheme.pureWhite.withOpacity(0.3),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.pureWhite.withOpacity(0.2),
                                  blurRadius: 20,
                                  spreadRadius: 3,
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/profile.png',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: AppTheme.pureWhite.withOpacity(0.1),
                                    child: Icon(
                                      Icons.person,
                                      size: isMobile
                                          ? 35
                                          : isTablet
                                          ? 50
                                          : 60,
                                      color: AppTheme.pureWhite.withOpacity(
                                        0.7,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                          .animate()
                          .fadeIn(duration: 800.ms)
                          .scale(begin: const Offset(0.5, 0.5))
                          .then()
                          .shimmer(
                            duration: 2.seconds,
                            color: AppTheme.pureWhite.withOpacity(0.3),
                          ),

                    if (isMobile || isTablet)
                      SizedBox(
                        height: isMobile
                            ? 7
                            : isTablet
                            ? 8
                            : 10,
                      ),

                    // Hello Text
                    Text(
                          'Hello, I\'m',
                          style: TextStyle(
                            fontSize: isMobile
                                ? 10
                                : isTablet
                                ? 12
                                : 20,
                            color: AppTheme.softWhite,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 400.ms)
                        .slideX(begin: -0.2, end: 0),

                    SizedBox(
                      height: isMobile
                          ? 2
                          : isTablet
                          ? 3
                          : 8,
                    ),

                    // Name
                    ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [
                              AppTheme.pureWhite,
                              AppTheme.pureWhite.withOpacity(0.8),
                              AppTheme.pureWhite,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: Text(
                            'YUGA T',
                            style: TextStyle(
                              fontSize: isMobile
                                  ? 20
                                  : isTablet
                                  ? 26
                                  : 42,
                              fontWeight: FontWeight.w900,
                              color: AppTheme.pureWhite,
                              letterSpacing: 1,
                              height: 1.0,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 800.ms, delay: 600.ms)
                        .slideY(begin: 0.3, end: 0)
                        .then()
                        .shimmer(
                          duration: 3.seconds,
                          color: AppTheme.pureWhite.withOpacity(0.5),
                        ),

                    SizedBox(
                      height: isMobile
                          ? 6
                          : isTablet
                          ? 8
                          : 14,
                    ),

                    // Badge
                    Row(
                      children: [
                        Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile
                                    ? 10
                                    : isTablet
                                    ? 12
                                    : 14,
                                vertical: isMobile
                                    ? 6
                                    : isTablet
                                    ? 7
                                    : 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: const Color.fromARGB(
                                  255,
                                  45,
                                  45,
                                  45,
                                ), // Light gray-ish background
                                border: Border.all(
                                  color: Colors
                                      .grey
                                      .shade500, // Medium gray border
                                  width: 1.4,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.code,
                                    color: const Color.fromARGB(
                                      255,
                                      235,
                                      235,
                                      235,
                                    ), // Solid white icon
                                    size: isMobile
                                        ? 12
                                        : isTablet
                                        ? 14
                                        : 16,
                                  ),

                                  SizedBox(width: isMobile ? 6 : 8),

                                  Text(
                                    'Cross-Platform Developer',
                                    style: TextStyle(
                                      fontSize: isMobile
                                          ? 10
                                          : isTablet
                                          ? 12
                                          : 14,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.6,
                                      color: const Color.fromARGB(
                                        255,
                                        235,
                                        235,
                                        235,
                                      ), // Solid white text
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .animate()
                            .fadeIn(duration: 600.ms, delay: 800.ms)
                            .scale(begin: const Offset(0.8, 0.8))
                            .then(delay: 1.seconds)
                            .shimmer(
                              duration: 2.seconds,
                              color: AppTheme.pureWhite.withOpacity(0.3),
                            ),
                        SizedBox(width: 10),
                        SocialIconButton(
                              icon: SvgPicture.asset(
                                "assets/download.svg",
                                width: 28,
                              ),
                              url:
                                  "https://drive.google.com/file/d/1Oz5hHELK67EPOx-ODZ8gnzSsr4cYxgxH/view?usp=sharing",
                              isMobile: isMobile,
                              isTablet: isTablet,
                            )
                            .animate()
                            .fadeIn(duration: 600.ms, delay: 1400.ms)
                            .slideY(begin: 0.2, end: 0),
                      ],
                    ),

                    SizedBox(
                      height: isMobile
                          ? 6
                          : isTablet
                          ? 8
                          : 10,
                    ),

                    // Description
                    Container(
                          constraints: BoxConstraints(
                            maxWidth: isMobile
                                ? screenWidth * 0.85
                                : isTablet
                                ? screenWidth * 0.7
                                : screenWidth * 0.5,
                          ),
                          child: RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: isMobile
                                    ? 8
                                    : isTablet
                                    ? 10
                                    : 16,
                                color: AppTheme.softWhite.withOpacity(0.85),
                                letterSpacing: 0.5,
                                height: 1.6,
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                TextSpan(
                                  text: "Crafting ",
                                  style: TextStyle(
                                    color: AppTheme.softWhite.withOpacity(0.85),
                                  ),
                                ),
                                TextSpan(
                                  text: "elegant cross-platform solutions",
                                  style: TextStyle(
                                    color: AppTheme.pureWhite,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: " with ",
                                  style: TextStyle(
                                    color: AppTheme.softWhite.withOpacity(0.85),
                                  ),
                                ),
                                TextSpan(
                                  text: "Flutter",
                                  style: TextStyle(
                                    color: AppTheme.pureWhite,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: " and ",
                                  style: TextStyle(
                                    color: AppTheme.softWhite.withOpacity(0.85),
                                  ),
                                ),
                                TextSpan(
                                  text: "modern web technologies",
                                  style: TextStyle(
                                    color: AppTheme.pureWhite,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: ".\nPassionate about ",
                                  style: TextStyle(
                                    color: AppTheme.softWhite.withOpacity(0.85),
                                  ),
                                ),
                                TextSpan(
                                  text: "clean code",
                                  style: TextStyle(
                                    color: AppTheme.pureWhite,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: ", ",
                                  style: TextStyle(
                                    color: AppTheme.softWhite.withOpacity(0.85),
                                  ),
                                ),
                                TextSpan(
                                  text: "pixel-perfect design",
                                  style: TextStyle(
                                    color: AppTheme.pureWhite,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: ", and turning ideas into ",
                                  style: TextStyle(
                                    color: AppTheme.softWhite.withOpacity(0.85),
                                  ),
                                ),
                                TextSpan(
                                  text: "impactful digital experiences",
                                  style: TextStyle(
                                    color: AppTheme.pureWhite,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: ".",
                                  style: TextStyle(
                                    color: AppTheme.softWhite.withOpacity(0.85),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 1000.ms)
                        .slideX(begin: -0.1, end: 0),

                    SizedBox(
                      height: isMobile
                          ? 8
                          : isTablet
                          ? 10
                          : 16,
                    ),

                    // Action Buttons
                    Wrap(
                          spacing: isMobile
                              ? 6
                              : isTablet
                              ? 8
                              : 10,
                          runSpacing: isMobile
                              ? 6
                              : isTablet
                              ? 8
                              : 10,
                          alignment: WrapAlignment.start,
                          children: [
                            _buildActionButton(
                              'View Projects',
                              Icons.rocket_launch_rounded,
                              true,
                              isMobile,
                              isTablet,
                              () => widget.onNavigate?.call(
                                2,
                              ), // <--- scroll to projects
                            ),
                            _buildActionButton(
                              'Contact Me',
                              Icons.email_rounded,
                              false,
                              isMobile,
                              isTablet,
                              () => widget.onNavigate?.call(6),
                            ),
                          ],
                        )
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 1200.ms)
                        .slideY(begin: 0.3, end: 0),

                    SizedBox(
                      height: isMobile
                          ? 8
                          : isTablet
                          ? 10
                          : 16,
                    ),

                    // Social Icons
                    Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SocialIconButton(
                              icon: SvgPicture.asset(
                                "assets/github.svg",
                                width: 28,
                              ),
                              url: "https://github.com/Yuga-04",
                              isMobile: isMobile,
                              isTablet: isTablet,
                            ),

                            SizedBox(
                              width: isMobile
                                  ? 10
                                  : isTablet
                                  ? 12
                                  : 14,
                            ),
                            SocialIconButton(
                              icon: SvgPicture.asset(
                                "assets/linkedin.svg",
                                width: 28,
                              ),
                              url:
                                  "https://www.linkedin.com/in/yugathiayagarajan/",
                              isMobile: isMobile,
                              isTablet: isTablet,
                            ),
                            SizedBox(
                              width: isMobile
                                  ? 10
                                  : isTablet
                                  ? 12
                                  : 14,
                            ),
                            SocialIconButton(
                              icon: SvgPicture.asset(
                                "assets/whatsapp.svg",
                                width: 28,
                              ),
                              url: "https://wa.me/918682812310",
                              isMobile: isMobile,
                              isTablet: isTablet,
                            ),
                          ],
                        )
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 1400.ms)
                        .slideY(begin: 0.2, end: 0),
                  ],
                ),
              ),
            ),

            // Fixed Floating Scroll Indicator at Bottom Center
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child:
                    Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Scroll to explore',
                              style: TextStyle(
                                color: AppTheme.softWhite.withOpacity(0.6),
                                fontSize: isMobile ? 10 : 12,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: AppTheme.softWhite.withOpacity(0.6),
                              size: isMobile ? 20 : 24,
                            ),
                          ],
                        )
                        .animate(onPlay: (controller) => controller.repeat())
                        .moveY(
                          begin: 0,
                          end: 10,
                          duration: 1.5.seconds,
                          curve: Curves.easeInOut,
                        )
                        .then()
                        .moveY(begin: 10, end: 0, duration: 1.5.seconds),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    bool isPrimary,
    bool isMobile,
    bool isTablet,
    VoidCallback onTap,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: isPrimary
            ? LinearGradient(
                colors: [
                  AppTheme.pureWhite,
                  AppTheme.pureWhite.withOpacity(0.9),
                ],
              )
            : null,
        border: Border.all(
          color: isPrimary
              ? Colors.transparent
              : AppTheme.pureWhite.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: isPrimary
            ? [
                BoxShadow(
                  color: AppTheme.pureWhite.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap, // <-- important
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile
                  ? 12
                  : isTablet
                  ? 14
                  : 18,
              vertical: isMobile
                  ? 8
                  : isTablet
                  ? 9
                  : 11,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: isPrimary ? AppTheme.primaryBlack : AppTheme.pureWhite,
                  size: isMobile
                      ? 14
                      : isTablet
                      ? 16
                      : 18,
                ),
                SizedBox(width: isMobile ? 5 : 6),
                Text(
                  label,
                  style: TextStyle(
                    color: isPrimary
                        ? AppTheme.primaryBlack
                        : AppTheme.pureWhite,
                    fontSize: isMobile
                        ? 10
                        : isTablet
                        ? 11
                        : 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
