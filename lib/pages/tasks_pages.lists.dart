import 'package:app_lista_compras/models/tasks.model.dart';
import 'package:app_lista_compras/pages/task_create_page.dart';
import 'package:app_lista_compras/pages/task_detail_page.dart';
import 'package:flutter/material.dart';

class TasksListPage extends StatefulWidget {
  const TasksListPage({super.key});

  @override
  State<TasksListPage> createState() => _TasksListPageState();
}

class _TasksListPageState extends State<TasksListPage> {
  List<Task> myTasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          'Minhas listas',
          key: Key("appBarTitle"),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.diamond, color: Colors.amber[400], size: 30),
          ),
        ],
      ),

      /////////////////////////////////////
      body: myTasks.isEmpty
          ? const _EmptyStateWidget()
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: myTasks.length,
              itemBuilder: (context, index) {
                final task = myTasks[index];

                // Cálculos
                int totalItems = task.products.length;
                int completedItems = task.products
                    .where((p) => p.isCompleted)
                    .length;
                double progress = totalItems == 0
                    ? 0
                    : completedItems / totalItems;

                return Card(
                  key: const Key("shoppingListCard"),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    onTap: () async {
                      //////////////////////////////////
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetailPage(task: task),
                        ),
                      );
                      setState(() {});
                    },
                    title: Text(
                      task.title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: progress,
                          color: Colors.green,
                          backgroundColor: Colors.grey[200],
                          minHeight: 6,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        const SizedBox(height: 4),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "$completedItems/$totalItems", // Texto ex: 2/3
                            style: TextStyle(
                              color: progress == 1 ? Colors.green : Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      ////////////////////////////////////////////////////////////////////>
      floatingActionButton: FloatingActionButton(
        key: const Key("addListBtn"),
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TaskCreatePage()),
          );
          if (newTask != null && newTask is Task) {
            setState(() {
              myTasks.add(newTask);
            });
          }
        },
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}

////////////////////////////////////////////////////////>
class _EmptyStateWidget extends StatelessWidget {
  const _EmptyStateWidget();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/lista-de-compras.png', height: 120, 
          key: const Key("emptylistimage"),
          ),

          const SizedBox(height: 20),
          const Text(
            'Crie sua primeira lista',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          ),
          const Text(
            'Toque no botão azul',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
