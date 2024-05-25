class ShoppingItem {
  final String name;
  int quantity;

  ShoppingItem({required this.name, this.quantity = 1});

  void increaseQuantity() {
    quantity++;
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }
}
