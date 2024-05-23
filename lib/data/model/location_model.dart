import 'dart:convert';

class LocationModel {
  final int? id;
  final String addressType;
  final String address;
  final double longitude;
  final double latitude;
  LocationModel({
    this.id,
    required this.addressType,
    required this.address,
    required this.longitude,
    required this.latitude,
  });

  LocationModel copyWith({
    int? id,
    String? addressType,
    String? address,
    double? longitude,
    double? latitude,
  }) {
    return LocationModel(
      id: id ?? this.id,
      addressType: addressType ?? this.addressType,
      address: address ?? this.address,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'addressType': addressType,
      'address': address,
      'longitude': longitude,
      'latitude': latitude,
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      id: map['id'] != null ? map['id'] as int : null,
      addressType: map['addressType'] as String,
      address: map['address'] as String,
      longitude: map['longitude'] as double,
      latitude: map['latitude'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) =>
      LocationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LocationModel(id: $id, addressType: $addressType, address: $address, longitude: $longitude, latitude: $latitude)';
  }

  @override
  bool operator ==(covariant LocationModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.addressType == addressType &&
        other.address == address &&
        other.longitude == longitude &&
        other.latitude == latitude;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        addressType.hashCode ^
        address.hashCode ^
        longitude.hashCode ^
        latitude.hashCode;
  }
}
