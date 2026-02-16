// Arquivo: lib/models/tasks.model.dart
import 'package:app_lista_compras/models/produto.model.dart'; // Importe o produto

class Task {
  String title;
  String? description;
  bool completed;
  bool important;
  // NOVO: A lista de produtos dentro desta tarefa
  List<Product> products;

  Task({
    required this.title,
    this.description,
    this.important = false,
    this.completed = false,
    // Inicializa a lista vazia se não for passada
    List<Product>? products, 
  }) : products = products ?? [];
}