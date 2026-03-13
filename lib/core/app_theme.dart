import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ألوان براند Opal ME المستوحاة من صورك
  static const Color scaffoldBackground =
      Color(0xFF0A0E12); // الخلفية الداكنة العميقة
  static const Color surfaceColor = Color(0xFF161B22); // لون الحاويات والقوائم
  static const Color accentColor = Color(0xFF5EEAD4); // لون التوهج (Opal Teal)
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF8B949E);

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: scaffoldBackground,
    primaryColor: accentColor,
    // استخدام خط Google Fonts للحصول على مظهر احترافي عالمي
    textTheme: GoogleFonts.interTextTheme(const TextTheme(
      displayLarge: TextStyle(
          fontSize: 32, fontWeight: FontWeight.bold, color: textPrimary),
      bodyLarge: TextStyle(fontSize: 16, color: textPrimary),
      bodyMedium: TextStyle(fontSize: 14, color: textSecondary),
    )),
    colorScheme: const ColorScheme.dark(
      primary: accentColor,
      surface: surfaceColor,
      onSurface: textPrimary,
      secondary: accentColor,
    ),
  );
}
