import 'package:flutter/material.dart';

import '../../services/recipe_service.dart';
import 'recipe_details_view.dart';

class RecipeResultsView extends StatefulWidget {
  const RecipeResultsView({
    super.key,
    required this.title,
    this.query,
    this.initialRecipes,
  });

  final String title;
  final String? query;
  final List<dynamic>? initialRecipes;

  @override
  State<RecipeResultsView> createState() => _RecipeResultsViewState();
}

class _RecipeResultsViewState extends State<RecipeResultsView> {
  List<dynamic> recipes = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.initialRecipes != null) {
      recipes = widget.initialRecipes!;
    } else {
      _loadRecipes(widget.query ?? 'chicken');
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadRecipes(String query) async {
    var service = RecipeService();

    var results = await service.searchRecipes(query);

    setState(() {
      recipes = results;
    });
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

            Text('Recipe results', style: headingStyle),

            const SizedBox(height: 2),

            Text('Recipes you can make', style: smallStyle),

            const SizedBox(height: 18),

            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search recipes',
                suffixIcon: IconButton(
                  onPressed: () {
                    if (_searchController.text.isNotEmpty) {
                      _loadRecipes(_searchController.text);
                    }
                  },
                  icon: const Icon(Icons.search),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),

            const SizedBox(height: 18),

            Text('${recipes.length} recipes found', style: smallStyle),

            const SizedBox(height: 10),

            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.8,
                ),
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  var recipe = recipes[index];

                  return _recipeCard(
                    context,
                    recipe['strMeal'],
                    recipe['strMealThumb'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recipeCard(BuildContext context, String name, String image) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                RecipeDetailsView(title: 'Recipe Details', recipeName: name),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14),
              ),
              child: Image.network(
                image,
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF3A3226),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
