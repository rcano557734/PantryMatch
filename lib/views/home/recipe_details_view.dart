import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../favorites/favorites_view.dart';

class RecipeDetailsView extends StatefulWidget {
  const RecipeDetailsView({
    super.key,
    required this.title,
    required this.recipeName,
  });

  final String title;
  final String recipeName;

  @override
  State<RecipeDetailsView> createState() => _RecipeDetailsViewState();
}

class _RecipeDetailsViewState extends State<RecipeDetailsView> {
  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    var headingStyle = const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20,
      color: Color(0xFF3A3226),
    );

    var smallStyle = const TextStyle(fontSize: 13, color: Color(0xFF8A7F6B));

    return Scaffold(
      backgroundColor: const Color(0xFFFBF6EC),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),

              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3EADA),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Icon(
                    Icons.soup_kitchen,
                    size: 60,
                    color: Color(0xFFE8813A),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              Text(widget.recipeName, style: headingStyle),

              const SizedBox(height: 6),

              Row(
                children: [
                  const Icon(Icons.star, size: 15, color: Color(0xFFEF9F27)),

                  const SizedBox(width: 4),

                  Text('4.8', style: smallStyle),

                  const SizedBox(width: 15),

                  const Icon(
                    Icons.access_time,
                    size: 15,
                    color: Color(0xFF8A7F6B),
                  ),

                  const SizedBox(width: 4),

                  Text('25 min', style: smallStyle),
                ],
              ),

              const SizedBox(height: 22),

              Text('Your ingredients', style: smallStyle),

              const SizedBox(height: 8),

              _ingredient('Chicken'),
              _ingredient('Tomato'),
              _ingredient('Egg'),

              const SizedBox(height: 18),

              Text('You may also need', style: smallStyle),

              const SizedBox(height: 8),

              _ingredient('Pasta'),
              _ingredient('Garlic'),
              _ingredient('Onion'),

              const SizedBox(height: 18),

              Text('Ingredients', style: smallStyle),

              const SizedBox(height: 8),

              const Text(
                'Chicken - 200g\n'
                'Tomato - 2 pieces\n'
                'Pasta - 200g\n'
                'Garlic - 2 cloves\n'
                'Onion - 1 piece',
                style: TextStyle(fontSize: 13, color: Color(0xFF3A3226)),
              ),

              const SizedBox(height: 18),

              Text('Instructions', style: smallStyle),

              const SizedBox(height: 8),

              const Text(
                '1. Cook the pasta until soft.\n'
                '2. Cook the chicken in a pan.\n'
                '3. Add tomato, garlic, and onion.\n'
                '4. Mix the pasta and sauce together.\n'
                '5. Serve and enjoy.',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: Color(0xFF3A3226),
                ),
              ),

              const SizedBox(height: 22),

              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () async {
                    var user = FirebaseAuth.instance.currentUser;

                    if (user != null) {
                      var favorites = FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid)
                          .collection('favorites');

                      var existingRecipe = await favorites
                          .where('name', isEqualTo: widget.recipeName)
                          .get();

                      if (existingRecipe.docs.isEmpty) {
                        await favorites.add({'name': widget.recipeName});
                      }

                      setState(() {
                        isSaved = true;
                      });
                    }
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSaved
                        ? const Color(0xFF639922)
                        : const Color(0xFFE8813A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  child: Text(isSaved ? 'Recipe Saved' : 'Save Recipe'),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ingredient(String name) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, size: 16, color: Color(0xFF639922)),

          const SizedBox(width: 8),

          Text(
            name,
            style: const TextStyle(fontSize: 12, color: Color(0xFF3A3226)),
          ),
        ],
      ),
    );
  }
}
