import 'package:flutter/material.dart';

import 'home/home_view.dart';
import 'pantry/pantry_view.dart';
import 'favorites/favorites_view.dart';
import 'profile/profile_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key, required this.title});

  final String title;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var pages = [
      const HomeView(title: 'Home'),
      const PantryView(title: 'Pantry'),
      const FavoritesView(title: 'Favorites'),
      const ProfileView(title: 'Profile'),
    ];

    return Scaffold(
      body: pages[selectedIndex],

      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFFBF6EC),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navigationItem(Icons.home, 'Home', 0),

            _navigationItem(Icons.inventory_2_outlined, 'Pantry', 1),

            _navigationItem(Icons.favorite_border, 'Favorites', 2),

            _navigationItem(Icons.person_outline, 'Profile', 3),
          ],
        ),
      ),
    );
  }

  Widget _navigationItem(IconData icon, String label, int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Icon(
            icon,
            size: 18,
            color: selectedIndex == index
                ? const Color(0xFF639922)
                : const Color(0xFFB3A88F),
          ),
        ),

        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: selectedIndex == index
                ? const Color(0xFF639922)
                : const Color(0xFF8A7F6B),
          ),
        ),
      ],
    );
  }
}
