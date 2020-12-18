import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterapp/Services/markers_service.dart';
import 'package:flutterapp/Services/places_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Person.dart';
import 'Profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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
  static final CameraPosition myPosition = CameraPosition(
    bearing: 192.833 ,
    target: LatLng(32.215996, 35.259131),
    tilt: 59.440,
    zoom: 11.0,
  );

  Future <void> _goToMyPosition() async
  {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(myPosition));

  }



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


  _onTypePressed()
  {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal ? MapType.satellite : _currentMapType = MapType.normal;

    });
  }

  _onMarkerPressed()
  {
    setState(() {
      _Markers.add(
          Marker(
        markerId: MarkerId(_lastMapPos.toString()),
            position: _lastMapPos,
            infoWindow: InfoWindow(
              title: 'title',
              snippet: 'snippet'
            ),
              icon: BitmapDescriptor.defaultMarker,


      ));
    }
    );

  }

  Position _currentPosition;
  final Geolocator geolocator = Geolocator();

  _getCurrentLocation() {
    Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

    });
  }
  List<Place> places=List();
  final PlacesService Pservice=PlacesService();
  _getPlacesList(double lat,double lon) async
  {
    places=await Pservice.getPlaces(lat, lon);


  }
void CheckCurrentPosition()
{
  setState(() {
    _currentPosition!=null? print(_currentPosition.latitude.toString() +' , ' +_currentPosition.longitude.toString())
        : print("current position is null");
  });

}

  @override
  void initState() {

    super.initState();
    getFlag();
    print ( "I'm your flag in getFlag function in MyMap class : "+ SignedIn);
    setState(() {
     // _getCurrentLocation();
    _getPlacesList(32.164750,35.285340);

    });

  }



    @override
  Widget build(BuildContext context) {
final markserService=MarkerService();

setState(() {
  CheckCurrentPosition();
 _getPlacesList(32.164750,35.285340);
});
var markers=(places!=null)? markserService.getMarkers(places):List<Marker>();

    return Scaffold(
      body: Column(

        children: <Widget>[
          Stack(
            children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*5.5/10,
                  child:GoogleMap(
                    trafficEnabled: true,
                  //  myLocationButtonEnabled: true,
                    //myLocationEnabled: true,
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target:LatLng(32.164750,35.285340),
                      zoom: 13.0,
                      //zoomGestureEnabled:true,
                    ),
                    mapType: _currentMapType,
                    markers: Set<Marker>.of(markers),
                    onCameraMove: _onCameraMove,
                  ),
                ),

                //Expanded(child:ListView.builder(itemBuilder: ,itemCount: places.length,)),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child:
                  Align(alignment: Alignment.topRight,
                  child: Column(
                    children: <Widget> [
                      button(_onTypePressed, Icons.map ),
                      SizedBox(height:25.0),
                      button(_onMarkerPressed, Icons.add_location),

                    ],
                  ),)
                ),
               ] ),

          SizedBox(height:10.0),
           places!=null?     Expanded(

                  child: ListView.builder(itemBuilder: (context,index)
                  {

                    return Card( color:Colors.white,child: ListTile(title:places[index].poi.name!=null? Text(places[index].poi.name):null,
                      subtitle:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>
                      [
                        Row(children: <Widget>
                        [
                          RatingBarIndicator(
                            rating: places[index].score,
                            itemBuilder: (context,index)=> Icon(Icons.star,color:Colors.amberAccent),
                            itemCount: 5,
                            itemSize: 15.0,
                            direction: Axis.horizontal,
                          ),
                        ],),

                            Text((places[index].address.streetName!=null?places[index].address.streetName:"unknown")
                                +', '+(places[index].address.municipality!=null?places[index].address.municipality:" "))
                      ],)



                      ,trailing: IconButton(icon: Icon(Icons.directions), color: Theme.of(context).primaryColor,
                      onPressed: ()
                        {
                          _launchMapsUrl(places[index].location.lat, places[index].location.lon);
                        },)
                      ,),);
                     }
                  ,itemCount: places.length,),
                ):Center(child:CircularProgressIndicator()),


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
