import 'package:flutter/material.dart';
import 'package:fanaticfit/cart_model.dart';
import 'home_screen.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {

    if (CartStorage.cartItems.isEmpty) {
      return const Center(
        child: Text("Cart is empty"),
      );
    }

    return Column(
      children: [

        Container(
          padding: const EdgeInsets.all(15),
          color: Colors.red,
          width: double.infinity,
          child: Text(
            "Cart : ${CartStorage.totalQuantity} Items",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: CartStorage.cartItems.length,
            itemBuilder: (context, index) {

              final item = CartStorage.cartItems[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [

                    Row(
                      children: [

                        Image.asset(item.image, height: 100),

                        const SizedBox(width: 15),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text("${item.price}/-TK"),
                              const SizedBox(height: 5),
                              Text("Size: ${item.size}"),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Row(
                          children: [

                            IconButton(
                              onPressed: () {
                                setState(() {
                                  CartStorage.decreaseQuantity(index);
                                });
                              },
                              icon: const Icon(Icons.remove_circle_outline),
                            ),

                            Text(
                              item.quantity.toString(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),

                            IconButton(
                              onPressed: () {
                                setState(() {
                                  CartStorage.increaseQuantity(index);
                                });
                              },
                              icon: const Icon(Icons.add_circle_outline),
                            ),
                          ],
                        ),

                        Text(
                          "${item.price * item.quantity}/-TK",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            CartStorage.removeItem(index);
                          });
                        },
                        child: const Text(
                          "Remove",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),

        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total amount :",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    "${CartStorage.totalAmount}/-TK",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Row(
                children: [

                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                              (route) => false,
                        );
                      },
                      child: const Text(
                        "Continue Shopping",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),

                  // ✅ Checkout button now goes to CheckoutScreen
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                        );
                      },
                      child: const Text(
                        "Checkout",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}