import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:ui';
import 'package:arcore_flutter_plugin_example/custom_3d_object.dart';
import 'package:arcore_flutter_plugin_example/custom_shapes.dart';
import 'package:arcore_flutter_plugin_example/runtime_materials.dart';
import 'package:flutter/material.dart';

import 'galaxy.dart';

class HomeScreen extends StatefulWidget {


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //flag to check if the program is loading?
  bool isLoading = true;
  //defined an image to show results
  File image;
  //this will show up when fetching data from API
  String resultText = "Sonuçlar getiriliyor...";
  String welcomeLabel = "ARCore Wizard";





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background-img.jpg"),
              fit: BoxFit.cover,
            )
        ),
        child: Container(
          padding: EdgeInsets.all(30.0),

          child: Column(
            children: [
              Center(

                child: isLoading
                //if true display uuser interface
                    ? Container(
                  padding:EdgeInsets.only(top: 0.0),
                  decoration: BoxDecoration(


                    borderRadius: BorderRadius.only(topRight:Radius.circular(30.0),bottomLeft: Radius.circular(30.0) ),
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow:
                    [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0,20),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10.0,),
                      Container(
                          width: 300.0,
                          child: Image.asset("assets/background-img.png")
                      ),
                      SizedBox(height:10.0,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          //live camera
                          SizedBox.fromSize(
                            size: Size(100,100),
                            child: ClipOval(
                                child: Material(
                                  color: Colors.deepPurple,
                                  child: InkWell(
                                      splashColor:  Colors.white,
                                      onTap: (){
                                        print("clicked");
                                        //todo change later CustomShapes()
                                        Navigator.push(context,MaterialPageRoute(builder: (context)=> GalaxyScreen()));

                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.blur_circular,size:45,color: Colors.white,),
                                          Text("GALAXY",style:TextStyle(fontSize: 15.0,color: Colors.white,fontWeight: FontWeight.bold),),
                                        ],
                                      )
                                  ),
                                )
                            ),
                          ),


                          SizedBox(width: 3.0,),


                          //pick from gallery
                          SizedBox.fromSize(
                            size: Size(120,120),
                            child: ClipOval(
                                child: Material(
                                  color: Colors.deepPurple,
                                  child: InkWell(
                                      splashColor:  Colors.white,
                                      onTap: (){
                                        Navigator.push(context,MaterialPageRoute(builder: (context)=> RuntimeMaterials()));
                                        print("clicked");
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.av_timer,size:60,color: Colors.white,),
                                          Text("RUNTIME",style:TextStyle(fontSize: 15.0,color: Colors.white,fontWeight: FontWeight.bold),),
                                        ],
                                      )
                                  ),
                                )
                            ),
                          ),


                          SizedBox(width: 3.0,),

                          //capture image with camera
                          SizedBox.fromSize(
                            size: Size(100,100),
                            child: ClipOval(
                                child: Material(
                                  color: Colors.deepPurple,
                                  child: InkWell(
                                      splashColor:  Colors.white,
                                      onTap: (){
                                        Navigator.push(context,MaterialPageRoute(builder: (context)=> Object3DScreen()));
                                        print("clicked");
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.approval,size:45,color: Colors.white,),
                                          Text("3D OBJECT",style:TextStyle(fontSize: 15.0,color: Colors.white,fontWeight: FontWeight.bold),),
                                        ],
                                      )
                                  ),
                                )
                            ),
                          ),


                        ],
                      ),

                      SizedBox(width: 0.0,height: 10,),
                      Container(

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft:Radius.circular(30.0)),
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Colors.blue,
                                  Colors.red,
                                ],
                              )
                          ),
                          child: Text(
                              welcomeLabel,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white,fontSize:71.0,fontWeight: FontWeight.w900,),
                          )
                      ),
                    ],
                  ),
                )
                //display for showing results
                    : Container(
                  padding: EdgeInsets.only(top: 50.0),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
