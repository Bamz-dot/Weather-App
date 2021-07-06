import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

void main() => runApp(
    MaterialApp(
      title: "Weather App",
      home: Home(),
    )
);

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState () {
    return _HomeState ();
  }
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;
  Future getWeather () async{
  try {
    http.Response response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=London&appid=8c718b5e4f38cc06f5c9f38471bf641f"));
    var results = jsonDecode(response.body);
    print(results);
    setState(() {
      temp = results['main']['temp'];
      description = results['weather'][0]['description'];
      currently = results['weather'][0]['main'];
      humidity = results['main']['humidity'];
      windSpeed = results['wind']['speed'];
    });
  }catch(error){
     print(error);
  } }
  @override
  void initState () {
    super.initState();
    getWeather();
  }
  @override
  Widget build (BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 3,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              color: Colors.cyan,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "Currently in London",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  Text(
                    temp != null ? temp.toString() + "\u00B0" : "Loading",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      currently != null ? currently.toString() : "Loading",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                        title: Text("Temperature"),
                        trailing: Text(temp != null ? temp.toString() + "\u00B0" : "Loading"),
                      ),
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.cloud),
                        title: Text("Weather"),
                        trailing: Text(description != null ? description.toString() : "Loading"),
                      ),
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.sun),
                        title: Text("Temperature Humidity"),
                        trailing: Text(humidity != null ? humidity.toString() : "Loading"),
                      ),
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.wind),
                        title: Text("Wind Speed"),
                        trailing: Text(windSpeed != null ? windSpeed.toString() : "Loading"),
                      ),
                    ],
                  ),
                )
            ),
          ],
        )
    );
  }     
}