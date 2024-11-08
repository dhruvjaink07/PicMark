import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkScreen extends StatefulWidget {
  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  late Future<List<String>> _bookmarkedImagesFuture;

  @override
  void initState() {
    super.initState();
    _bookmarkedImagesFuture = _getBookmarkedImages();
  }

  Future<List<String>> _getBookmarkedImages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('bookmarkedImages') ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarked Images'),
      ),
      body: FutureBuilder<List<String>>(
        future: _bookmarkedImagesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No bookmarks yet.'));
          } else {
            final images = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: images.length,
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      images[index],
                      fit: BoxFit.cover,
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
