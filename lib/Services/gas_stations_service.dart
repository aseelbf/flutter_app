import 'dart:convert' as convert;
import 'package:flutterapp/models/Place.dart';
import 'package:http/http.dart' as http;

class GasService {
  final key = 'SaWRbGTGzfBGddIrgFChV0NHKhlek6kg';
  Future<List<Place>> getPlaces(double lat, double lon) async {
    var response = await http.get(
        'https://api.tomtom.com/search/2/search/gas station.json?typeahead=true&limit=20&lat=${lat}&lon=${lon}&key=${key}');
    var json = convert.jsonDecode(response.body);
    var jsonResults = json["results"] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }
}
