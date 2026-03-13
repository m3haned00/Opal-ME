import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import '../../core/services/storage_service.dart'; // تأكد من المسار الصحيح للسيرفس

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int selectedIndex = 0;
  final TextEditingController _messageController = TextEditingController();

  // --- [تحسين خطوة 11]: البيانات الآن يتم تحميلها من التخزين المحلي ---
  String userName = "Loading...";
  String userEmail = "Loading...";
  bool isTyping = false;

  final List<Map<String, dynamic>> _messages = [
    {
      "type": "text",
      "content": "Hello! How is the project going?",
      "isMe": false
    },
    {"type": "file", "content": "Project_UI_Design.pdf", "isMe": true},
    {
      "type": "text",
      "content": "The Opal ME design looks premium.",
      "isMe": false
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadInitialData(); // استدعاء البيانات عند الفتح
  }

  /// جلب البيانات المحفوظة من الـ Shared Preferences
  Future<void> _loadInitialData() async {
    final name = await StorageService.getUserName();
    final email = await StorageService.getUserEmail();
    setState(() {
      userName = name;
      userEmail = email;
    });
  }

  /// دالة تحديث البروفايل مع الحفظ الدائم
  void _handleProfileUpdate(String newName, String newEmail) async {
    await StorageService.saveUserData(newName, newEmail); // حفظ في الذاكرة
    setState(() {
      userName = newName;
      userEmail = newEmail;
      selectedIndex = 3; // الرجوع للإعدادات
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Profile Updated & Saved Locally!"),
          backgroundColor: AppTheme.accentColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add({
          "type": "text",
          "content": _messageController.text.trim(),
          "isMe": true,
        });
        _messageController.clear();
      });
    }
  }

  void _showAttachmentMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading:
                  const Icon(Icons.image_outlined, color: AppTheme.accentColor),
              title: const Text('Send Image'),
              onTap: () {
                _addAttachmentMessage("image", "Image_Selected_001.png");
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.insert_drive_file_outlined,
                  color: AppTheme.accentColor),
              title: const Text('Send Document'),
              onTap: () {
                _addAttachmentMessage("file", "Document_001.pdf");
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addAttachmentMessage(String type, String content) {
    setState(() {
      _messages.add({"type": type, "content": content, "isMe": true});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackground,
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _buildBodyContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyContent() {
    switch (selectedIndex) {
      case 0:
        return _buildChatSystem();
      case 1:
        return _buildGroupsPage();
      case 2:
        return _buildNotificationsPage();
      case 3:
        return _buildSettingsPage();
      case 4:
        return _buildEditProfilePage();
      case 5:
        return _buildSecurityPage();
      default:
        return _buildChatSystem();
    }
  }

  Widget _buildGroupsPage() {
    return Container(
      key: const ValueKey(1),
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Groups',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) => _buildSettingsItem(
                  Icons.group_work,
                  'Opal Dev Team ${index + 1}',
                  'Active project group'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsPage() {
    return Container(
      key: const ValueKey(2),
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Notifications',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => _buildSettingsItem(
                  Icons.notification_important,
                  'New Alert',
                  'Someone mentioned you in a group'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditProfilePage() {
    final nameCtrl = TextEditingController(text: userName);
    final emailCtrl = TextEditingController(text: userEmail);

    return Container(
      key: const ValueKey(4),
      padding: const EdgeInsets.all(60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              icon:
                  const Icon(Icons.arrow_back_ios, color: AppTheme.accentColor),
              onPressed: () => setState(() => selectedIndex = 3)),
          const SizedBox(height: 20),
          const Text('Edit Profile',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 40),
          _buildCustomTextField("Full Name", nameCtrl),
          const SizedBox(height: 20),
          _buildCustomTextField("Email", emailCtrl),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () =>
                _handleProfileUpdate(nameCtrl.text, emailCtrl.text),
            style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentColor,
                minimumSize: const Size(200, 50)),
            child: const Text('Update & Save',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityPage() {
    return Container(
      key: const ValueKey(5),
      padding: const EdgeInsets.all(60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              icon:
                  const Icon(Icons.arrow_back_ios, color: AppTheme.accentColor),
              onPressed: () => setState(() => selectedIndex = 3)),
          const SizedBox(height: 20),
          const Text('Security Settings',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 40),
          _buildSettingsItem(
              Icons.password, "Change Password", "Last changed 3 months ago"),
          _buildSettingsItem(
              Icons.phonelink_lock, "Two-Factor Auth", "Currently disabled"),
        ],
      ),
    );
  }

  Widget _buildCustomTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style:
                const TextStyle(color: AppTheme.textSecondary, fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppTheme.surfaceColor,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppTheme.accentColor, width: 0.5)),
          ),
        ),
      ],
    );
  }

  Widget _buildChatSystem() {
    return Row(
      key: const ValueKey(0),
      children: [
        Container(
          width: 350,
          decoration: BoxDecoration(
              border: Border(
                  right: BorderSide(color: Colors.white.withOpacity(0.05)))),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Messages',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    _buildIconButton(Icons.add, isAccent: true),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 8,
                  itemBuilder: (context, index) => _buildChatTile(
                    name: "User ${index + 1}",
                    message: index == 0
                        ? "Check the file please"
                        : "Available for call?",
                    time: "${index + 2}m",
                    isActive: index == 0,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              _buildChatHeader(),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(24),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final msg = _messages[index];
                    return _buildMessageBubble(msg['content'], msg['isMe'],
                        type: msg['type']);
                  },
                ),
              ),
              _buildMessageInput(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsPage() {
    return Container(
      key: const ValueKey(3),
      padding: const EdgeInsets.all(60),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Settings',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(24),
                border:
                    Border.all(color: AppTheme.accentColor.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                      radius: 45,
                      backgroundColor: AppTheme.accentColor,
                      child: Icon(Icons.person, size: 45, color: Colors.black)),
                  const SizedBox(width: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userName,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(userEmail,
                          style:
                              const TextStyle(color: AppTheme.textSecondary)),
                    ],
                  ),
                  const Spacer(),
                  OutlinedButton(
                    onPressed: () => setState(() => selectedIndex = 4),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.accentColor,
                      side: const BorderSide(color: AppTheme.accentColor),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Edit Profile'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            _buildSettingsItem(Icons.notifications_outlined, 'Notifications',
                'Manage sound and alerts',
                onTap: () => setState(() => selectedIndex = 2)),
            _buildSettingsItem(Icons.lock_outline_rounded, 'Security',
                'Password and two-factor auth',
                onTap: () => setState(() => selectedIndex = 5)),
            _buildSettingsItem(
                Icons.language_rounded, 'Language', 'English (United States)'),
            _buildSettingsItem(Icons.palette_outlined, 'Appearance',
                'Custom themes and dark mode'),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 80,
      color: AppTheme.surfaceColor,
      child: Column(
        children: [
          const SizedBox(height: 30),
          const Icon(Icons.blur_on_rounded,
              color: AppTheme.accentColor, size: 40),
          const SizedBox(height: 50),
          _buildSidebarItem(Icons.chat_bubble_outline_rounded, 0),
          _buildSidebarItem(Icons.people_outline_rounded, 1),
          _buildSidebarItem(Icons.notifications_none_rounded, 2),
          const Spacer(),
          _buildSidebarItem(Icons.settings_outlined, 3),
          const SizedBox(height: 20),
          const CircleAvatar(
              radius: 18,
              backgroundColor: AppTheme.accentColor,
              child: Icon(Icons.person, size: 18, color: Colors.black)),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, int index) {
    bool isActive =
        selectedIndex == index || (index == 3 && selectedIndex >= 3);
    return GestureDetector(
      onTap: () => setState(() => selectedIndex = index),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isActive)
              Positioned(
                left: 0,
                child: Container(
                    width: 4,
                    height: 24,
                    decoration: const BoxDecoration(
                        color: AppTheme.accentColor,
                        borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(4)))),
              ),
            Icon(icon,
                color: isActive ? AppTheme.accentColor : AppTheme.textSecondary,
                size: 28),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, String desc,
      {VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Icon(icon, color: AppTheme.accentColor),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(desc,
            style:
                const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
        trailing:
            const Icon(Icons.chevron_right, color: AppTheme.textSecondary),
        onTap: onTap ?? () {},
      ),
    );
  }

  Widget _buildMessageBubble(String content, bool isMe,
      {String type = "text"}) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: const BoxConstraints(maxWidth: 450),
        decoration: BoxDecoration(
          color: isMe ? AppTheme.accentColor : AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(16).copyWith(
            bottomRight:
                isMe ? const Radius.circular(0) : const Radius.circular(16),
            bottomLeft:
                isMe ? const Radius.circular(16) : const Radius.circular(0),
          ),
        ),
        child: type == "image"
            ? Column(children: [
                const Icon(Icons.image, size: 50, color: Colors.black54),
                Text(content)
              ])
            : type == "file"
                ? Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.insert_drive_file,
                        color: isMe ? Colors.black54 : AppTheme.accentColor),
                    const SizedBox(width: 8),
                    Text(content,
                        style: TextStyle(
                            color: isMe ? Colors.black : Colors.white,
                            fontWeight: FontWeight.bold)),
                  ])
                : Text(content,
                    style:
                        TextStyle(color: isMe ? Colors.black : Colors.white)),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          if (isTyping)
            const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Opal is typing...",
                        style: TextStyle(
                            color: AppTheme.accentColor, fontSize: 10)))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.attach_file_rounded,
                      color: Colors.white.withOpacity(0.4)),
                  onPressed: _showAttachmentMenu,
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    onSubmitted: (_) => _sendMessage(),
                    onChanged: (v) => setState(() => isTyping = v.isNotEmpty),
                    decoration: const InputDecoration(
                        hintText: 'Message Opal...', border: InputBorder.none),
                  ),
                ),
                const Icon(Icons.mic_none_rounded, color: AppTheme.accentColor),
                const SizedBox(width: 12),
                IconButton(
                    icon: const Icon(Icons.send_rounded,
                        color: AppTheme.accentColor),
                    onPressed: _sendMessage),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.white.withOpacity(0.05)))),
      child: Row(
        children: [
          const CircleAvatar(
              backgroundColor: AppTheme.accentColor,
              radius: 18,
              child: Icon(Icons.person, size: 18, color: Colors.black)),
          const SizedBox(width: 12),
          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Opal Assistant',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Online',
                style: TextStyle(color: AppTheme.accentColor, fontSize: 11)),
          ]),
          const Spacer(),
          _buildIconButton(Icons.videocam_outlined),
          const SizedBox(width: 10),
          _buildIconButton(Icons.info_outline),
        ],
      ),
    );
  }

  Widget _buildChatTile(
      {required String name,
      required String message,
      required String time,
      bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: isActive
              ? AppTheme.accentColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          CircleAvatar(
              radius: 22,
              backgroundColor: AppTheme.surfaceColor,
              child: Text(name[0],
                  style: const TextStyle(color: AppTheme.accentColor))),
          const SizedBox(width: 12),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(name,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(time,
                          style: const TextStyle(
                              color: AppTheme.textSecondary, fontSize: 10))
                    ]),
                Text(message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: AppTheme.textSecondary, fontSize: 12)),
              ])),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, {bool isAccent = false}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: isAccent
              ? AppTheme.accentColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10)),
      child: Icon(icon,
          color:
              isAccent ? AppTheme.accentColor : Colors.white.withOpacity(0.6),
          size: 20),
    );
  }
}
