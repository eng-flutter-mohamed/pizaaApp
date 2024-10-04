class Restaurant {
  final int id;
  final String name;
  final String address1;
  final String address2;
  final double latitude;
  final double longitude;

  Restaurant({
    required this.id,
    required this.name,
    required this.address1,
    required this.address2,
    required this.latitude,
    required this.longitude,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      address1: json['address1'],
      address2: json['address2'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
