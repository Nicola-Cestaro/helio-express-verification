import 'package:flutter/material.dart';
import 'package:ext/ui/home_screen.dart';

class Routes{

  var routes = <String, WidgetBuilder>{

    "/Home": (BuildContext) => HomeScreen(),

  };

  Routes(){
    runApp(
      MaterialApp(
        title: "Helio Express",
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
        routes: routes,
    ));
  }
}