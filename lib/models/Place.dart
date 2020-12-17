import 'package:flutterapp/models/Address.dart';
import 'package:flutterapp/models/Location.dart';
import 'package:flutterapp/models/Poi.dart';
class Place{
  final Location location;
  final Poi poi ;
  final Address address;
  final double score;
  final double dist;

  Place({this.location, this.address, this.poi, this.score, this.dist});
  Place.fromJson(Map<dynamic, dynamic> parsedJson )
      :score=parsedJson['score']!=null? parsedJson['score'].toDouble():null,
       dist=parsedJson['dist']!=null?parsedJson['dist'].toDouble():null,
      location=Location.fromJson(parsedJson['position']),
       poi=Poi.fromJson(parsedJson['poi']),
       address=Address.fromJson(parsedJson['address']);





}