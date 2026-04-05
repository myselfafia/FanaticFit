import 'package:flutter/material.dart';
import 'package:fanaticfit/cart_model.dart';
import 'wishlist_model.dart';
import 'home_screen.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CartStorage.cartItems.clear();
    WishlistStorage.wishlistItems.clear();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Icon(Icons.check_circle, color: Colors.red, size: 100),

            const SizedBox(height: 20),

            const Text(
              "Order Placed Successfully",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red),
            ),

            const SizedBox(height: 50),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(250, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                      (route) => false,
                );
              },
              child: const Text("Continue Shopping", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),

          ],
        ),
      ),
    );
  }
}