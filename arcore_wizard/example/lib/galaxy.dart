import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

int k;
//stful
class GalaxyScreen extends StatefulWidget {

  @override
  _GalaxyScreenState createState() => _GalaxyScreenState();
}

class _GalaxyScreenState extends State<GalaxyScreen> {
  ArCoreController arCoreController;
  String objectSelected;

  void whenArCoreViewCreated(ArCoreController controller){
    arCoreController = controller;
    //when user click on 3d object
    arCoreController.onNodeTap = (name) => removeObject(name);
    //when user click on plane
    arCoreController.onPlaneTap = handleOnPlaneTap as ArCoreHitResultHandler;
  }

  //mercury
  Future _addMercury(ArCoreHitTestResult hit) async{

    final ByteData textureBytes = await rootBundle.load('assets/mercury.jpg');

    final mercuryMaterial = ArCoreMaterial(
      color: Color.fromARGB(120, 66, 134, 244),
      textureBytes: textureBytes.buffer.asUint8List(),
    );

    final mercuryShape = ArCoreSphere(
      materials: [mercuryMaterial],
      radius:0.076,
    );

    final mercury = ArCoreRotatingNode(
      scale: vector.Vector3(1,1,1),
      shape: mercuryShape,
      degreesPerSecond: 30,
      position: hit.pose.translation + vector.Vector3(0.0,0.5,0.0),
      rotation: hit.pose.rotation,
    );

    arCoreController.addArCoreNode(mercury);
  }

  //venus
  Future _addVenus(ArCoreHitTestResult hit) async{

    final ByteData textureBytes = await rootBundle.load('assets/venus.jpg');

    final bibliMaterial = ArCoreMaterial(
      color: Color.fromARGB(120, 66, 134, 244),
      textureBytes: textureBytes.buffer.asUint8List(),
    );

    final bibliShape = ArCoreSphere(
      materials: [bibliMaterial],
      radius:0.19,
    );

    final bibli = ArCoreRotatingNode(
      scale: vector.Vector3(1,1,1),
      shape: bibliShape,
      degreesPerSecond: 30,
      position: hit.pose.translation + vector.Vector3(0.0,0.5,0.0),
      rotation: hit.pose.rotation,
    );

    arCoreController.addArCoreNode(bibli);
  }

  //earth
  Future _addBibli(ArCoreHitTestResult hit) async{

    final ByteData textureBytes = await rootBundle.load('assets/earth.jpg');

    //bibliboy
    final bibliMaterial = ArCoreMaterial(
      color: Color.fromARGB(120, 66, 134, 244),
      textureBytes: textureBytes.buffer.asUint8List(),
    );

    final bibliShape = ArCoreSphere(
      materials: [bibliMaterial],
      radius:0.2,
    );

    final bibli = ArCoreRotatingNode(
      //because earth is flat
      scale: vector.Vector3(1,0.01,1),
      shape: bibliShape,
      degreesPerSecond: 72000000,
      position: hit.pose.translation + vector.Vector3(0.0,0.5,0.0),
      rotation: hit.pose.rotation,
    );

    arCoreController.addArCoreNode(bibli);
  }

  //mars
  Future _addMars(ArCoreHitTestResult hit) async{

    final ByteData textureBytes = await rootBundle.load('assets/mars.jpg');

    //bibliboy
    final marsMaterial = ArCoreMaterial(
      color: Color.fromARGB(120, 66, 134, 244),
      textureBytes: textureBytes.buffer.asUint8List(),
    );

    final marsShape = ArCoreSphere(
      materials: [marsMaterial],
      radius:0.1,
    );

    final mars = ArCoreRotatingNode(
      scale: vector.Vector3(1,1,1),
      shape: marsShape,
      degreesPerSecond: 72000000,
      position: hit.pose.translation + vector.Vector3(0.0,0.5,0.0),
      rotation: hit.pose.rotation,
    );

    arCoreController.addArCoreNode(mars);
  }

  //jupiter
  Future _addJupiter(ArCoreHitTestResult hit) async{

    final ByteData textureBytes = await rootBundle.load('assets/jupiter.jpg');

    //bibliboy
    final bibliMaterial = ArCoreMaterial(
      color: Color.fromARGB(120, 66, 134, 244),
      textureBytes: textureBytes.buffer.asUint8List(),
    );

    final bibliShape = ArCoreSphere(
      materials: [bibliMaterial],
      radius:0.8,
    );

    final bibli = ArCoreRotatingNode(
      scale: vector.Vector3(1,1,1),
      shape: bibliShape,
      degreesPerSecond: 30,
      position: hit.pose.translation + vector.Vector3(0.0,0.5,0.0),
      rotation: hit.pose.rotation,
    );

    arCoreController.addArCoreNode(bibli);
  }

  //saturn
  Future _addSaturn(ArCoreHitTestResult hit) async{

    final ByteData textureBytes = await rootBundle.load('assets/saturn.jpg');

    //bibliboy
    final bibliMaterial = ArCoreMaterial(
      color: Color.fromARGB(120, 66, 134, 244),
      textureBytes: textureBytes.buffer.asUint8List(),
    );

    final bibliShape = ArCoreSphere(
      materials: [bibliMaterial],
      radius:0.6,
    );

    final bibli = ArCoreRotatingNode(
      scale: vector.Vector3(1,1,1),
      shape: bibliShape,
      degreesPerSecond: 72000000,
      position: hit.pose.translation + vector.Vector3(0.0,0.5,0.0),
      rotation: hit.pose.rotation,
    );

    arCoreController.addArCoreNode(bibli);
  }

  //uranus
  Future _addUrAnus(ArCoreHitTestResult hit) async{

    final ByteData textureBytes = await rootBundle.load('assets/uranus.jpg');

    //bibliboy
    final bibliMaterial = ArCoreMaterial(
      color: Color.fromARGB(120, 66, 134, 244),
      textureBytes: textureBytes.buffer.asUint8List(),
    );

    final bibliShape = ArCoreSphere(
      materials: [bibliMaterial],
      radius:0.33,
    );

    final bibli = ArCoreRotatingNode(
      scale: vector.Vector3(1,1,1),
      shape: bibliShape,
      degreesPerSecond: 72000000,
      position: hit.pose.translation + vector.Vector3(0.0,0.5,0.0),
      rotation: hit.pose.rotation,
    );

    arCoreController.addArCoreNode(bibli);
  }

  //neptun
  Future _addNeptun(ArCoreHitTestResult hit) async{

    final ByteData textureBytes = await rootBundle.load('assets/neptune.jpg');

    final neptunMaterial = ArCoreMaterial(
      color: Color.fromARGB(120, 66, 134, 244),
      textureBytes: textureBytes.buffer.asUint8List(),
    );

    final neptunShape = ArCoreSphere(
      materials: [neptunMaterial],
      radius:0.3,
    );

    final neptun = ArCoreRotatingNode(
      scale: vector.Vector3(1,1,1),
      shape: neptunShape,
      degreesPerSecond: 72000000,
      position: hit.pose.translation + vector.Vector3(0.0,0.5,0.0),
      rotation: hit.pose.rotation,
    );

    arCoreController.addArCoreNode(neptun);
  }

  //sun
  Future _addSun(ArCoreHitTestResult hit) async{

    final ByteData textureBytes = await rootBundle.load('assets/sun.jpg');

    final sunMaterial = ArCoreMaterial(
      color: Color.fromARGB(120, 66, 134, 244),
      textureBytes: textureBytes.buffer.asUint8List(),
    );

    final sunShape = ArCoreSphere(
      materials: [sunMaterial],
      radius:1.0,
    );

    final sun = ArCoreRotatingNode(
      scale: vector.Vector3(1,1,1),
      shape: sunShape,
      degreesPerSecond: 11,
      position: hit.pose.translation + vector.Vector3(0.0,0.5,0.0),
      rotation: hit.pose.rotation,
    );

    arCoreController.addArCoreNode(sun);
  }

  //moon
  Future _addMoon(ArCoreHitTestResult hit) async{

    final ByteData textureBytes = await rootBundle.load('assets/moon.jpg');

    final moonMaterial = ArCoreMaterial(
      color: Color.fromARGB(120, 66, 134, 244),
      textureBytes: textureBytes.buffer.asUint8List(),
    );

    final moonShape = ArCoreSphere(
      materials: [moonMaterial],
      radius:0.05,
    );

    final moon = ArCoreRotatingNode(
      scale: vector.Vector3(1,1,1),
      shape: moonShape,
      degreesPerSecond: 55,
      position: hit.pose.translation + vector.Vector3(0.0,0.5,0.0),
      rotation: hit.pose.rotation,
    );

    arCoreController.addArCoreNode(moon);
  }

  //this function gets the hit value and choosen shape 'k' value and it will trigger the right function with destination value
  void handleOnPlaneTap(List<ArCoreHitTestResult> hits){
    final hit = hits.first;
    switch(k) {
      case 0: {
        _addMercury(hit);
      }
      break;
      case 1: {
        _addVenus(hit);
      }
      break;
      case 2: {
        _addBibli(hit);
      }
      break;
      case 3: {
        _addMars(hit);
      }
      break;
      case 4: {
        _addJupiter(hit);
      }
      break;
      case 5: {
        _addSaturn(hit);
      }
      break;
      case 6: {
        _addUrAnus(hit);
      }
      break;
      case 7: {
        _addNeptun(hit);
      }
      break;
      case 8: {
        _addSun(hit);
      }
      break;
      case 9: {
        _addMoon(hit);
      }
      break;
      default: {
        _addMoon(hit);
      }
      break;
    }
  }

  //if objectSelected not null it will add an object to hit point
  void addObject(ArCoreHitTestResult plane){
    if(objectSelected != null){
      final objectNode = ArCoreReferenceNode(
        name: objectSelected,
        object3DFileName: objectSelected,
        position: plane.pose.translation,
        rotation: plane.pose.rotation,
      );
      arCoreController.addArCoreNodeWithAnchor(objectNode);
    }
    //if objectSelected=null it means object is not selected; alert!
    else{
      showDialog(
        context: context,
        builder: (BuildContext c)=> AlertDialog(content: Text("Select an image."),),
      );
    }
  }

  //to remove object
  void removeObject(String name){
    showDialog(
      context: context,
      builder: (BuildContext c)=> AlertDialog(
        content: Row(
          children: [
            Text("Remove "+name),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: (){
                arCoreController.removeNode(nodeName: name);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }

  //dispose controller
  @override
  void dispose() {
    super.dispose();
    arCoreController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Space"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ArCoreView(
            onArCoreViewCreated: whenArCoreViewCreated,
            enableTapRecognizer: true,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: ListObjectSelection(
              onTap: (value){
                objectSelected=value;
              },
            ),
          )
        ],
      ),
    );
  }
}

class ListObjectSelection extends StatefulWidget {
  final Function onTap;

  ListObjectSelection({this.onTap});

  @override
  _ListObjectSelectionState createState() => _ListObjectSelectionState();
}

class _ListObjectSelectionState extends State<ListObjectSelection> {
  List<String> planets = [
    "assets/mercury.png",
    "assets/venus.png",
    "assets/earth.png",
    "assets/mars.png",
    "assets/jupiter.png",
    "assets/saturn.png",
    "assets/uranus.png",
    "assets/neptune.png",
    "assets/sun.png",
    "assets/moon.png",
  ];

  List<String> objectFileName = [
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
  ];

  String selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.builder(
        itemCount: planets.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index){
          return GestureDetector(
            onTap: (){
              setState(() {
                selected = planets[index];
                k=index;
                widget.onTap(objectFileName[index]);
              });
            },
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )
              ),
              child: Container(
                color: selected == planets[index] ? Colors.red : Colors.transparent,
                padding: selected == planets[index] ? EdgeInsets.all(8.0) : null,
                child: Image.asset(planets[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
