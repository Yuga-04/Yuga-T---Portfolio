import 'package:flutter/material.dart';
import 'package:portfolio/widgets/animated_card.dart';
import 'package:portfolio/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    return Container(
      width: screenWidth,
      constraints: BoxConstraints(minHeight: screenHeight),
      color: AppTheme.deepBlack,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile
            ? 20
            : isTablet
            ? 40
            : 80,
        vertical: isMobile ? 60 : 40,
      ),
      child: Column(
        children: [
             Text(
            'Featured Project',
            style: TextStyle(
              fontSize: isMobile ? 28 : 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Some of my most recent project works',
            style: TextStyle(
              fontSize: isMobile ? 13 : 15,
              color: Colors.white70,
            ),
          ),
            
          SizedBox(height: isMobile ? 40 : 60),

          if (isMobile || isTablet)
            _buildMobileLayout(isMobile)
          else
            _buildDesktopLayout(),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(bool isMobile) {
    return Column(
      children: [
        AnimatedCard(
          child: Column(
            children: [
              _buildProfileImage(isMobile),
              SizedBox(height: 24),
              _buildAboutText(isMobile),
            ],
          ),
        ),
        SizedBox(height: 24),
        _buildStatsGrid(isMobile),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: AnimatedCard(child: _buildAboutText(false)),
            ),
            SizedBox(width: 24),
            Expanded(
              child: AnimatedCard(delay: 1, child: _buildProfileImage(false)),
            ),
          ],
        ),
        SizedBox(height: 32),
        _buildStatsGrid(false),
      ],
    );
  }

  Widget _buildProfileImage(bool isMobile) {
    return Container(
          width: isMobile ? 150 : 200,
          height: isMobile ? 150 : 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppTheme.pureWhite, width: 3),
            color: AppTheme.borderWhite,
          ),
          child: Icon(
            Icons.person_rounded,
            size: isMobile ? 80 : 100,
            color: AppTheme.pureWhite,
          ),
        )
        .animate()
        .scale(begin: Offset(0.8, 0.8), end: Offset(1, 1), duration: 600.ms)
        .fadeIn();
  }

  Widget _buildAboutText(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello There!',
          style: TextStyle(
            fontSize: isMobile ? 24 : 32,
            fontWeight: FontWeight.bold,
            color: AppTheme.pureWhite,
            letterSpacing: 1,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'I\'m a passionate full-stack developer with expertise in building beautiful and functional applications. With years of experience in modern web and mobile technologies, I create solutions that make a difference.',
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            color: AppTheme.softWhite,
            height: 1.8,
            letterSpacing: 0.3,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'I specialize in Flutter, React, and Node.js, and I\'m always eager to learn new technologies and take on challenging projects.',
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            color: AppTheme.softWhite,
            height: 1.8,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsGrid(bool isMobile) {
    final stats = [
      {'label': 'Projects', 'value': '50+'},
      {'label': 'Experience', 'value': '5 Years'},
      {'label': 'Clients', 'value': '30+'},
      {'label': 'Awards', 'value': '10+'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 2 : 4,
        crossAxisSpacing: isMobile ? 16 : 24,
        mainAxisSpacing: isMobile ? 16 : 24,
        childAspectRatio: isMobile ? 1.5 : 1.8,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        final stat = stats[index];
        return AnimatedCard(
          delay: index + 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                stat['value']!,
                style: TextStyle(
                  fontSize: isMobile ? 28 : 36,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.pureWhite,
                ),
              ),
              SizedBox(height: 8),
              Text(
                stat['label']!,
                style: TextStyle(
                  fontSize: isMobile ? 12 : 14,
                  color: AppTheme.softWhite,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
