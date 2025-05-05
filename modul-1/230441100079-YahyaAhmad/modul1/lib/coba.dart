import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SimpleListView(),
      ),
    );
  }
}

class SimpleListView extends StatelessWidget {
  const SimpleListView({super.key});

  @override
  Widget build(BuildContext context) {
    // Contoh data sederhana
    final items = List<String>.generate(10, (index) => 'Item ${index + 1}');

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(items[index]),
          ),
        );
      },
    );
  }
}

