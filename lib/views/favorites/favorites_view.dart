import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key, required this.title});

  final String title;

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  List<String> favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() async {
    var user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      var snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .get();

      setState(() {
        favorites = [for (var document in snapshot.docs) document['name']];
      });
    }
  }

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

            Text('My favorites', style: headingStyle),

            const SizedBox(height: 2),

            Text("Recipes you've saved", style: smallStyle),

            const SizedBox(height: 18),

            if (favorites.isEmpty)
              const Text(
                'No saved recipes yet.',
                style: TextStyle(fontSize: 13, color: Color(0xFF8A7F6B)),
              ),

            if (favorites.isNotEmpty)
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    return _recipeCard(favorites[index]);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _recipeCard(String name) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: const Icon(
                Icons.restaurant,
                size: 30,
                color: Color(0xFFE8813A),
              ),
            ),
          ),

          Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF3A3226),
            ),
          ),

          const SizedBox(height: 5),

          const Row(
            children: [
              Icon(Icons.star, size: 12, color: Color(0xFFEF9F27)),

              SizedBox(width: 3),

              Text(
                'Saved',
                style: TextStyle(fontSize: 11, color: Color(0xFF8A7F6B)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
