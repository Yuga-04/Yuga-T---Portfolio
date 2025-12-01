import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:portfolio/theme/app_theme.dart';

class SocialIconButton extends StatefulWidget {
  final Widget icon;
  final String url;
  final bool isMobile;
  final bool isTablet;

  const SocialIconButton({
    super.key,
    required this.icon,
    required this.url,
    required this.isMobile,
    required this.isTablet,
  });

  @override
  State<SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<SocialIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fillAnimation;
  late Animation<double> _glowAnimation;

  bool isHovering = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Ink fill animation - flows from outside inward (0.0 = empty, 1.0 = full)
    _fillAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeInOut),
      ),
    );

    // Glow animation - appears after fill is complete and pulses
    _glowAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 0.0),
        weight: 80, // No glow during fill
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 10, // Glow appears
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.0,
          end: 0.8,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 5, // Pulse down
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.8,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 5, // Pulse up
      ),
    ]).animate(_controller);

    _controller.addListener(() => setState(() {}));
  }

  void _launch() async {
    launchUrlString(widget.url);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double padding = widget.isMobile
        ? 6
        : widget.isTablet
        ? 3
        : 6;

    // Icon color changes from white to black at 50% fill
    final iconColor = _fillAnimation.value < 0.5
        ? AppTheme.pureWhite.withOpacity(0.8)
        : Color.lerp(
            AppTheme.pureWhite.withOpacity(0.8),
            Colors.black,
            (_fillAnimation.value - 0.5) * 2,
          )!;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() => isHovering = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => isHovering = false);
        _controller.reverse();
      },
      child: GestureDetector(
        onTap: _launch,
        child: CustomPaint(
          painter: InkFillPainter(
            fillProgress: _fillAnimation.value,
            glowIntensity: _glowAnimation.value,
            isHovering: isHovering,
            borderColor: AppTheme.pureWhite.withOpacity(0.35),
            padding: padding,
          ),
          child: Container(
            padding: EdgeInsets.all(padding),
            child: Transform.scale(
              scale: 0.75, // Reduce icon size to 75%
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                child: widget.icon,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InkFillPainter extends CustomPainter {
  final double fillProgress; // 0.0 = empty, 1.0 = full
  final double glowIntensity;
  final bool isHovering;
  final Color borderColor;
  final double padding;

  InkFillPainter({
    required this.fillProgress,
    required this.glowIntensity,
    required this.isHovering,
    required this.borderColor,
    required this.padding,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;

    // Draw the white ink fill effect (flowing from outside inward)
    if (fillProgress > 0.0) {
      // Calculate the inner radius - starts at maxRadius and shrinks to 0
      final innerRadius = maxRadius * (1.0 - fillProgress);

      // Create a path that fills the ring from outside to inside
      final fillPath = Path()
        ..addOval(Rect.fromCircle(center: center, radius: maxRadius))
        ..addOval(Rect.fromCircle(center: center, radius: innerRadius))
        ..fillType = PathFillType.evenOdd;

      final fillPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;

      canvas.drawPath(fillPath, fillPaint);

      // Add soft edge for smoother fill appearance at the inner edge
      if (fillProgress < 1.0) {
        final edgePaint = Paint()
          ..color = Colors.white.withOpacity(0.5)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;

        canvas.drawCircle(center, innerRadius, edgePaint);
      }
    }

    // Draw border
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    canvas.drawCircle(center, maxRadius - 0.7, borderPaint);

    // Draw glow effect (only appears after fill is complete)
    if (isHovering && glowIntensity > 0 && fillProgress >= 0.8) {
      // Outer glow
      final outerGlowPaint = Paint()
        ..color = Colors.white.withOpacity(0.3 * glowIntensity)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4;

      canvas.drawCircle(center, maxRadius + 2, outerGlowPaint);

      // Inner glow
      final innerGlowPaint = Paint()
        ..color = Colors.white.withOpacity(0.5 * glowIntensity)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      canvas.drawCircle(center, maxRadius - 1, innerGlowPaint);

      // Bright edge highlight
      final highlightPaint = Paint()
        ..color = Colors.white.withOpacity(0.8 * glowIntensity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;

      canvas.drawCircle(center, maxRadius - 0.7, highlightPaint);
    }
  }

  @override
  bool shouldRepaint(InkFillPainter oldDelegate) {
    return oldDelegate.fillProgress != fillProgress ||
        oldDelegate.glowIntensity != glowIntensity ||
        oldDelegate.isHovering != isHovering;
  }
}
