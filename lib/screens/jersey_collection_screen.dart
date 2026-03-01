import 'package:flutter/material.dart';
import 'jersey_data.dart';
import 'jersey_details_screen.dart';

class JerseyCollectionScreen extends StatelessWidget {
  final String league;
  final String club;

  const JerseyCollectionScreen({
    super.key,
    required this.league,
    required this.club,
  });

  @override
  Widget build(BuildContext context) {

    final jerseys =
        JerseyData.data[league]?[club] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(club),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: jerseys.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          final jersey = jerseys[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      JerseyDetailsScreen(
                        jersey: jersey,
                      ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    color:
                    Colors.grey.shade300,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset(
                      jersey["image"],
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    jersey["name"],
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "৳${jersey["price"]}",
                    style: const TextStyle(
                        fontWeight:
                        FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}