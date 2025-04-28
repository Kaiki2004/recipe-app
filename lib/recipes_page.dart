import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  List<dynamic> recipes = [];
  List<dynamic> filteredRecipes = [];
  final TextEditingController _searchController = TextEditingController();
  final String apiKey = '8de1212a84dd46578b0851a21d20b984';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRecipes('pasta');
  }

  Future<void> fetchRecipes(String query) async {
    setState(() => _isLoading = true);
    try {
      final response = await http.get(Uri.parse(
        'https://api.spoonacular.com/recipes/complexSearch?query=$query&number=20&addRecipeInformation=true&apiKey=$apiKey',
      ));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          recipes = data['results'];
          filteredRecipes = recipes;
          _isLoading = false;
        });
      } else {
        throw Exception('Erro na API');
      }
    } catch (e) {
      print('Erro: $e');
      setState(() => _isLoading = false);
    }
  }

  void filterRecipes(String query) {
    setState(() {
      filteredRecipes = recipes
          .where((r) => r['title'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receitas 🍽️'),
        backgroundColor: Colors.deepOrange,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: filterRecipes,
              decoration: InputDecoration(
                hintText: 'Buscar receita...',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filteredRecipes.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final recipe = filteredRecipes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RecipeDetailPage(recipe: recipe),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16)),
                          child: Image.network(
                            recipe['image'],
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            recipe['title'],
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class RecipeDetailPage extends StatelessWidget {
  final Map recipe;
  const RecipeDetailPage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['title']),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(recipe['image'], height: 200),
            const SizedBox(height: 20),
            Text(
              recipe['title'],
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              _removeHtmlTags(recipe['summary']),
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

  String _removeHtmlTags(String htmlText) {
    final RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }
}
