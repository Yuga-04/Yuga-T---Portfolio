// lib/main.dart
import 'package:flutter/material.dart';
import 'package:portfolio/theme/app_theme.dart';
import 'package:portfolio/widgets/navbar.dart';

import 'screens/home_screen.dart';
import 'screens/skills_screen.dart';
import 'screens/projects_screen.dart';
import 'screens/about_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/certificates_screen.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Yuga T - Portfolio ",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scrollController = ScrollController();
  int selectedIndex = 0;

  // Keys for each section to get their positions
  final List<GlobalKey> _sectionKeys = List.generate(7, (index) => GlobalKey());

  bool _isScrollingProgrammatically = false;
  final GlobalKey _navBarKey = GlobalKey();

  // NEW: whether page (outer) scrolling is enabled. When false, outer scrolling is disabled.
  bool _outerScrollEnabled = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  double _getNavBarHeight() {
    if (_navBarKey.currentContext != null) {
      final RenderBox? box =
          _navBarKey.currentContext!.findRenderObject() as RenderBox?;
      if (box != null) {
        return box.size.height;
      }
    }
    // Fallback calculation
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    return (isMobile ? 60.0 : 70.0) + (isMobile ? 24.0 : 40.0);
  }

  void _onScroll() {
    if (_isScrollingProgrammatically) return;

    final scrollOffset = _scrollController.offset;
    final navBarHeight = _getNavBarHeight();

    for (int i = _sectionKeys.length - 1; i >= 0; i--) {
      final key = _sectionKeys[i];
      final context = key.currentContext;

      if (context != null) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          final position = box.localToGlobal(Offset.zero);
          final sectionTop = position.dy + scrollOffset;

          // Check if this section is currently visible at the top
          // Add small buffer (100px) to make transitions smoother
          if (scrollOffset >= sectionTop - navBarHeight - 100) {
            if (selectedIndex != i) {
              setState(() => selectedIndex = i);
            }
            break;
          }
        }
      }
    }
  }

  void scrollTo(int index) {
    if (index < 0 || index >= _sectionKeys.length) return;

    final key = _sectionKeys[index];
    final context = key.currentContext;

    if (context != null) {
      _isScrollingProgrammatically = true;

      setState(() => selectedIndex = index);

      // Wait for UI to update and navbar height to be calculated
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null && mounted) {
          final navBarHeight = _getNavBarHeight();
          final position = box.localToGlobal(Offset.zero);

          // Calculate target scroll position
          // Add current scroll offset to the position.dy to get absolute position
          final targetScroll =
              _scrollController.offset + position.dy - navBarHeight;

          _scrollController
              .animateTo(
                targetScroll.clamp(
                  0.0,
                  _scrollController.position.maxScrollExtent,
                ),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOutCubic,
              )
              .then((_) {
                if (mounted) {
                  Future.delayed(const Duration(milliseconds: 100), () {
                    if (mounted) {
                      _isScrollingProgrammatically = false;
                    }
                  });
                }
              });
        } else {
          _isScrollingProgrammatically = false;
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // NEW: callback passed into AboutScreen so inner cards can notify when hovered
  void _onInnerHoverChanged(bool hovering) {
    if (mounted) {
      setState(() {
        _outerScrollEnabled = !hovering;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBlack,
      body: Column(
        children: [
          NavBar(
            key: _navBarKey,
            onTap: scrollTo,
            selectedIndex: selectedIndex,
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: _outerScrollEnabled
                  ? const ClampingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildSection(0, HomeScreen(onNavigate: scrollTo)),
                  _buildSection(1, const SkillsScreen()),
                  _buildSection(2, const ProjectsScreen()),
                  // Pass the hover callback to AboutScreen
                  _buildSection(
                    3,
                    AboutScreen(onInnerHoverChanged: _onInnerHoverChanged),
                  ),
                  _buildSection(4, const CertificatesScreen()),
                  _buildSection(6, const ContactScreen()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(int index, Widget child) {
    return Container(
      key: _sectionKeys[index],
      width: double.infinity,
      child: child,
    );
  }
}
