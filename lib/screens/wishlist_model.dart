class WishlistItem {
  String name;
  String image;
  int price;
  String description;
  List sizes;

  WishlistItem({
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.sizes,
  });
}

class WishlistStorage {
  static List<WishlistItem> wishlistItems = [];

  static void addItem(WishlistItem item) {
    int index = wishlistItems.indexWhere(
          (e) => e.name == item.name,
    );

    if (index == -1) {
      wishlistItems.add(item);
    }
  }

  static void removeItem(String name) {
    wishlistItems.removeWhere((item) => item.name == name);
  }

  static bool isExist(String name) {
    return wishlistItems.any((item) => item.name == name);
  }
}