import 'package:flutter/material.dart';

import 'search_history_view.dart';
import 'settings_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    var headingStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Color(0xFF3A3226),
    );

    var smallStyle = const TextStyle(fontSize: 12, color: Color(0xFF8A7F6B));

    return Scaffold(
      backgroundColor: const Color(0xFFFBF6EC),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 25),

            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: Color(0xFFDCEBCB),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                size: 28,
                color: Color(0xFF3B6D11),
              ),
            ),

            const SizedBox(height: 12),

            Text('Ralfh', style: headingStyle),

            const SizedBox(height: 3),

            Text('ralfh@email.com', style: smallStyle),

            const SizedBox(height: 22),

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  _profileItem(
                    context,
                    Icons.favorite_border,
                    'My favorites',
                    const Color(0xFFD85A30),
                  ),

                  _profileItem(
                    context,
                    Icons.inventory_2_outlined,
                    'My ingredients',
                    const Color(0xFF639922),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SearchHistoryView(title: 'Search History'),
                        ),
                      );
                    },
                    child: _profileItem(
                      context,
                      Icons.history,
                      'Search history',
                      const Color(0xFFE8813A),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsView(title: 'Settings'),
                        ),
                      );
                    },
                    child: _profileItem(
                      context,
                      Icons.settings_outlined,
                      'Settings',
                      const Color(0xFF8A7F6B),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 45,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFB5502E),
                  side: const BorderSide(color: Color(0xFFE4D9C3)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Log out', style: TextStyle(fontSize: 13)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileItem(
    BuildContext context,
    IconData icon,
    String text,
    Color iconColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Icon(icon, size: 17, color: iconColor),

          const SizedBox(width: 12),

          Text(
            text,
            style: const TextStyle(fontSize: 13, color: Color(0xFF3A3226)),
          ),

          const Spacer(),

          const Icon(Icons.chevron_right, size: 17, color: Color(0xFFC9BFA8)),
        ],
      ),
    );
  }
}
