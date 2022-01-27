import 'dart:typed_data';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class CustomShapes extends StatefulWidget {


  @override
  _CustomShapesState createState() => _CustomShapesState();
}

class _CustomShapesState extends State<CustomShapes> {

  ArCoreController arCoreController;

  void whenArCoreViewCreated(ArCoreController controller){
    arCoreController = controller;
    arCoreController.onNodeTap = (name) => onTapHandler(name);
    arCoreController.onPlaneTap = _handleOnPlaneTap;
  }

  void onTapHandler(String name){
    print("Flutter: onNodeTap");
    showDialog(
        context: context,
        builder:(BuildContext context)=> AlertDialog(content: Text('onNodeTap on $name')),
    );
  }

  void _handleOnPlaneTap(List<ArCoreHitTestResult> hits){
    final hit = hits.first;
    _addSphere(hit);
  }

  Future _addSphere(ArCoreHitTestResult hit) async{
    final moonMaterial = ArCoreMaterial(color:Colors.grey);
    final moonShape = ArCoreSphere(
      materials: [moonMaterial],
      radius: 0.03,
    );
    final moon=ArCoreNode(
      shape: moonShape,
      position: vector.Vector3(0.2,0,0),
      rotation: vector.Vector4(0,0,0,0),
    );

    final ByteData textureBytes = await rootBundle.load('assets/earth.jpg');

    final earthMaterial = ArCoreMaterial(
      color: Color.fromARGB(120, 66, 134, 244),
      textureBytes: textureBytes.buffer.asUint8List(),
    );

    final earthShape = ArCoreSphere(
      materials: [earthMaterial],
      radius:0.1,
    );

    final earth = ArCoreNode(
      shape: earthShape,
      children: [moon],
      position: hit.pose.translation + vector.Vector3(0.0,1.0,0.0),
      rotation: hit.pose.rotation,
    );

    //bibliboy
    final bibliMaterial = ArCoreMaterial(
      color: Color.fromARGB(120, 66, 134, 244),
      textureBytes: textureBytes.buffer.asUint8List(),
    );

    final bibliShape = ArCoreSphere(
      materials: [bibliMaterial],
      radius:0.1,
    );

    final bibli = ArCoreRotatingNode(
      shape: bibliShape,
      degreesPerSecond: 30,
      position: hit.pose.translation + vector.Vector3(0.0,2.0,0.0),
      rotation: hit.pose.rotation,
    );

    arCoreController.addArCoreNodeWithAnchor(earth);
    arCoreController.addArCoreNode(bibli);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    arCoreController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(
          title: const Text("Space"),
          centerTitle: true,
        ),
        body: ArCoreView(
          onArCoreViewCreated: whenArCoreViewCreated,
          enableTapRecognizer: true,
        )
      )
    );
  }
}
