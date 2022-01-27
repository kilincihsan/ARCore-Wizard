import 'dart:math';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class RuntimeMaterials extends StatefulWidget {
  @override
  _RuntimeMaterialsState createState() => _RuntimeMaterialsState();
}

int chosenShape=0;
double chosenRadius=0.5;
double chosenHeight=0.5;
double opacity=1.0;
double scale=1.0;

class _RuntimeMaterialsState extends State<RuntimeMaterials> {
  ArCoreController arCoreController;
  ArCoreNode sphereNode;
  double metallic = 0.0;
  double roughness = 0.4;
  double reflectance = 0.5;
  Color color = Colors.yellow;

  void whenArCoreViewCreated(ArCoreController controller){
    arCoreController = controller;
    arCoreController.onNodeTap = (name) => removeObject(name);
    arCoreController.onPlaneTap = _handleOnPlaneTap;
    _addSphere(arCoreController);
  }

  //SPHERE
  Future _addNextSphere(ArCoreHitTestResult hit,double opacity,double scale) async{

    final mercuryMaterial = ArCoreMaterial(
      color: color.withOpacity(opacity),
    );

    final mercuryShape = ArCoreSphere(
      materials: [mercuryMaterial],
      radius:0.076,
    );

    sphereNode = ArCoreNode(
      scale: vector.Vector3(scale,scale,scale),
      shape: mercuryShape,
      position: hit.pose.translation + vector.Vector3(0.0,0.5,0.0),
      rotation: hit.pose.rotation,
    );

    arCoreController.addArCoreNode(sphereNode);
  }

  //cube
  Future _addNextCube(ArCoreHitTestResult hit,double opacity,double scale) async{
    final mercuryMaterial = ArCoreMaterial(
      color: color.withOpacity(opacity),
    );

    final mercuryShape = ArCoreCube(
      materials: [mercuryMaterial],
      size: vector.Vector3(0.15,0.15,0.15),
    );

    sphereNode = ArCoreNode(
      scale: vector.Vector3(scale,scale,scale),
      shape: mercuryShape,
      position: hit.pose.translation + vector.Vector3(0.0,0.5,0.0),
      rotation: hit.pose.rotation,
    );

    arCoreController.addArCoreNode(sphereNode);
  }

  //cylinder
  Future _addNextCylinder(ArCoreHitTestResult hit,double opacity,double scale) async{

    final mercuryMaterial = ArCoreMaterial(
      color: color.withOpacity(opacity),
    );

    final mercuryShape = ArCoreCylinder(
      materials: [mercuryMaterial],
      radius:0.08,height: 0.05,
    );

    sphereNode = ArCoreNode(
      scale: vector.Vector3(scale,scale,scale),
      shape: mercuryShape,
      position: hit.pose.translation + vector.Vector3(0.0,0.5,0),
      rotation: hit.pose.rotation,
    );

    arCoreController.addArCoreNode(sphereNode);
  }

  //add sphere
  void _addSphere(ArCoreController controller){
    final material = ArCoreMaterial(
      color: Colors.yellow,
    );
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.1,
    );

    sphereNode = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0,0,-1),
    );
    controller.addArCoreNode(sphereNode);
  }

  void _handleOnPlaneTap(List<ArCoreHitTestResult> hits){
    final hit = hits.first;

    switch(chosenShape) {
      case 0: {
        _addNextSphere(hit,opacity,scale);
      }
      break;
      case 1: {
        _addNextCube(hit,opacity,scale);
      }
      break;
      case 2: {
        _addNextCylinder(hit,opacity,scale);
      }
      break;
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


  onColorChange(Color newColor){
    if(newColor != this.color){
      this.color = newColor;
      updateMaterials();
    }
  }

  onMetallicChange(double newMetallic){
    if(newMetallic != this.metallic){
      metallic = newMetallic;
      updateMaterials();
    }
  }

  onRoughnessChange(double newRoughness){
    if(newRoughness != this.roughness){
      this.roughness= newRoughness;
      updateMaterials();
    }
  }

  onReflectanceChange(double newReflectance){
    if(newReflectance!=this.reflectance){
      this.reflectance = newReflectance;
      updateMaterials();
    }
  }

  updateMaterials(){
    debugPrint("updateMaterials");
    if(sphereNode == null){
      return;
    }
    debugPrint("updaterMaterials sphere not null");
    final material = ArCoreMaterial(
      color: color,
      metallic: metallic,
      roughness: roughness,
      reflectance:  reflectance,
    );
    sphereNode.shape.materials.value = [material];
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Runtime Change Materials'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          SphereControl(
            initialColor: color,
            initialMetallicValue: metallic,
            initialReflectanceValue: reflectance,
            initialRoughnessValue:  roughness,
            onColorChange: onColorChange,
            onMetalliChange: onMetallicChange,
            onRoughnessChange: onRoughnessChange,
            onReflectanceChange: onReflectanceChange,
          ),
          Expanded(
            child: ArCoreView(
              onArCoreViewCreated: whenArCoreViewCreated,
              enableTapRecognizer: true,
            ),
          ),
        ],
      ),
    );
  }
}


class SphereControl extends StatefulWidget {
  final double initialRoughnessValue;
  final double initialReflectanceValue;
  final double initialMetallicValue;
  final Color initialColor;
  final ValueChanged<Color> onColorChange;
  final ValueChanged<double> onMetalliChange;
  final ValueChanged<double> onRoughnessChange;
  final ValueChanged<double> onReflectanceChange;

  const SphereControl({
    Key key,
    this.initialRoughnessValue,
    this.initialReflectanceValue,
    this.initialMetallicValue,
    this.initialColor,
    this.onColorChange,
    this.onMetalliChange,
    this.onRoughnessChange,
    this.onReflectanceChange
  }) : super(key: key);

  @override
  _SphereControlState createState() => _SphereControlState();
}

class _SphereControlState extends State<SphereControl> {
  double metallicValue;
  double roughnessValue;
  double reflectanceValue;
  Color color;

  @override
  void initState() {
    roughnessValue = widget.initialRoughnessValue;
    reflectanceValue = widget.initialReflectanceValue;
    roughnessValue = widget.initialRoughnessValue;
    color = widget.initialColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          Row(
            children: <Widget>[
              Text("Opacity"),
              Expanded(
                  child: Slider(
                    value: opacity,
                    divisions: 10,
                    onChangeEnd: (value){
                      opacity = value;
                    },
                    onChanged: (double value){
                      setState(() {
                        opacity = value;
                      });
                    },
                  )
              ),
              Padding(padding:const EdgeInsets.only(left: 2.0)),
              Text("Scale"),
              Expanded(
                  child: Slider(
                    min: 0,
                    max: 5,
                    value: scale,
                    divisions: 10,
                    onChangeEnd: (value){
                      scale = value;
                    },
                    onChanged: (double value){
                      setState(() {
                        scale = value;
                      });
                    },
                  )
              ),
              Padding(padding: const EdgeInsets.only(left: 2.0),),
              Text("Metallic"),
              Checkbox(
                value: metallicValue==1.0,
                onChanged: (value){
                  metallicValue = value ? 1.0 : 0.0;
                  widget.onMetalliChange(metallicValue);
                },
              ),
            ],
          ),

          Row(
            children: <Widget>[
              Text("Roughness"),
              Expanded(
                  child:Slider(
                    value: roughnessValue,
                    divisions: 10,
                    onChangeEnd: (value){
                      roughnessValue=value;
                      widget.onRoughnessChange(roughnessValue);
                    },
                    onChanged: (double value){
                      setState(() {
                        roughnessValue = value;
                      });
                    },
                  )
              ),
              Padding(padding: const EdgeInsets.only(left: 6.0)),
              Text("Reflectance"),
              Expanded(
                  child: Slider(
                    value: reflectanceValue,
                    divisions: 10,
                    onChangeEnd: (value){
                      reflectanceValue = value;
                      widget.onReflectanceChange(reflectanceValue);
                    },
                    onChanged: (double value){
                      setState(() {
                        reflectanceValue=value;
                      });
                    },
                  )
              )
            ],
          ),

          Row(
            children: <Widget>[
              ElevatedButton(
                child: Text("Sphere"),
                onPressed: (){
                  chosenShape=0;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
              ),
              ElevatedButton(
                child: Text("Cube"),
                onPressed: (){
                  chosenShape=1;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
              ),
              ElevatedButton(
                child: Text("Cylinder"),
                onPressed: (){
                  chosenShape=2;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
              ),
              ElevatedButton(
                child: Text("Random Color"),
                onPressed: (){
                  final newColor = Colors.accents[Random().nextInt(14)];
                  widget.onColorChange(newColor);
                  setState(() {
                    color=newColor;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: CircleAvatar(
                  radius: 20.0,
                  backgroundColor: color,
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
