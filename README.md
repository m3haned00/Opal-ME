# 💎 Opal ME - Premium Project Management & Chat UI

Opal ME is a high-end, executive-style project management and communication platform built with **Flutter**. It features a modern **Glassmorphism UI**, organized **Clean Architecture**, and persistent local storage.

---

## ✨ Key Features
* **Modern Chat System:** Real-time UI for individual and group messaging.
* **Advanced UI/UX:** Glassmorphism design elements with smooth transitions using `AnimatedSwitcher`.
* **Data Persistence:** Integrated with `Shared Preferences` to save user profiles and settings locally (Offline-first approach).
* **Clean Architecture:** Separated layers (UI, Services, Core) for high maintainability and scalability.
* **Smart Navigation:** Sidebar-based navigation optimized for productivity.

## 🛠 Tech Stack
* **Frontend:** Flutter & Dart
* **State Management:** Local State (StatefulWidgets) with optimized build methods.
* **Local Storage:** `shared_preferences` for user data persistence.
* **Design System:** Custom Dark Theme with `Google Fonts` (Inter/Poppins).

## 📂 Project Structure
```text
lib/
├── core/
│   ├── theme/          # Custom App Themes (Colors, Text Styles)
│   └── services/       # Local Storage & Business Logic
├── features/
│   └── layout/         # Main screens and navigation logic
└── main.dart           # App Entry point & Initialization