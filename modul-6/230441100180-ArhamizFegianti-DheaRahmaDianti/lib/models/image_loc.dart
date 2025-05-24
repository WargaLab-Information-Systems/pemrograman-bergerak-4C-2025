class ImageWithLocation {
  final String imagePath;
  final String? locationText;

  ImageWithLocation({required this.imagePath, this.locationText});

  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
        'locationText': locationText,
      };

  factory ImageWithLocation.fromJson(Map<String, dynamic> json) {
    return ImageWithLocation(
      imagePath: json['imagePath'],
      locationText: json['locationText'],
    );
  }
}
