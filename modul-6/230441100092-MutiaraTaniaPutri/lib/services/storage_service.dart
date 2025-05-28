import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/image_data.dart';

class StorageService {
  static const _key = 'image_data_list';

  static Future<void> saveImages(List<ImageData> images) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = images.map((e) => json.encode(e.toJson())).toList();
    await prefs.setStringList(_key, jsonList);
  }

  static Future<List<ImageData>> loadImages() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_key) ?? [];
    return jsonList.map((item) => ImageData.fromJson(json.decode(item))).toList();
  }
}
