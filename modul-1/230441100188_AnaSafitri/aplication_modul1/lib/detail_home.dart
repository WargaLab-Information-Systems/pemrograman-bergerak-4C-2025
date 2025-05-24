import 'package:flutter/material.dart';

class DetailHome extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const DetailHome({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 218, 216, 216),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 12),

              // Gambar
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  imagePath,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),

              // Deskripsi
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    description,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 14, height: 1.5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
