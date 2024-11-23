import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final dynamic recipe; // Data resep diterima melalui parameter

  const DetailPage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['title'] ?? "Detail"), // Tampilkan judul resep
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar resep
            ClipRRect(
              child: Image.network(
                recipe['photo_url'], // URL gambar
                width: double.infinity,
                fit: BoxFit.cover,
                height: 200,
              ),
            ),
            const SizedBox(height: 16),
            // Judul resep
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                recipe['title'] ?? "No Title",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.thumb_up, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text("${recipe['likes_count'] ?? 0} Likes"),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Row(
                    children: [
                      const Icon(Icons.comment, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text("${recipe['comments_count'] ?? 0} Comments"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            // Deskripsi resep
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Description",
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                recipe['description'] ?? "No Description",
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
            // Informasi tambahan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Ingredients",
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                recipe['ingredients'] ?? "No Ingredients",
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Steps",
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                recipe['cooking_method'] ?? "No Steps",
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
