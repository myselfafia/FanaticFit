class CartItem {
  String name;
  String image;
  int price;
  String size;
  int quantity;

  CartItem({
    required this.name,
    required this.image,
    required this.price,
    required this.size,
    required this.quantity,
  });
}

class CartStorage {
  static List<CartItem> cartItems = [];

  static void addItem(CartItem item) {
    int index = cartItems.indexWhere(
          (e) => e.name == item.name && e.size == item.size,
    );

    if (index != -1) {
      cartItems[index].quantity += item.quantity;
    } else {
      cartItems.add(item);
    }
  }

  static void increaseQuantity(int index) {
    cartItems[index].quantity++;
  }

  static void decreaseQuantity(int index) {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
    }
  }

  static void removeItem(int index) {
    cartItems.removeAt(index);
  }

  static int get totalAmount {
    int total = 0;
    for (var item in cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }

  static int get totalQuantity {
    int total = 0;
    for (var item in cartItems) {
      total += item.quantity;
    }
    return total;
  }
}