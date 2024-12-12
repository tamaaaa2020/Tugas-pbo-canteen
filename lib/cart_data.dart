class CartItem {
  final String image;
  final String title;
  final double price;
  int count;

  CartItem({
    required this.image,
    required this.title,
    required this.price,
    this.count = 1,
  });
}

class CartData {
  static List<CartItem> cartItems = [];
}