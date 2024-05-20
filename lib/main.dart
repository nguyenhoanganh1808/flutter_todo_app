import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/add_todo_screen.dart';
import 'package:todo_app/todo.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  TodoListScreenState createState() => TodoListScreenState();
}

class TodoListScreenState extends State<TodoListScreen> {
  List<Todo> todos = [
    Todo(
      id: 1,
      title: 'Buy groceries',
      description: 'Milk, Bread, Eggs',
      dueDate: DateTime.now().add(const Duration(days: 1)),
    ),
    Todo(
      id: 2,
      title: 'Buy milk',
      description: '...',
      dueDate: DateTime.now().add(const Duration(days: 365)),
    ),
  ];

  void _navigateToAddTodoScreen(BuildContext context) async {
    final newTodo = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTodoScreen()),
    );
    if (newTodo != null) {
      setState(() {
        todos.add(newTodo);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _navigateToAddTodoScreen(context),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            title: Text('${index + 1}. ${todo.title}'),
            subtitle: Text('Due: ${formatter.format(todo.dueDate)}'),
            trailing: Icon(
              todo.isCompleted
                  ? Icons.check_circle
                  : Icons.check_circle_outline,
              color: todo.isCompleted ? Colors.green : null,
            ),
            onTap: () {
              setState(() {
                todo.isCompleted = !todo.isCompleted;
              });
            },
          );
        },
      ),
    );
  }
}
