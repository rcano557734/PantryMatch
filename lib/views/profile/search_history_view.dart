import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchHistoryView extends StatefulWidget {
  const SearchHistoryView({super.key, required this.title});

  final String title;

  @override
  State<SearchHistoryView> createState() => _SearchHistoryViewState();
}

class _SearchHistoryViewState extends State<SearchHistoryView> {
  List<List<String>> history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  void _loadHistory() async {
    var user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      var snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('search_history')
          .get();

      setState(() {
        history = [
          for (var document in snapshot.docs)
            List<String>.from(document['ingredients']),
        ];
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

            Text('Search history', style: headingStyle),

            const SizedBox(height: 2),

            Text('Your previous recipe searches', style: smallStyle),

            const SizedBox(height: 18),

            if (history.isEmpty)
              const Text(
                'No search history yet.',
                style: TextStyle(fontSize: 13, color: Color(0xFF8A7F6B)),
              ),

            if (history.isNotEmpty)
              Expanded(
                child: ListView(
                  children: [
                    for (var ingredients in history) _historyItem(ingredients),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _historyItem(List<String> ingredients) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.history, size: 18, color: Color(0xFFE8813A)),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              ingredients.join(' + '),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF3A3226),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
