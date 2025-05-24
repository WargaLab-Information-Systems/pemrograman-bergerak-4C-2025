import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/image_loc.dart';

Future<void> saveImagesToPrefs(List<ImageWithLocation> images) async {
  final prefs = await SharedPreferences.getInstance();
  final encoded = images.map((e) => json.encode(e.toJson())).toList();
  await prefs.setStringList('images', encoded);
}

Future<List<ImageWithLocation>> loadImagesFromPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  final List<String>? data = prefs.getStringList('images');
  if (data != null) {
    return data
        .map((e) => ImageWithLocation.fromJson(json.decode(e)))
        .toList();
  }
  return [];
}
