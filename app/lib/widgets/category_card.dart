import 'package:flutter/material.dart';
import '../screens/chat_screen.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String rubricId;
  final String imageUrl;

  const CategoryCard({super.key, required this.title, required this.rubricId, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(rubricId: rubricId),
          ),
        );
      },
      child: Card(
        child: Column(
          children: [
            Image.network(imageUrl, height: 100, width: double.infinity, fit: BoxFit.cover),
            SizedBox(height: 8),
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
