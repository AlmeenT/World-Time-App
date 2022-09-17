import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class worldTime {

  String location, time = 'none', flag, url;
  //location name for the UI
  //time in that location
  // url to an asset flag icon
  // location url for api endpoint
  bool isDaytime = true; //true or false, if daytime or not

  worldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    
    
    try {
      Response response = await get(Uri.http('worldtimeapi.org', 'api/timezone/$url'));
    Map data = jsonDecode(response.body);
    //print(data);

    //get properties from data
    String datetime = data['datetime'];
    String offset = data['utc_offset'].substring(1,3);
    //print(offset);

    //print(datetime);
    //print(offset);

    //create a datetime object
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));
    

    //set the time property
    isDaytime = now.hour > 6 && time.contains('PM') ? true : false;
    time = DateFormat.jm().format(now);
    }
    catch (e) {
      print('caught error : $e');
      time = 'could not get time data';
    }


  }
}
 