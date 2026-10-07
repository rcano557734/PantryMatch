import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    var headingStyle = const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 17,
      color: Color(0xFF3A3226),
    );

    var smallStyle = const TextStyle(fontSize: 13, color: Color(0xFF8A7F6B));

    return Scaffold(
      backgroundColor: const Color(0xFFFBF6EC),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),

            Text('Settings', style: headingStyle),

            const SizedBox(height: 2),

            Text('Manage your app preferences', style: smallStyle),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  _settingItem(Icons.notifications_outlined, 'Notifications'),

                  _settingItem(Icons.lock_outline, 'Privacy'),

                  _settingItem(Icons.info_outline, 'About PantryMatch'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingItem(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF8A7F6B)),

          const SizedBox(width: 12),

          Text(
            title,
            style: const TextStyle(fontSize: 13, color: Color(0xFF3A3226)),
          ),

          const Spacer(),

          const Icon(Icons.chevron_right, size: 18, color: Color(0xFFC9BFA8)),
        ],
      ),
    );
  }
}
