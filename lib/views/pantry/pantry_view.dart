import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PantryView extends StatefulWidget {
  const PantryView({super.key, required this.title});

  final String title;

  @override
  State<PantryView> createState() => _PantryViewState();
}

class _PantryViewState extends State<PantryView> {
  List<String> ingredients = [];
  List<String> ingredientIds = [];

  @override
  void initState() {
    super.initState();
    _loadPantry();
  }

  void _loadPantry() async {
    var user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      var snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('pantry')
          .get();

      setState(() {
        ingredients = [for (var document in snapshot.docs) document['name']];

        ingredientIds = [for (var document in snapshot.docs) document.id];
      });
    }
  }

  void _removeIngredient(int index) async {
    var user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('pantry')
          .doc(ingredientIds[index])
          .delete();

      _loadPantry();
    }
  }

  void _addIngredient() async {
    var controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add ingredient'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'Ingredient'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () async {
                var user = FirebaseAuth.instance.currentUser;

                if (user != null && controller.text.trim().isNotEmpty) {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .collection('pantry')
                      .add({'name': controller.text.trim()});

                  Navigator.pop(context);

                  _loadPantry();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
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

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),

              Text('My pantry', style: headingStyle),

              const SizedBox(height: 2),

              Text('Your saved ingredients', style: smallStyle),

              const SizedBox(height: 20),

              const Text(
                'Ingredients',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF3B6D11),
                ),
              ),

              const SizedBox(height: 8),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (var i = 0; i < ingredients.length; i++)
                    _ingredient(ingredients[i], i),
                ],
              ),

              const SizedBox(height: 22),

              SizedBox(
                width: double.infinity,
                height: 45,
                child: OutlinedButton(
                  onPressed: _addIngredient,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF8A7F6B),
                    side: const BorderSide(color: Color(0xFFC9A96E)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('+ Add ingredient'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ingredient(String name, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE4D9C3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 12, color: Color(0xFF3A3226)),
          ),

          const SizedBox(width: 5),

          GestureDetector(
            onTap: () {
              _removeIngredient(index);
            },
            child: const Icon(Icons.close, size: 14, color: Color(0xFF8A7F6B)),
          ),
        ],
      ),
    );
  }
}
