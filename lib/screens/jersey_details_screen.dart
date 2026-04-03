import 'package:flutter/material.dart';
import 'package:fanaticfit/cart_model.dart';

class JerseyDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> jersey;

  const JerseyDetailsScreen({
    super.key,
    required this.jersey,
  });

  @override
  State<JerseyDetailsScreen> createState() =>
      _JerseyDetailsScreenState();
}

class _JerseyDetailsScreenState
    extends State<JerseyDetailsScreen> {

  late String selectedSize;
  int quantity = 1;
  bool isWishlisted = false;

  @override
  void initState() {
    super.initState();
    selectedSize = widget.jersey["sizes"][0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            Center(
              child: Image.asset(
                widget.jersey["image"],
                height: 250,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              widget.jersey["name"],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "${widget.jersey["price"]}/-TK",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.red,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Choose Size",
              style: TextStyle(
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              children: widget.jersey["sizes"]
                  .map<Widget>((size) {
                bool isSelected =
                    selectedSize == size;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedSize = size;
                    });
                  },
                  child: Container(
                    padding:
                    const EdgeInsets
                        .symmetric(
                        horizontal: 15,
                        vertical: 10),
                    decoration:
                    BoxDecoration(
                      border: Border.all(
                        color: isSelected
                            ? Colors.red
                            : Colors.grey,
                      ),
                      borderRadius:
                      BorderRadius.circular(8),
                    ),
                    child: Text(
                      size,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.red
                            : Colors.black,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),


            const Text(
              "Quantity",
              style: TextStyle(
                  fontWeight: FontWeight.bold),
            ),

            Row(
              children: [

                IconButton(
                  onPressed: () {
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                      });
                    }
                  },
                  icon:
                  const Icon(Icons.remove),
                ),

                Text(
                  quantity.toString(),
                  style:
                  const TextStyle(fontSize: 16),
                ),

                IconButton(
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),

            const SizedBox(height: 20),


            const Text(
              "Description",
              style: TextStyle(
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              widget.jersey["description"],
            ),

            const SizedBox(height: 30),


            ElevatedButton(
              style:
              ElevatedButton.styleFrom(
                minimumSize:
                const Size(double.infinity, 50),
                backgroundColor:
                Colors.red,
              ),
              onPressed: () {

                CartStorage.addItem(
                  CartItem(
                    name:
                    widget.jersey["name"],
                    image:
                    widget.jersey["image"],
                    price:
                    widget.jersey["price"],
                    size: selectedSize,
                    quantity: quantity,
                  ),
                );

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content:
                    Text("Added to Cart"),
                  ),
                );
              },
              child: const Text(
                "Add to cart",
                style: TextStyle(
                    fontWeight:
                    FontWeight.bold,
                    color: Colors.white),
              ),
            ),

            const SizedBox(height: 15),

            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                minimumSize:
                const Size(double.infinity, 50),
              ),
              onPressed: () {
                setState(() {
                  isWishlisted =
                  !isWishlisted;
                });
              },
              icon: Icon(
                isWishlisted
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: isWishlisted
                    ? Colors.red
                    : Colors.black,
              ),
              label: Text(
                isWishlisted
                    ? "Wishlisted"
                    : "Wishlist",
                style: TextStyle(color: Colors.black),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}