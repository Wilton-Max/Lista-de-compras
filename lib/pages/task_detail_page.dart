import 'package:app_lista_compras/models/produto.model.dart';
import 'package:app_lista_compras/models/tasks.model.dart';
import 'package:flutter/material.dart';

class TaskDetailPage extends StatefulWidget {
  final Task task;

  const TaskDetailPage({super.key, required this.task});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  double get totalMarcados => widget.task.products
      .where((p) => p.isCompleted)
      .fold(0, (sum, item) => sum + item.price);

  double get totalNaoMarcados => widget.task.products
      .where((p) => !p.isCompleted)
      .fold(0, (sum, item) => sum + item.price);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.task.title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor:
            Colors.green, // Ajustado para verde conforme as telas do PDF
        foregroundColor: Colors.white, // Texto branco
        iconTheme: const IconThemeData(color: Colors.white), // Seta branca
        actions: [
          // BOTÃO ATUALIZAR ADICIONADO
          TextButton(
            key: const Key("updateListBtn"), // KEY ADICIONADA
            onPressed: () {
              setState(() {}); // Apenas atualiza a tela
            },
            child: const Text(
              "Atualizar",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildValueCard("Não marcados", totalNaoMarcados, Colors.blue),
                _buildValueCard("Marcados", totalMarcados, Colors.green),
              ],
            ),
          ),
          const Divider(height: 1),

          Expanded(
            child: widget.task.products.isEmpty
                ? const Center(child: Text("Nenhum item adicionado"))
                : ListView.builder(
                    itemCount: widget.task.products.length,
                    itemBuilder: (context, index) {
                      final product = widget.task.products[index];
                      return CheckboxListTile(
                        key: const Key("productCheckbox"),
                        title: Text(product.name),
                        secondary: Text(
                          "R\$ ${product.price.toStringAsFixed(2)}",
                          style: const TextStyle(fontWeight: FontWeight.w400),
                        ),
                        value: product.isCompleted,
                        activeColor: Colors.green,
                        onChanged: (value) {
                          setState(() {
                            product.isCompleted = value!;
                          });
                        },
                      );
                    },
                  ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        key: const Key("addNewItemBtn"),
        onPressed: _showAddItemModal,
        label: const Text("Adicionar"),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildValueCard(String label, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(
          "R\$ ${value.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }

  void _showAddItemModal() {
    _nameController.clear();
    _priceController.clear();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Adicionar Item",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(),
              TextField(
                key: const Key("inputItem"),
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Nome do item"),
              ),
              TextField(
                key: const Key("inputValue"),
                controller: _priceController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(labelText: "Preço (R\$)"),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  key: const Key("addItemBtn"),
                  onPressed: () {
                    if (_nameController.text.isNotEmpty) {
                      setState(() {
                        widget.task.products.add(
                          Product(
                            id: DateTime.now().toString(),
                            name: _nameController.text,
                            price:
                                double.tryParse(
                                  _priceController.text.replaceAll(',', '.'),
                                ) ??
                                0.0,
                          ),
                        );
                      });
                      Navigator.pop(context);
                    }
                  },
                  style: TextButton.styleFrom(foregroundColor: Colors.blue),
                  child: const Text(
                    "Adicionar",
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
