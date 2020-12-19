import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterapp/Services/gas_stations_service.dart';
import 'package:flutterapp/Services/markers_service.dart';
import 'package:flutterapp/Services/places_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'models/Place.dart';

class MyMap extends StatefulWidget{
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  String SignedIn="Empty";

  Future getFlag() async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();

    setState(()
    {
      SignedIn= preferences.getString('SignedIn');
       });
  }



  Completer <GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(32.215996, 35.259131);
  final Set<Marker>  _Markers ={};
  LatLng _lastMapPos= _center;
  MapType _currentMapType = MapType.normal;






_onMapCreated(GoogleMapController controller)
{
  _getPlacesList(32.164750,35.285340);

}

_onCameraMove(CameraPosition position)
{
  _lastMapPos=position.target;
}
 Widget button (Function function, IconData icon)
 {

return FloatingActionButton(
  onPressed: function ,
  heroTag: null,
  materialTapTargetSize: MaterialTapTargetSize.padded,
  backgroundColor: Colors.teal[400],
  child: Icon(
    icon,
    size: 40.0,
  ),

);
 }

  Widget smallButton (IconData icon)
  {

    return Container(
      width: 35,
      height: 35,
      child: FittedBox(

        child: FloatingActionButton(

          heroTag: null,

          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: Colors.teal[400],

          child: Icon(
            icon,
            size: 30.0,
          ),

        ),
      ),
    );
  }

  _onParkPressed()
  {
    setState(() {
     whatPressed=0;
     keepPressed();

    });
  }
  _onGasStationPressed()
  {
    setState(() {
      whatPressed=1;
      keepPressed();
    });
  }


  _onTypePressed()
  {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal ? MapType.satellite : _currentMapType = MapType.normal;

    });
  }


  Position _currentPosition;
  final Geolocator geolocator = Geolocator();

  List<Place> places=List();
  final PlacesService Pservice=PlacesService();
  _getPlacesList(double lat,double lon) async
  {
    places=await Pservice.getPlaces(lat, lon);

  }
  List<Place> gasStations=List();
  final GasService _gasService=GasService();
  _getGasStationsList(double lat,double lon) async
  {
    gasStations=await _gasService.getPlaces(lat, lon);

  }

void CheckCurrentPosition()
{
  setState(() {
    _currentPosition!=null? print(_currentPosition.latitude.toString() +' , ' +_currentPosition.longitude.toString())
        : print("current position is null");
  });

}
Future keepPressed()async
{
  SharedPreferences preferences=await SharedPreferences.getInstance();
  preferences.setInt('whatPressed', whatPressed);
}

  @override
  void initState() {

    super.initState();
    getFlag();
    print ( "I'm your flag in getFlag function in MyMap class : "+ SignedIn);
    setState(() {
     // _getCurrentLocation();
    _getPlacesList(32.164750,35.285340);
    _getGasStationsList(32.164750,35.285340);

    });

  }


int whatPressed=10;


    @override
  Widget build(BuildContext context) {
final markserService=MarkerService();

setState(() {
  CheckCurrentPosition();
 _getPlacesList(32.164750,35.285340);
  _getGasStationsList(32.164750,35.285340);
  places= whatPressed==1?gasStations:places;

});
var markers=(places!=null)? markserService.getMarkers(places):List<Marker>();
var gasStationsMarkers=(places==gasStations)? markserService.getMarkers(gasStations):List<Marker>();
    return Scaffold(
      body: Column(

        children: <Widget>[
          Stack(
            children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: whatPressed==10?MediaQuery.of(context).size.height*9/10:MediaQuery.of(context).size.height*6/10,
                  child:GoogleMap(
                    trafficEnabled: true,
                   myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target:LatLng(32.164750,35.285340),
                      zoom: 11.0,
                    ),
                    mapType: _currentMapType,
                    markers:whatPressed!=10? Set<Marker>.of(markers):Set<Marker>.of(List<Marker>()),
                    onCameraMove: _onCameraMove,
                  ),
                ),


                Padding(
                  padding: EdgeInsets.all(13.0),
                  child:
                  Align(alignment: Alignment.topRight,
                  child: Column(
                    children: <Widget> [
                      SizedBox(height:60.0),
                      button(_onTypePressed, Icons.map ),
                      SizedBox(height:15.0),
                      button(_onParkPressed, Icons.local_parking),
                      SizedBox(height:15.0),
                      button(_onGasStationPressed, Icons.local_gas_station),
                    ],
                  ),)
                ),
               ] ),

          whatPressed==10? SizedBox(height:10.0):Container(height:0.0),
           places!=null&&whatPressed!=10?     Expanded(

                  child: ListView.builder(itemBuilder: (context,index)
                  {

                    return Card( color:Colors.white,child: ListTile(title:places[index].poi.name!=null? Text(places[index].poi.name):null,
                      subtitle:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>
                      [
                       /* Row(children: <Widget>
                        [
                          RatingBarIndicator(
                            rating: places[index].score,
                            itemBuilder: (context,index)=> Icon(Icons.star,color:Colors.amberAccent),
                            itemCount: 5,
                            itemSize: 15.0,
                            direction: Axis.horizontal,
                          ),
                        ],),
*/
                            Text((places[index].address.streetName!=null?places[index].address.streetName:"unknown")
                                +', '+(places[index].address.municipality!=null?places[index].address.municipality:" ")),
                          SizedBox(height:15.0),

                          Text(places[index].dist.toString().substring(0,6)+"m far from you"),   ],
                      )



                      ,trailing: IconButton(icon: Icon(Icons.directions), color: Theme.of(context).primaryColor,
                      onPressed: ()
                        {
                          _launchMapsUrl(places[index].location.lat, places[index].location.lon);
                        },)
                      ,),);
                     }
                  ,itemCount: places.length,),
                ):Row(
             children: [
              SizedBox(width:5),
             smallButton(Icons.local_parking ),
             Text(' : Find near parking lots' ,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
               SizedBox(width:25),
               smallButton(Icons.local_gas_station ),
               Text(' : Find near gas stations' ,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),

             ],)//Center(child:CircularProgressIndicator()),


        ],),
    );





  }
  void _launchMapsUrl(double lat,double lng) async
  {
    final url='https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(url))
      await launch(url);
    else throw'Could not launch $url';

  }
}
