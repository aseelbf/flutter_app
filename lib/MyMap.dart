import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Person.dart';
import 'Profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:permission/permission.dart';
import 'package:permission_handler/permission_handler.dart';
class MyMap extends StatefulWidget{
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  String SignedIn="Empty flag";

  Future getFlag() async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();

    setState(()
    {
      SignedIn= preferences.getString('SignedIn');
      print ( "I'm your flag in getFlag function in MyMap class : "+ SignedIn);
    });
  }


  @override
  void initState() {

    super.initState();
    getFlag();
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
  _controller.complete(controller);
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



  @override
  Widget build(BuildContext context) {
    int _currentIndex_=0;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Map", style: TextStyle(  letterSpacing: 2.0, fontFamily: 'Pacifico-Regular',),),
          backgroundColor: Colors.teal[400]
      ),

      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target:  _center,
              zoom: 11.0,
            ),
            mapType: _currentMapType,
            markers: _Markers,
            onCameraMove: _onCameraMove,
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child:
            Align(alignment: Alignment.topRight,
            child: Column(
              children: <Widget> [
                button(_onTypePressed, Icons.map ),
                SizedBox(height:16.0),
                button(_onMarkerPressed, Icons.add_location),
                SizedBox(height:16.0),
                button(_goToMyPosition, Icons.location_searching),
              ],
            ),)
          ),
        ],

      ),








     bottomNavigationBar: CurvedNavigationBar(
      animationCurve: Curves.decelerate,
      color: Colors.teal[400],
      backgroundColor: Colors.grey[300],
      animationDuration: Duration(
          milliseconds: 100
      ),
      height: 60,

      index: _currentIndex_,
      items: <Widget> [
        IconButton(icon: Icon(Icons.location_on)  ,iconSize:35, focusColor: Colors.grey[300],
            onPressed:()
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyMap()));

            }),


        IconButton(icon: Icon(Icons.home), iconSize:35, focusColor: Colors.grey[300],
            onPressed:()
            {
              Navigator.pushNamed(context,'/home');

            }
           ),

        IconButton(icon: Icon(Icons.person_outline), iconSize:35, focusColor: Colors.grey[300],
            onPressed:()
            {
              print(SignedIn);
              if (SignedIn=="T")
                Navigator.push(context, MaterialPageRoute(builder: (context) => Person()));
              else
                Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));

            }),

      ],
      onTap: (index){
        setState(()
        {
          _currentIndex_=index;

        } );
      },

    ),
    );
  }
}
