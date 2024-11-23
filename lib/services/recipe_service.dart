import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:week8/services/session_service.dart';

const String baseUrl = "https://recipe.incube.id/api";

class RecipeService {
  final SessionService _sessionService = SessionService();

  Future<List<dynamic>?> getAllRecipe() async {
    try {
      final token = await _sessionService.getToken();
      if (token == null || token.isEmpty) {
        print("Tidak ada token");
        return null;
      }
      final response = await http.get(
        Uri.parse("$baseUrl/recipes"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return jsonResponse['data']['data']; // Ambil daftar resep
      } else {
        print(
            "Failed to fetch recipes. Status code: ${response.statusCode}, Body: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
