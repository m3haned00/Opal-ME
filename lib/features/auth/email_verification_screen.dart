import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import '../home/main_layout.dart'; // استيراد الهيكل الرئيسي للربط

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppTheme.accentColor.withOpacity(0.1)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.mark_email_read_outlined,
                  color: AppTheme.accentColor, size: 48),
              const SizedBox(height: 24),
              Text('Verify Email',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(fontSize: 24)),
              const SizedBox(height: 8),
              const Text(
                'We sent a code to your email.\nPlease enter it below.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppTheme.textSecondary),
              ),
              const SizedBox(height: 32),
              // حقل إدخال الكود
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 6,
                style: const TextStyle(
                    fontSize: 24,
                    letterSpacing: 8,
                    color: AppTheme.accentColor),
                decoration: InputDecoration(
                  counterText: "",
                  hintText: '000000',
                  hintStyle:
                      TextStyle(color: AppTheme.textSecondary.withOpacity(0.3)),
                  filled: true,
                  fillColor: AppTheme.scaffoldBackground,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 24),
              // زر التأكيد (تم تحديثه للربط بالهيكل الرئيسي)
              ElevatedButton(
                onPressed: () {
                  // الانتقال إلى واجهة التطبيق الرئيسية بعد التأكيد
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MainLayout()),
                    (route) =>
                        false, // حذف كل الشاشات السابقة (Splash/Login) من الذاكرة
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentColor,
                  foregroundColor: AppTheme.scaffoldBackground,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Verify Now',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
              // خيار إعادة الإرسال
              TextButton(
                onPressed: () {},
                child: const Text('Resend Code',
                    style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.w400)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
