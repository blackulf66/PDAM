import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

Future<void> main() async {
  runApp(ScreenCamera());
}

class ScreenCamera extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CameraDescription>? cameras; 
  CameraController? controller; 
  XFile? image;

  @override
  void initState() {
    loadCamera();
    super.initState();
  }

  loadCamera() async {
      cameras = await availableCameras();
      if(cameras != null){
        controller = CameraController(cameras![0], ResolutionPreset.max);
                    //cameras[0] = first camera, change to 1 to another camera
                    
        controller!.initialize().then((_) {
            if (!mounted) {
              return;
            }
            setState(() {});
        });
      }else{
        print("NO any camera found");
      }
  }

  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
          appBar: AppBar( 
              title: Text("haz una foto"),
              backgroundColor: Style.VKNGGron,
          ),
          body: Container( 
            child: Column(
              children:[
                  Container(
                      height:300,
                      width:400,
                      child: controller == null?
                          Center(child:Text("Loading Camera...")):
                                !controller!.value.isInitialized?
                                  Center(
                                    child: CircularProgressIndicator(),
                                  ):
                                  CameraPreview(controller!)
                  ),

                  ElevatedButton.icon( 
                    onPressed: () async{
                        try {
                          if(controller != null){ 
                              if(controller!.value.isInitialized){
                                  image = await controller!.takePicture();
                                  setState(() {
                                
                                  });
                              }
                          }
                        } catch (e) {
                            print(e);
                        }
                    },
                    icon: Icon(Icons.camera),
                    label: Text("toma la foto"),
                  ),

                  Container( 
                     padding: EdgeInsets.all(30),
                     child: image == null?
                           Text("No image captured"):
                           Image.file(File(image!.path), height: 300,), 
                           
                  )
              ]
            )
          ),
           
       );
  }
}