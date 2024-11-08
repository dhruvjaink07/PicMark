import 'dart:convert';
import 'package:app/Model/Gist.dart';
import 'package:app/Screens/gist_file_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GistScreen extends StatefulWidget {
  const GistScreen({super.key});

  @override
  State<GistScreen> createState() => _GistScreenState();
}

class _GistScreenState extends State<GistScreen> {
  // Variables
  late Future<List<Gist>> gists;

  // Methods
  Future<List<Gist>> fetchGists() async {
    final response = await http.get(
      Uri.parse("https://api.github.com/gists/public"),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Gist.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load gists');
    }
  }

  @override
  void initState() {
    gists = fetchGists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gist Screen"),
      ),
      body: FutureBuilder<List<Gist>>(
        future: gists,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No gists available'));
          }

          final gists = snapshot.data!;
          return ListView.builder(
            itemCount: gists.length,
            itemBuilder: (context, index) {
              final gist = gists[index];

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  title: Text(
                    gist.description.isNotEmpty ? gist.description : "No Description",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Text(
                        "Comments: ${gist.commentCount}",
                        style: TextStyle(color: Colors.blueGrey[600]),
                      ),
                      Text(
                        "Created: ${gist.createdAt}",
                        style: TextStyle(color: Colors.blueGrey[600]),
                      ),
                      Text(
                        "Updated: ${gist.updatedAt}",
                        style: TextStyle(color: Colors.blueGrey[600]),
                      ),
                    ],
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.blueGrey),
                  onTap: () {
                    // Navigate to new screen to show file listing
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GistFilesScreen(files: gist.files),
                      ),
                    );
                  },
                  onLongPress: () {
                    // Show owner information in a dialog
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Row(
                            children: [
                              Icon(Icons.person, color: Colors.blueAccent),
                              SizedBox(width: 8),
                              Text("Owner Information"),
                            ],
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Username: ${gist.owner['login']}",
                                  style: TextStyle(fontWeight: FontWeight.w600)),
                              SizedBox(height: 8),
                              Text("Profile: ${gist.owner['html_url']}"),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Close"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
