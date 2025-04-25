// models/place.dart
class Place {
  final String title;
  final String location;
  final String imageUrl;
  final String imageDetail;
  final String description;
  final String category; 
  final String price;   

  Place({
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.imageDetail,
    required this.description,
    required this.category,
    required this.price,
  });
}

List<Place> placeList = List.generate(
  5,
  (index) => Place(
    title: 'National Park Yosemite',
    location: 'California',
    imageUrl: 'images/place.png',
    imageDetail: 'images/imgDetail.png',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
        'Phasellus egestas id dignissim in vestibulum augue ut a lectus. '
        'Vivamus sed ullamcorper est vestibulum sed mus.',
    category: 'Wisata Alam',
    price: '30.000,00',
  ),
);
