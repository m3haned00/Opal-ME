import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import 'email_verification_screen.dart'; // استيراد شاشة التأكيد للربط

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
              const Icon(Icons.person_add_outlined,
                  color: AppTheme.accentColor, size: 48),
              const SizedBox(height: 24),
              Text('Create Account',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(fontSize: 24)),
              const SizedBox(height: 8),
              const Text('Join Opal ME to start chatting',
                  style: TextStyle(color: AppTheme.textSecondary)),
              const SizedBox(height: 32),
              // حقل البريد الإلكتروني
              TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: AppTheme.scaffoldBackground,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                  prefixIcon: const Icon(Icons.email_outlined,
                      color: AppTheme.textSecondary),
                ),
              ),
              const SizedBox(height: 16),
              // حقل كلمة المرور
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: AppTheme.scaffoldBackground,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                  prefixIcon: const Icon(Icons.key_outlined,
                      color: AppTheme.textSecondary),
                ),
              ),
              const SizedBox(height: 24),
              // زر إنشاء الحساب (تم تحديثه للربط)
              ElevatedButton(
                onPressed: () {
                  // الانتقال لشاشة تأكيد الإيميل
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EmailVerificationScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentColor,
                  foregroundColor: AppTheme.scaffoldBackground,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Sign Up',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
              // العودة لتسجيل الدخول
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? ",
                      style: TextStyle(color: AppTheme.textSecondary)),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Login',
                        style: TextStyle(
                            color: AppTheme.accentColor,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
