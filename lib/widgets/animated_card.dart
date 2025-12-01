import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';
import 'package:portfolio/theme/app_theme.dart';

class AnimatedCard extends StatefulWidget {
  final Widget child;
  final int delay;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const AnimatedCard({
    super.key,
    required this.child,
    this.delay = 0,
    this.height,
    this.padding,
  });

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
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
                    padding:
                        widget.padding ?? EdgeInsets.all(isMobile ? 16 : 0),
                    child: widget.child,
                  ),
                ),
              ),
            ),
          ),
        )
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
