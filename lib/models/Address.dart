class Address{
  final String streetName;
  final String municipality;

  Address({this.streetName, this.municipality});
  Address.fromJson(Map<dynamic, dynamic> parsedJson )
      :streetName=parsedJson['streetName']!=null?parsedJson['streetName']:null,
       municipality=parsedJson['municipality']!=null?parsedJson['municipality']:null;


}