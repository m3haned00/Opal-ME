import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import '../auth/login_screen.dart'; // استيراد شاشة الدخول للانتقال إليها

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // منطق الانتقال: الانتظار لمدة 3 ثوانٍ ثم الذهاب لشاشة تسجيل الدخول
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackground,
      body: Stack(
        children: [
          // الحفاظ على الجزء المركزي: اللوجو والاسم
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.chat_bubble_outline_rounded,
                  color: AppTheme.accentColor,
                  size: 45,
                ),
                const SizedBox(width: 15),
                Text(
                  'Opal ME',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        letterSpacing: 1.5,
                      ),
                ),
              ],
            ),
          ),
          // الحفاظ على الجزء السفلي: توقيع المطور بالإنجليزية
          const Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Text(
              'FIRST RELEASE - DEVELOPED BY MOHAND AL-SAUDI',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 10,
                letterSpacing: 2,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
