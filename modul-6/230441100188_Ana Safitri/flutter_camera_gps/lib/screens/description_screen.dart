import 'dart:io';
import 'package:flutter/material.dart';
import '../models/captured_image.dart';

class DescriptionScreen extends StatefulWidget {
  final String sourcePath;
  final double latitude;
  final double longitude;

  const DescriptionScreen({
    required this.sourcePath,
    required this.latitude,
    required this.longitude,
    Key? key,
  }) : super(key: key);

  @override
  _DescriptionScreenState createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Description')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Image.file(File(widget.sourcePath), fit: BoxFit.contain),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
                hintText: 'Enter image description...',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            Text(
              'Location: ${widget.latitude.toStringAsFixed(4)}, '
              '${widget.longitude.toStringAsFixed(4)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  CapturedImage(
                    path: widget.sourcePath,
                    description: _descriptionController.text,
                    latitude: widget.latitude,
                    longitude: widget.longitude,
                    timestamp: DateTime.now(),
                  ),
                );
              },
              child: const Text('Save Image'),
            ),
          ],
        ),
      ),
    );
  }
}
