import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:portfolio/theme/app_theme.dart';

class NavBar extends StatefulWidget {
  final Function(int) onTap;
  final int selectedIndex;

  const NavBar({super.key, required this.onTap, required this.selectedIndex});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with SingleTickerProviderStateMixin {
  int? _hoveredIndex;
  String _displayedText = '';
  final String _fullText = 'Portfolio';
  int _currentIndex = 0;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    // Start the typewriter effect only to keep the state available for desktop
    _startTypewriterEffect();
  }

  void _startTypewriterEffect() {
    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted) {
        setState(() {
          if (_currentIndex < _fullText.length) {
            _displayedText = _fullText.substring(0, _currentIndex + 1);
            _currentIndex++;
            _startTypewriterEffect();
          } else {
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) {
                setState(() {
                  _currentIndex = 0;
                  _displayedText = '';
                });
                _startTypewriterEffect();
              }
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 640;
    final isTablet = screenWidth >= 640 && screenWidth < 1024;
    final isLargeDesktop = screenWidth >= 1440;

    // Responsive sizing
    final navHeight = isMobile ? 64.0 : (isTablet ? 68.0 : 60.0);

    return Container(
      height: navHeight,
      decoration: BoxDecoration(
        color: AppTheme.richBlack.withOpacity(0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 16,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: AppTheme.pureWhite.withOpacity(0.05),
            blurRadius: 1,
            spreadRadius: 0,
            offset: const Offset(0, -1),
          ),
        ],
        border: Border(
          bottom: BorderSide(
            color: AppTheme.pureWhite.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: isMobile
          ? _buildMobileNav(context)
          : isTablet
          ? _buildTabletNav(context)
          : _buildDesktopNav(context, isTablet, isLargeDesktop),
    );
  }

  Widget _buildMobileNav(BuildContext context) {
    final items = [
      {'index': 0, 'label': 'Home', 'icon': Icons.home_rounded},
      {'index': 1, 'label': 'Skills', 'icon': Icons.code_rounded},
      {'index': 2, 'label': 'Projects', 'icon': Icons.work_rounded},
      {'index': 3, 'label': 'About', 'icon': Icons.person_rounded},

      {'index': 6, 'label': 'Contact', 'icon': Icons.contact_mail_rounded},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _buildStaticLogo(16.0, 1.2, 12.0),
          const Spacer(),
          // Navigation items
          Row(
            mainAxisSize: MainAxisSize.min,
            children: items.map((item) {
              return _buildMobileNavItem(
                item['index'] as int,
                item['label'] as String,
                item['icon'] as IconData,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletNav(BuildContext context) {
    final items = [
      {'index': 0, 'label': 'Home', 'icon': Icons.home_rounded},
      {'index': 1, 'label': 'Skills', 'icon': Icons.code_rounded},
      {'index': 2, 'label': 'Projects', 'icon': Icons.work_rounded},
      {'index': 3, 'label': 'About', 'icon': Icons.person_rounded},
      {'index': 6, 'label': 'Contact', 'icon': Icons.contact_mail_rounded},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: [
          _buildStaticLogo(17.0, 1.3, 14.0),
          const Spacer(),
          // Navigation items
          Row(
            mainAxisSize: MainAxisSize.min,
            children: items.map((item) {
              return _buildTabletNavItem(
                item['index'] as int,
                item['label'] as String,
                item['icon'] as IconData,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Static logo for Mobile and Tablet views (No animation)
  Widget _buildStaticLogo(
    double fontSize,
    double letterSpacing,
    double horizontalPadding,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 6),
      child: Text(
        _fullText,
        style: TextStyle(
          color: AppTheme.pureWhite,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          letterSpacing: letterSpacing,
        ),
      ),
    );
  }

  Widget _buildMobileNavItem(int index, String label, IconData icon) {
    final isSelected = widget.selectedIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => widget.onTap(index),
          borderRadius: BorderRadius.circular(10),
          splashColor: AppTheme.pureWhite.withOpacity(0.2),
          highlightColor: Colors.transparent,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            // FIX: Reduced vertical padding to ensure fit
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppTheme.pureWhite.withOpacity(0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: isSelected
                  ? Border.all(
                      color: AppTheme.pureWhite.withOpacity(0.3),
                      width: 1,
                    )
                  : null,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // FIX: Reduced Icon size slightly to help fit
                Icon(icon, color: AppTheme.pureWhite, size: 18),
                if (isSelected) ...[
                  // FIX: Reduced SizedBox height to 1
                  const SizedBox(height: 1),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: AppTheme.pureWhite,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabletNavItem(int index, String label, IconData icon) {
    final isSelected = widget.selectedIndex == index;
    final isHovered = _hoveredIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = null),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => widget.onTap(index),
            borderRadius: BorderRadius.circular(10),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutCubic,
              // FIX: Reduced vertical padding to 2.0
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.pureWhite.withOpacity(0.15)
                    : (isHovered
                          ? AppTheme.pureWhite.withOpacity(0.08)
                          : Colors.transparent),
                borderRadius: BorderRadius.circular(10),
                border: (isSelected || isHovered)
                    ? Border.all(
                        color: isSelected
                            ? AppTheme.pureWhite.withOpacity(0.3)
                            : AppTheme.pureWhite.withOpacity(0.15),
                        width: 1,
                      )
                    : null,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // FIX: Reduced Icon size to 18
                  Icon(icon, color: AppTheme.pureWhite, size: 18),
                  // FIX: Reduced SizedBox height to 1
                  const SizedBox(height: 1),
                  Text(
                    label,
                    style: TextStyle(
                      color: AppTheme.pureWhite,
                      fontSize: 11,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                      letterSpacing: 0.3,
                    ),
                  ),
                  if (isSelected) ...[
                    const SizedBox(height: 2),
                    Container(
                      height: 2,
                      width: 20,
                      decoration: BoxDecoration(
                        color: AppTheme.pureWhite,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopNav(
    BuildContext context,
    bool isTablet,
    bool isLargeDesktop,
  ) {
    final items = [
      {'index': 0, 'label': 'Home', 'icon': Icons.home_rounded},
      {'index': 1, 'label': 'Skills', 'icon': Icons.code_rounded},
      {'index': 2, 'label': 'Projects', 'icon': Icons.work_rounded},
      {'index': 3, 'label': 'About', 'icon': Icons.person_rounded},
      {'index': 6, 'label': 'Contact', 'icon': Icons.contact_mail_rounded},
    ];

    final horizontalPadding = isTablet ? 24.0 : (isLargeDesktop ? 48.0 : 32.0);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 8),
      child: Row(
        children: [
          _buildLogo(isTablet, isLargeDesktop), // Animated logo for desktop
          const Spacer(flex: 1),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: items.map((item) {
              return _buildNavButton(
                item['index'] as int,
                item['label'] as String,
                item['icon'] as IconData,
                isTablet,
                isLargeDesktop,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Animated logo for Desktop view
  Widget _buildLogo(bool isTablet, bool isLargeDesktop) {
    final fontSize = isTablet ? 16.0 : (isLargeDesktop ? 20.0 : 18.0);
    final logoWidth = isTablet ? 100.0 : (isLargeDesktop ? 130.0 : 120.0);
    final letterSpacing = isLargeDesktop ? 1.5 : 1.3;

    return SizedBox(
      width: logoWidth,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 12 : 16,
          vertical: 6,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _displayedText,
              style: TextStyle(
                color: AppTheme.pureWhite,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                letterSpacing: letterSpacing,
              ),
            ),
            if (_displayedText.length < _fullText.length)
              AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _pulseController.value > 0.5 ? 1.0 : 0.0,
                    child: Container(
                      width: 2,
                      height: fontSize,
                      margin: const EdgeInsets.only(left: 2),
                      color: AppTheme.pureWhite,
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(
    int index,
    String label,
    IconData icon,
    bool isTablet,
    bool isLargeDesktop,
  ) {
    final isSelected = widget.selectedIndex == index;
    final fontSize = isTablet ? 13.0 : (isLargeDesktop ? 15.0 : 14.0);
    final horizontalPadding = isTablet ? 8.0 : (isLargeDesktop ? 12.0 : 10.0);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isTablet ? 1 : 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => widget.onTap(index),
          borderRadius: BorderRadius.circular(8),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 8,
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    color: AppTheme.pureWhite,
                    fontSize: fontSize,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
                height: 2,
                width: isSelected ? horizontalPadding * 2 + 20 : 0,
                decoration: BoxDecoration(
                  color: AppTheme.pureWhite,
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppTheme.pureWhite.withOpacity(0.5),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ]
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
