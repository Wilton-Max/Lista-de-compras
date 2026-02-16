// Arquivo: lib/models/product.model.dart

class Product {
  String id;
  String name;
  double price;
  bool isCompleted;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.isCompleted = false,
  });
}