import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FullScreenImagePage extends StatefulWidget {
  final String imageUrl;

  FullScreenImagePage({required this.imageUrl});

  @override
  _FullScreenImagePageState createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _checkIfBookmarked();
  }

  Future<void> _checkIfBookmarked() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = prefs.getStringList('bookmarkedImages') ?? [];
    setState(() {
      isBookmarked = bookmarks.contains(widget.imageUrl);
    });
  }

  Future<void> _toggleBookmark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = prefs.getStringList('bookmarkedImages') ?? [];

    if (isBookmarked) {
      bookmarks.remove(widget.imageUrl);
    } else {
      bookmarks.add(widget.imageUrl);
    }

    await prefs.setStringList('bookmarkedImages', bookmarks);
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: Colors.white,
            ),
            onPressed: _toggleBookmark,
          ),
        ],
      ),
      body: Center(
        child: Image.network(widget.imageUrl, fit: BoxFit.contain),
      ),
    );
  }
}
