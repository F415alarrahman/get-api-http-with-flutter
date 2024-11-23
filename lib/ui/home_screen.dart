import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:week8/services/recipe_service.dart';
import 'package:week8/services/session_service.dart';
import 'package:week8/ui/detail_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RecipeService _recipeService = RecipeService();
  List<dynamic> recipes = []; // Simpan data resep di sini

  @override
  void initState() {
    super.initState();
    _fetchRecipes(); // Ambil data saat widget diinisialisasi
  }

  Future<void> _fetchRecipes() async {
    final data = await _recipeService.getAllRecipe();
    if (data != null) {
      setState(() {
        recipes = data; // Simpan data di state
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _fetchRecipes(), // Refresh data saat tombol ditekan
        child: const Icon(Icons.sync),
      ),
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: recipes.isEmpty
            ? const Center(
                child: CircularProgressIndicator()) // Loading jika data kosong
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Dua kolom untuk menampilkan data
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio:
                      3 / 4, // Rasio ukuran grid (lebar vs tinggi)
                ),
                itemCount: recipes.length,
                itemBuilder: (BuildContext context, int index) {
                  final recipe = recipes[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(recipe: recipe), // Kirim data resep
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey[200],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Gambar Resep
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(
                                    16)), // Sudut membulat pada gambar
                            child: Image.network(
                              recipe['photo_url'], // URL gambar
                              height: 120, // Tinggi gambar
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                Icons.broken_image,
                                size: 120,
                                color: Colors.grey,
                              ), // Placeholder jika gagal memuat gambar
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Judul Resep
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              recipe['title'] ?? 'No Title',
                              maxLines: 1,
                              overflow: TextOverflow
                                  .ellipsis, // Potong teks jika terlalu panjang
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Deskripsi Resep
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              recipe['description'] ?? 'No Description',
                              maxLines: 2,
                              overflow: TextOverflow
                                  .ellipsis, // Potong teks jika terlalu panjang
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          const Spacer(),
                          // Informasi Tambahan (Like Count)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.thumb_up,
                                        size: 16, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text("${recipe['likes_count'] ?? 0} Likes"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.comment,
                                        size: 16, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(
                                        "${recipe['comments_count'] ?? 0} Comments"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
