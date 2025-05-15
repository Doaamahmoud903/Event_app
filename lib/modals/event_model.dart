import 'package:google_maps_flutter/google_maps_flutter.dart';

class Event {
  static const String collectionName = "Events";

  String id;
  String title;
  String description;
  String eventName;
  DateTime dateTime;
  String time;
  String imageLight;
  String imageDark;
  bool isFavourite;
  LatLng? location; // ✅ الموقع

  Event({
    this.id = '',
    required this.title,
    required this.description,
    required this.eventName,
    required this.dateTime,
    required this.time,
    required this.imageLight,
    required this.imageDark,
    this.isFavourite = false,
    this.location, // ✅ أضفنا الموقع هنا
  });

  // object to JSON (Firestore)
  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'eventName': eventName,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'time': time,
      'imageLight': imageLight,
      'imageDark': imageDark,
      'isFavourite': isFavourite,
      'location': location != null
          ? {
              'lat': location!.latitude,
              'lng': location!.longitude,
            }
          : null, // ✅ الموقع كـ Map
    };
  }

  // JSON to object
  Event.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data['id'],
          title: data['title'] ?? "",
          description: data['description'] ?? "",
          eventName: data['eventName'] ?? "",
          dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime'] ?? 0),
          time: data['time'] ?? "",
          imageLight: data['imageLight'] ?? "",
          imageDark: data['imageDark'] ?? "",
          isFavourite: data['isFavourite'] ?? false,
          location: data['location'] != null
              ? LatLng(
                  data['location']['lat'] ?? 0.0,
                  data['location']['lng'] ?? 0.0,
                )
              : null, // ✅ تحويل الـ Map لـ LatLng
        );
}
