import 'package:flutter/material.dart';
import 'database.dart';
import 'package:drift/drift.dart' as drift;

class TodoListPage extends StatelessWidget {
  final AppDatabase database;

  const TodoListPage({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: StreamBuilder(
        stream: database.watchAllTasks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final tasks = snapshot.data!;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(
                title: Text(task.title),
                leading: Checkbox(
                  value: task.isCompleted,
                  onChanged: (value) {
                    final updatedTask = task.copyWith(isCompleted: value);
                    database.updateTask(updatedTask);
                  },
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => database.deleteTask(task.id),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final titleController = TextEditingController();
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('New Task'),
              content: TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: 'Enter task title'),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    final title = titleController.text.trim();
                    if (title.isNotEmpty) {
                      final task = TasksCompanion(title: drift.Value(title));
                      database.insertTask(task);
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}






