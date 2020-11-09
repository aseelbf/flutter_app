
class Fuel
{
  String _countryCode;
  String _date;
  String _currency;
  double _gas;


Fuel(this._countryCode , this._date , this._currency , this._gas);

  factory Fuel.fromJSON(Map<String,dynamic> json)
  {
    if (json==null)
      {
        return null;
      }
    else
      {
        return Fuel(json["_countryCode"],json["_date"],json["_currency"],json["_gas"]);
      }

  }

  get  countryCode => this._countryCode;
  get date => this._date;
  get currency => this._currency;
  get gasoline => this._gas;


}