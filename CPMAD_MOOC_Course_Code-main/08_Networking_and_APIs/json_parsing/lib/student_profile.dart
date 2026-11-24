class GeoLocation {
  final String latitude;
  final String longitude;

  GeoLocation({required this.latitude, required this.longitude});

  factory GeoLocation.fromJson(Map<String, dynamic> json) {
    return GeoLocation(
      latitude: json['lat'] ?? '0.0',
      longitude: json['lng'] ?? '0.0',
    );
  }

  Map<String, dynamic> toJson() => {'lat': latitude, 'lng': longitude};
}

class UserLocation {
  final String street;
  final String city;
  final String postalCode;
  final GeoLocation coordinates;

  UserLocation({
    required this.street,
    required this.city,
    required this.postalCode,
    required this.coordinates,
  });

  factory UserLocation.fromJson(Map<String, dynamic> json) {
    return UserLocation(
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      postalCode: json['zipcode'] ?? '',
      coordinates: GeoLocation.fromJson(json['geo'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'street': street,
    'city': city,
    'zipcode': postalCode,
    'geo': coordinates.toJson(),
  };
}

class StudentProfile {
  final int id;
  final String name;
  final String email;
  final UserLocation location;

  StudentProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.location,
  });

  factory StudentProfile.fromJson(Map<String, dynamic> json) {
    return StudentProfile(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      location: UserLocation.fromJson(json['address'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'address': location.toJson(),
  };
}
