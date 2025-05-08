import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String imagePath;

  const CardItem({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/detail'),
      child: Container(
        width: 250,
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white, // Putih
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(blurRadius: 2, color: Colors.grey.shade300)],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              child: Image.asset(
                imagePath,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'National Park Yosemite',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        decoration: TextDecoration.none, // Tidak ada garis bawah
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        decoration: TextDecoration.none, // Tidak ada garis bawah
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
