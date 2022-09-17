import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:world_time/services/world_time.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

  
class _HomeState extends State<Home> {
  
  Map<dynamic, dynamic> arguments = {};
  var args;
  var args1;

  @override
  Widget build(BuildContext context) {
    arguments = arguments.isNotEmpty ? arguments : ModalRoute.of(context)!.settings.arguments as Map;
    if (arguments != null){
      args = arguments['location'];
      args1 = arguments['time'];
    } 

    //set background
    String bgImage = arguments['isDaytime'] ? 'day.png' : 'night.png';
    Color? bgColor = arguments['isDaytime'] ? Colors.blue : Colors.indigo[700];
    
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/$bgImage'
              ),
              fit: BoxFit.cover,
            )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 120.0, 0.0, 0.0),
            child: Column(
              children: <Widget>[
               FlatButton.icon(onPressed: () async {
                dynamic result = await Navigator.pushNamed(context, '/location');
                setState((){
                  arguments = {
                    'time': result['time'],
                    'location': result['location'],
                    'flag': result['flag'],
                    'isDaytime': result['isDaytime']
                  };
                });
               }, 
                icon: Icon(
                  Icons.edit_location,
                  color: Colors.grey[300]
                  ), 
                label: Text(
                  'edit location',
                  style: TextStyle(
                    color: Colors.grey[300]
                  ),
                  )
                ),
                SizedBox(
                  height: 20.0
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      args,
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: Colors.white
                      ),
                    ),
                  ]
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  args1,
                  style: TextStyle(
                    fontSize: 66.0,
                    color: Colors.white
                  ),
                ),
              ],
            ),
          ),
        ))
    );
  }
}