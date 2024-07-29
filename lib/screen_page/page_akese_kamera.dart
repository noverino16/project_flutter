import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class PageAksesKamera extends StatefulWidget {
  const PageAksesKamera({super.key});

  @override
  State<PageAksesKamera> createState() => _PageAksesKameraState();
}

class _PageAksesKameraState extends State<PageAksesKamera> {

  XFile? image;

  Future<void> imageCamera() async{
    var res = await ImagePicker().pickImage(source : ImageSource.camera);
    if(res != null){
     setState((){
       image= res;
     });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title : Text('Akses Kamera'),
        backgroundColor : Colors.green,
      ),
      body : Center(
        child : GestureDetector(
          onTap : () async{
            await imageCamera();
          },
          child : image != null ? Container(
            margin : const EdgeInsets.all(15),
            decoration : BoxDecoration(
              borderRadius : BorderRadius.circular(15),
              border : Border.all(width : 5, color : Colors.green),
            ),
            child : Image.file(File(image!.path))
          ) : const Icon(
            Icons.camera_alt_outlined,
            size : 50,
            color : Colors.green
          )
        )
    )
);
}
}