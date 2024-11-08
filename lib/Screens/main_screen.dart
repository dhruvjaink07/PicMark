import 'package:flutter/material.dart';
import 'gallery_screen.dart';
import 'gist_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> screenList = [const GistScreen(),  GalleryScreen()];
  int currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList[currentScreen],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent.shade100,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurpleAccent.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          currentIndex: currentScreen,
          onTap: (index) {
            setState(() {
              currentScreen = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list_rounded),
              label: 'Repo',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.photo_library_rounded),
              label: 'Gallery',
            ),
          ],
        ),
      ),
    );
  }
}
