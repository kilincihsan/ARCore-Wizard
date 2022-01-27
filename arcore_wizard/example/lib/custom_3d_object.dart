import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;


//stful
class Object3DScreen extends StatefulWidget {

  @override
  _Object3DScreenState createState() => _Object3DScreenState();
}

class _Object3DScreenState extends State<Object3DScreen> {
  ArCoreController arCoreController;
  String objectSelected;

  void whenArCoreViewCreated(ArCoreController controller){
    arCoreController = controller;
    //when user click on 3d object
    arCoreController.onNodeTap = (name) => removeObject(name);
    //when user click on plane
    arCoreController.onPlaneTap = handleOnPlaneTap;
  }

  void handleOnPlaneTap(List<ArCoreHitTestResult> hits){
    final hit = hits.first;
    addObject(hit);
  }

  //we will execute this code when an object is selected
  void addObject(ArCoreHitTestResult plane){
    if(objectSelected != null){
      final objectNode = ArCoreReferenceNode(
        name: objectSelected,
        object3DFileName: objectSelected,
        position: plane.pose.translation,
        rotation: plane.pose.rotation,
        scale: vector.Vector3(0.5,0.5,0.5),
      );
      arCoreController.addArCoreNodeWithAnchor(objectNode);
    }
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    arCoreController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("3D Object"),
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
  List<String> gifs = [
    "assets/TocoToucan.gif",
    "assets/AndroidRobot.gif",
    "assets/ArcticFox.gif",
  ];

  List<String> objectFileName = [
    "toucan.sfb",
    "andy.sfb",
    "artic_fox.sfb",
  ];

  String selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.builder(
        itemCount: gifs.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index){
          return GestureDetector(
            onTap: (){
              setState(() {
                selected = gifs[index];
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
                color: selected == gifs[index] ? Colors.red : Colors.transparent,
                padding: selected == gifs[index] ? EdgeInsets.all(8.0) : null,
                child: Image.asset(gifs[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
