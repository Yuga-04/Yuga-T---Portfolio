import 'package:flutter/material.dart';
import 'package:portfolio/widgets/animated_card.dart';
import 'package:portfolio/theme/app_theme.dart';

class CertificatesScreen extends StatelessWidget {
  const CertificatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    final certificates = [
      {
        'title': 'Google Flutter Certified',
        'issuer': 'Google',
        'date': '2024',
        'icon': Icons.verified_rounded,
      },
      {
        'title': 'AWS Solutions Architect',
        'issuer': 'Amazon Web Services',
        'date': '2023',
        'icon': Icons.cloud_done_rounded,
      },
      {
        'title': 'Meta Front-End Developer',
        'issuer': 'Meta',
        'date': '2023',
        'icon': Icons.code_rounded,
      },
      {
        'title': 'MongoDB Certified Developer',
        'issuer': 'MongoDB University',
        'date': '2022',
        'icon': Icons.storage_rounded,
      },
    ];

    return Container(
      width: screenWidth,
      constraints: BoxConstraints(minHeight: screenHeight),
      color: AppTheme.primaryBlack,
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

          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile
                  ? 1
                  : isTablet
                  ? 2
                  : 2,
              crossAxisSpacing: isMobile ? 16 : 24,
              mainAxisSpacing: isMobile ? 16 : 24,
              childAspectRatio: isMobile
                  ? 1.5
                  : isTablet
                  ? 1.8
                  : 2.5,
            ),
            itemCount: certificates.length,
            itemBuilder: (context, index) {
              final cert = certificates[index];
              return AnimatedCard(
                delay: index,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(isMobile ? 12 : 16),
                      decoration: BoxDecoration(
                        color: AppTheme.pureWhite,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        cert['icon'] as IconData,
                        color: AppTheme.primaryBlack,
                        size: isMobile ? 28 : 36,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            cert['title'] as String,
                            style: TextStyle(
                              fontSize: isMobile ? 16 : 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.pureWhite,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            cert['issuer'] as String,
                            style: TextStyle(
                              fontSize: isMobile ? 13 : 14,
                              color: AppTheme.softWhite,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            cert['date'] as String,
                            style: TextStyle(
                              fontSize: isMobile ? 12 : 13,
                              color: AppTheme.borderWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
