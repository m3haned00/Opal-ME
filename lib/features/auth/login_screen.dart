import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import 'sign_up_screen.dart'; // استيراد شاشة التسجيل للربط

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 400, // العرض المثالي للويب
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppTheme.accentColor.withOpacity(0.1)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.lock_outline,
                  color: AppTheme.accentColor, size: 48),
              const SizedBox(height: 24),
              Text('Welcome Back',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(fontSize: 24)),
              const SizedBox(height: 8),
              const Text('Login to your Opal ME account',
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
              // زر تسجيل الدخول
              ElevatedButton(
                onPressed: () {
                  // سنضيف منطق الدخول عند الربط مع Node.js
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentColor,
                  foregroundColor: AppTheme.scaffoldBackground,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Login',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
              // الجزء المحدث: زر الانتقال لشاشة إنشاء الحساب
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? ",
                      style: TextStyle(color: AppTheme.textSecondary)),
                  TextButton(
                    onPressed: () {
                      // الانتقال السلس لشاشة التسجيل
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()),
                      );
                    },
                    child: const Text('Create Account',
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
