import 'package:flutter/material.dart';
import 'package:app_lista_compras/models/tasks.model.dart';

class TaskCreatePage extends StatefulWidget {
  const TaskCreatePage({super.key});

  @override
  State<TaskCreatePage> createState() => _TaskCreatePageState();
}
// controladores
class _TaskCreatePageState extends State<TaskCreatePage> {
  final TextEditingController _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }
/////////////////////////////////////////////////////>
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //////////////////////////////////////////
              Container(
                color: Colors.white,
                child: TextField(
                  key: const Key("listNameInput"),
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'Nome da lista',
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const Spacer(), 
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      key: const Key("backToListsBtn"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Voltar'),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Botão Criar
                  Expanded(
                    child: ElevatedButton(
                      key: const Key("createListBtn"),
                      onPressed: () {
                        final String title = _titleController.text;
                        if (title.isNotEmpty) {  
                          final newTask = Task(title: title);
                          Navigator.pop(context, newTask);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 0,
                      ),
                      child: const Text('Criar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
