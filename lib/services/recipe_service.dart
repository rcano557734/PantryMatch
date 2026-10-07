import 'dart:convert';

import 'package:http/http.dart' as http;

class RecipeService {
  Future<List<dynamic>> searchRecipes(String query) async {
    var url = Uri.parse(
      'https://www.themealdb.com/api/json/v1/1/search.php?s=$query',
    );

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data['meals'] == null) {
        return [];
      }

      return data['meals'];
    }

    return [];
  }

  Future<List<dynamic>> filterRecipes(String ingredient) async {
    var url = Uri.parse(
      'https://www.themealdb.com/api/json/v1/1/filter.php?i=${Uri.encodeComponent(ingredient.toLowerCase())}',
    );

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data['meals'] == null) {
        return [];
      }

      return data['meals'];
    }

    return [];
  }

  Future<List<dynamic>> searchByIngredients(List<String> ingredients) async {
    if (ingredients.isEmpty) {
      return [];
    }

    var results = await filterRecipes(ingredients[0]);

    for (var i = 1; i < ingredients.length; i++) {
      var otherResults = await filterRecipes(ingredients[i]);

      var otherIds = {for (var recipe in otherResults) recipe['idMeal']};

      results = results.where((recipe) {
        return otherIds.contains(recipe['idMeal']);
      }).toList();

      if (results.isEmpty) {
        break;
      }
    }

    return results;
  }
}
