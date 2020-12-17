import 'dart:convert' as convert;
import 'package:flutterapp/models/Place.dart';
import 'dart:convert';

class PlacesService
{
  final key="SaWRbGTGzfBGddIrgFChV0NHKhlek6kg";
  Future <List<Place>> getPlaces(double lat,double lon) async
  {
    var response = await http.get('https://api.tomtom.com/search/2/search/Parking.json?typeahead=true&limit=10&countrySet=Judea and Samaria&lat=$lat&lon=$lon&key=$key');
var json=convert.jsonDecode(response.body):
    var jsonResults=json['results'] as List;
 return jsonResults.map(place)=>Place.fromJson(place)).toList();

  }
}