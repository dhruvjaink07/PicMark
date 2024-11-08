import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/UnsplashImage.dart';
import 'full_screen_image.dart';
import 'bookmark_screen.dart';
import '../Services/unsplash_service.dart';

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  late Future<List<UnsplashImage>> _imagesFuture;
  final UnsplashService _unsplashService = UnsplashService();

  @override
  void initState() {
    super.initState();
    _imagesFuture = _unsplashService.fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unsplash Gallery'),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookmarkScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<UnsplashImage>>(
        future: _imagesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No images found.'));
          } else {
            final images = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 1,
                ),
                itemCount: images.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreenImagePage(
                            imageUrl: images[index].imageUrl,
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        images[index].imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
