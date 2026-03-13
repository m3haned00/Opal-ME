import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'features/splash/splash_screen.dart';

void main() {
  // التأكد من تهيئة جميع خدمات فلاتر قبل التشغيل
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const OpalME());
}

class OpalME extends StatelessWidget {
  const OpalME({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Opal ME',
      debugShowCheckedModeBanner: false,
      // استدعاء الثيم الاحترافي الذي أنشأناه في الخطوة 2.1
      theme: AppTheme.darkTheme,
      // تحديد شاشة البداية لتكون أول ما يراه المستخدم
      home: const SplashScreen(),
    );
  }
}
