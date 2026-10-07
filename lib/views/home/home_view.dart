import 'package:flutter/material.dart';

import 'ingredient_view.dart';
import 'recipe_results_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.title});
  final String title;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var headingStyle = const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: Color(0xFF3A3226),
    );

    var smallStyle = const TextStyle(fontSize: 12, color: Color(0xFF8A7F6B));

    return Scaffold(
      backgroundColor: const Color(0xFFFBF6EC),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),

            Text('Hi, Ralfh', style: headingStyle),

            const SizedBox(height: 2),

            Text('What do you want to cook?', style: smallStyle),

            const SizedBox(height: 16),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const RecipeResultsView(title: 'Recipe Results'),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE4D9C3)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Color(0xFFA99C82)),

                    SizedBox(width: 8),

                    Text(
                      'Search recipes...',
                      style: TextStyle(fontSize: 13, color: Color(0xFFA99C82)),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            Text("What's in your pantry?", style: smallStyle),

            const SizedBox(height: 8),

            Row(
              spacing: 8,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCEBCB),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Chicken',
                    style: TextStyle(fontSize: 12, color: Color(0xFF3B6D11)),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCEBCB),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Egg',
                    style: TextStyle(fontSize: 12, color: Color(0xFF3B6D11)),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCEBCB),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Tomato',
                    style: TextStyle(fontSize: 12, color: Color(0xFF3B6D11)),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const IngredientView(title: 'Ingredients'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE8813A),
                foregroundColor: Colors.white,
                fixedSize: const Size(double.infinity, 45),
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Find Recipes'),
            ),

            const SizedBox(height: 20),

            Text('Popular categories', style: smallStyle),

            const SizedBox(height: 8),

            Row(
              spacing: 8,
              children: [
                _category('Breakfast'),
                _category('Lunch'),
                _category('Dinner'),
              ],
            ),

            const SizedBox(height: 18),

            Text('Recommended for you', style: smallStyle),

            const SizedBox(height: 8),

            Row(
              spacing: 10,
              children: [
                _recipeCard('Pasta', Icons.soup_kitchen),
                _recipeCard('Chicken', Icons.restaurant),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _category(String name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF3EADA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        name,
        style: const TextStyle(fontSize: 11, color: Color(0xFF8A7F6B)),
      ),
    );
  }

  Widget _recipeCard(String name, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 24, color: const Color(0xFFE8813A)),
            const SizedBox(height: 6),
            Text(
              name,
              style: const TextStyle(fontSize: 12, color: Color(0xFF3A3226)),
            ),
          ],
        ),
      ),
    );
  }
}
