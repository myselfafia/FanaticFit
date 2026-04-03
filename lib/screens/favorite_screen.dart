import 'package:flutter/material.dart';
import 'wishlist_model.dart';
import 'jersey_details_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  @override
  Widget build(BuildContext context) {

    if (WishlistStorage.wishlistItems.isEmpty) {
      return const Center(
        child: Text("Wishlist is empty"),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: WishlistStorage.wishlistItems.length,
      itemBuilder: (context, index) {

        final item = WishlistStorage.wishlistItems[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [

              Image.asset(item.image, height: 80),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold)),
                    Text("${item.price}/-TK"),
                  ],
                ),
              ),

              Column(
                children: [

                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              JerseyDetailsScreen(
                                jersey: {
                                  "name": item.name,
                                  "image": item.image,
                                  "price": item.price,
                                  "description":
                                  item.description,
                                  "sizes": item.sizes,
                                },
                              ),
                        ),
                      );
                    },
                  ),

                  IconButton(
                    icon: const Icon(Icons.delete,
                        color: Colors.red),
                    onPressed: () {
                      setState(() {
                        WishlistStorage.removeItem(
                            item.name);
                      });

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content:
                          Text("Removed from Wishlist"),
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}