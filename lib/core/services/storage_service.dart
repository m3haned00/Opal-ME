import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  // مفاتيح تخزين البيانات (Keys)
  static const String _keyUserName = 'user_name';
  static const String _keyUserEmail = 'user_email';

  /// حفظ بيانات المستخدم
  static Future<void> saveUserData(String name, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserName, name);
    await prefs.setString(_keyUserEmail, email);
    print("Data Saved Locally: $name, $email");
  }

  /// جلب اسم المستخدم
  static Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    // لو مفيش اسم متخزن هيرجع الاسم الافتراضي بتاعك
    return prefs.getString(_keyUserName) ?? "Mohaned Elsoudy";
  }

  /// جلب إيميل المستخدم
  static Future<String> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserEmail) ?? "mohand.dev@opalme.com";
  }

  /// دالة لمسح البيانات (مثلاً عند تسجيل الخروج)
  static Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
