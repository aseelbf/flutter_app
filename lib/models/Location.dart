class Location
{
  final double lat;
  final double lon;

  Location({this.lat, this.lon});
  Location.fromJson(Map<dynamic, dynamic> parsedJson )
  :lat=parsedJson['lat'],
  lon=parsedJson['lon'];
}