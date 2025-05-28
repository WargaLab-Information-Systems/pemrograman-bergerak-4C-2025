import 'dart:io';
import 'package:flutter/material.dart';
import '../models/captured_image.dart';

class GalleryScreen extends StatelessWidget {
  final List<CapturedImage> images;

  const GalleryScreen({required this.images, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body:
          images.isEmpty
              ? const Center(child: Text('No images available'))
              : GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.8,
                ),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  final image = images[index];
                  return GestureDetector(
                    onTap: () => _showImageDetails(context, image),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Image.file(
                              File(
                                image.imagePath.isNotEmpty
                                    ? image.imagePath
                                    : image.path ?? '',
                              ),
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (_, __, ___) => const Center(
                                    child: Icon(Icons.broken_image, size: 40),
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  image.description?.isNotEmpty == true
                                      ? image.description!
                                      : 'No description',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                if (image.address?.isNotEmpty == true)
                                  Text(
                                    image.address!,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                Text(
                                  '${image.latitude.toStringAsFixed(4)}, '
                                  '${image.longitude.toStringAsFixed(4)}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  image.formattedDate,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }

  void _showImageDetails(BuildContext context, CapturedImage image) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Image Details'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.file(
                    File(
                      image.imagePath.isNotEmpty
                          ? image.imagePath
                          : image.path ?? '',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('Description: ${image.description ?? 'None'}'),
                  const SizedBox(height: 8),
                  Text('Location: ${image.address ?? 'Unknown'}'),
                  const SizedBox(height: 8),
                  Text(
                    'Coordinates: ${image.latitude.toStringAsFixed(6)}, '
                    '${image.longitude.toStringAsFixed(6)}',
                  ),
                  const SizedBox(height: 8),
                  Text('Date: ${image.formattedDate}'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
    );
  }
}
