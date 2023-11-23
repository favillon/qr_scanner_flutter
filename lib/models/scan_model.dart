import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class ScanModel {
    
    int? id;
    String? type;
    String value;

    ScanModel({
      this.id,
      this.type,
      required this.value,
    }) {
      type =  (value.contains('http')) ? 'http' : 'geo';
    }

    LatLng  getlatLng() {
      final latLng = value.substring(4).split(',');
      final lat = double.parse( latLng[0]);
      final lng = double.parse( latLng[1]);
      return LatLng(lat, lng);
    }

    factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        type: json["type"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "value": value,
    };
}