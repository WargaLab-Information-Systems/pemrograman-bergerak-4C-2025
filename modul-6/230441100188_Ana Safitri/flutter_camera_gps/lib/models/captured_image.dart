class CapturedImage {
  final String imagePath;
  final String? path;
  final String? description;
  final String? address;
  final double latitude;
  final double longitude;
  final DateTime timestamp;
  final String? location;
  final bool isSynced; // Properti tambahan

  CapturedImage({
    String? imagePath,
    this.path,
    this.description,
    this.address,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    this.location,
    this.isSynced = false,
  }) : imagePath = imagePath ?? path ?? '';

  String get formattedDate {
    return '${timestamp.day}/${timestamp.month}/${timestamp.year} ${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
  }

  Map<String, dynamic> toMap() {
    return {
      'imagePath': imagePath,
      'path': path ?? imagePath,
      'description': description,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp.toIso8601String(),
      'location': location ?? '$latitude,$longitude',
      'isSynced': isSynced,
    };
  }

  factory CapturedImage.fromMap(Map<String, dynamic> map) {
    final lat = (map['latitude'] ?? 0).toDouble();
    final long = (map['longitude'] ?? 0).toDouble();

    return CapturedImage(
      imagePath: map['imagePath'] ?? map['path'] ?? '',
      path: map['path'],
      description: map['description'],
      address: map['address'],
      latitude: lat,
      longitude: long,
      timestamp: DateTime.parse(map['timestamp']),
      location: map['location'] ?? '$lat,$long',
      isSynced: map['isSynced'] ?? false,
    );
  }

  // Helper method to update description
  CapturedImage copyWithDescription(String newDescription) {
    return CapturedImage(
      imagePath: imagePath,
      path: path,
      description: newDescription,
      address: address,
      latitude: latitude,
      longitude: longitude,
      timestamp: timestamp,
      location: location,
      isSynced: isSynced,
    );
  }

  // Optional: Method to update isSynced status
  CapturedImage copyWithSyncStatus(bool syncStatus) {
    return CapturedImage(
      imagePath: imagePath,
      path: path,
      description: description,
      address: address,
      latitude: latitude,
      longitude: longitude,
      timestamp: timestamp,
      location: location,
      isSynced: syncStatus,
    );
  }
}
