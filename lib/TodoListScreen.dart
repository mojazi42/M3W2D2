// import 'package:flutter/material.dart';
// import 'database.dart';
// import 'package:drift/drift.dart' as drift;
//
// class TodoListScreen extends StatefulWidget {
//   final AppDatabase database;
//
//   const TodoListScreen({super.key, required this.database});
//
//   @override
//   State<TodoListScreen> createState() => _TodoListScreenState();
// }
//
// class _TodoListScreenState extends State<TodoListScreen> {
//   final _titleController = TextEditingController();
//   final _contentController = TextEditingController();
//
//   void _addTodo() async {
//     final title = _titleController.text.trim();
//     final content = _contentController.text.trim();
//
//     if (title.length >= 6 && content.isNotEmpty) {
//       final todo = TodoItemsCompanion.insert(
//         title: title,
//         content: content,
//         createdAt: drift.Value(DateTime.now()),
//       );
//       await widget.database.into(widget.database.todoItems).insert(todo);
//       _titleController.clear();
//       _contentController.clear();
//       setState(() {});
//     }
//   }
//
//   void _deleteTodo(int id) async {
//     await database.deleteTodoById(id);
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Todo Notes')),
//       body: FutureBuilder<List<TodoItem>>(
//         future: database.getAllTodos(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
//
//           final todos = snapshot.data!;
//           if (todos.isEmpty) {
//             return const Center(child: Text('No notes yet'));
//           }
//
//           return ListView.builder(
//             itemCount: todos.length,
//             itemBuilder: (context, index) {
//               final todo = todos[index];
//               return ListTile(
//                 title: Text(todo.title),
//                 subtitle: Text(todo.content),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.delete),
//                   onPressed: () => _deleteTodo(todo.id),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: _titleController,
//               decoration: const InputDecoration(labelText: 'Title (min 6 chars)'),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: _contentController,
//               decoration: const InputDecoration(labelText: 'Content'),
//             ),
//             const SizedBox(height: 8),
//             ElevatedButton(
//               onPressed: _addTodo,
//               child: const Text('Add Todo'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
