class Poi
{
  final String name;


  Poi({this.name});
  Poi.fromJson(Map<dynamic, dynamic> parsedJson )
      :name=parsedJson['name']!=null? parsedJson['name'] :null;

}