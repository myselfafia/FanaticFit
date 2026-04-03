import 'package:flutter/material.dart';
import 'jersey_collection_screen.dart';

class SubCategoryScreen extends StatelessWidget {
  final String title;
  final List<Map<String, String>> subCategories;

  const SubCategoryScreen({
    super.key,
    required this.title,
    required this.subCategories,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: subCategories.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 0.9,
        ),
        itemBuilder: (context, index) {
          final club = subCategories[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      JerseyCollectionScreen(
                        league: title,
                        club: club["name"]!,
                      ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  Image.asset(
                    club["image"]!,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    club["name"]!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}