import 'dart:io';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  PlaceLocation({
    required this.latitude,
    required this.longitude,
    this.address = '',
  });
}

class Place {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;

  const Place({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
  });

  Place copyWith({
    required String id,
    required String title,
    required PlaceLocation location,
    required File image,
  }) {
    if (identical(id, this.id) && identical(title, this.title) && identical(location, this.location) && identical(image, this.image)) {
      return this;
    }

    return new Place(
      id: id,
      title: title,
      location: location,
      image: image,
    );
  }

  @override
  String toString() {
    return 'Place{id: $id, title: $title, location: ${location.latitude}/${location.longitude}, image: ${image.path}}';
  }

  @override
  bool operator ==(Object other) => identical(this, other) || (other is Place && runtimeType == other.runtimeType && id == other.id && title == other.title && location == other.location && image == other.image);

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ location.hashCode ^ image.hashCode;

  factory Place.fromMap(Map<String, dynamic> map) {
    return new Place(
      id: map['id'] as String,
      title: map['title'] as String,
      location: map['location'] as PlaceLocation,
      image: map['image'] as File,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'location': this.location,
      'image': this.image,
    };
  }
}
