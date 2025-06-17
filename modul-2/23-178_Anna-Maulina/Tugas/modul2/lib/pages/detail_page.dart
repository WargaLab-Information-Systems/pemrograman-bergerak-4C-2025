// pages/detail_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import '../models/place.dart';

class DetailPage extends StatelessWidget {
  final Place place;
  const DetailPage({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEDEDED),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        title: Text(place.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child:
                  place.imageDetail.startsWith('/')
                      ? Image.file(
                        File(place.imageDetail),
                        height: 240,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                      : Image.asset(
                        place.imageDetail,
                        height: 240,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.category,
                            size: 16,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              place.category,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              place.location,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(Icons.confirmation_number_outlined, size: 26),
                      const SizedBox(width: 4),
                      Text(
                        place.price,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              place.description * 5,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
