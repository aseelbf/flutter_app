import 'package:flutterapp/models/Place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerService {

  List<Marker> getMarkers(List<Place> places){
    var markers = List<Marker>();

    places.forEach((place){
      Marker marker = Marker(

          markerId: MarkerId(place.poi.name),
          draggable: false,
          infoWindow: InfoWindow(title: place.poi.name, snippet: place.dist.toString().substring(0,6)+"m"),
          position: LatLng(place.location.lat, place.location.lon)
      );

      markers.add(marker);
    });

    return markers;
  }
}