import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/UnsplashImage.dart';

class UnsplashService {
  final String _accessKey = 'YOUR_ACCESS_KEY';

  Future<List<UnsplashImage>> fetchImages() async {
    final response = await http.get(
      Uri.parse('https://api.unsplash.com/photos?client_id=$_accessKey&per_page=30'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => UnsplashImage.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load images');
    }
  }
}
