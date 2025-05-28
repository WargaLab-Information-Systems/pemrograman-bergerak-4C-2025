class ImageData {
  final String path;
  final double latitude;
  final double longitude;

  ImageData({required this.path, required this.latitude, required this.longitude});

  Map<String, dynamic> toJson() => {
    'path': path,
    'latitude': latitude,
    'longitude': longitude,
  };

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
    path: json['path'],
    latitude: json['latitude'],
    longitude: json['longitude'],
  );
}
