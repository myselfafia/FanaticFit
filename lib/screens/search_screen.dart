import 'package:flutter/material.dart';
import 'jersey_data.dart';
import 'jersey_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> allProducts = [];
  List<Map<String, dynamic>> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    loadAllProducts();
  }

  // 🔥 Collect ALL jerseys from your data
  void loadAllProducts() {
    JerseyData.data.forEach((league, clubs) {
      clubs.forEach((club, jerseys) {
        for (var jersey in jerseys) {
          allProducts.add(jersey);
        }
      });
    });

    filteredProducts = allProducts;
  }

  // 🔥 Search logic
  void searchProduct(String query) {
    final results = allProducts.where((product) {
      final name = product["name"].toString().toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredProducts = results;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        // 🔍 SEARCH BAR
        Padding(
          padding: const EdgeInsets.all(15),
          child: TextField(
            controller: searchController,
            onChanged: searchProduct,
            decoration: InputDecoration(
              hintText: "Search jerseys...",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),

        // 📦 RESULTS
        Expanded(
          child: filteredProducts.isEmpty
              ? const Center(child: Text("No products found"))
              : ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {

              final product = filteredProducts[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => JerseyDetailsScreen(
                        jersey: product,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.grey.shade300,
                      )
                    ],
                  ),
                  child: Row(
                    children: [

                      Image.asset(
                        product["image"],
                        height: 70,
                      ),

                      const SizedBox(width: 15),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              product["name"],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text("${product["price"]}/-TK"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}