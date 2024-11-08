import 'package:flutter/material.dart';

class GistFilesScreen extends StatelessWidget {
  final Map<String, dynamic> files;

  GistFilesScreen({required this.files});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Files"),
      ),
      body: ListView.builder(
        itemCount: files.length,
        itemBuilder: (context, index) {
          String fileName = files.keys.elementAt(index);
          String fileUrl = files[fileName]['raw_url'];

          return ListTile(
            title: Text(fileName),
            onTap: () {
              // Open the file URL in a web view or browser
              // (Implementation for this would depend on the specific use case)
            },
          );
        },
      ),
    );
  }
}
