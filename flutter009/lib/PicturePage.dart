import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PicturePage extends StatefulWidget{
  PicturePage({Key?key}) : super(key: key);
  _PicturePageState createState() => _PicturePageState();

}
class _PicturePageState extends State<PicturePage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(750, 1334),
        builder: () => MaterialApp(
          home: picture(),
        ));
  }
}
class picture extends StatefulWidget {
  @override
  _pictureState createState() => _pictureState();
}

class _pictureState extends State<picture> {
  List imagePathList = [];
  List imagename = [];
  String name = '';
  List<Widget> getImageList() {
    List<Widget> list = [];
    for (var i = 0; i < imagePathList.length; i++) {
      list.add(_ImageView(imagePathList[i], imagename[i], i));
    }

    return list;
  }

  Future getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      imagePathList.add(File(image!.path));
    });
  }


  Widget _ImageView(imageUrl, name, index) {
    return Hero(
            tag: name,
            child: Stack(
              children: [
                Container(
                    padding: EdgeInsets.all(3),
                    alignment: Alignment.centerLeft,
                    height: 220.w,
                    width: 140.w,
                    margin: EdgeInsets.only(
                      left: 60.w,
                      bottom: 341.h,
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              imageUrl,
                              height: 140.w,
                              width: 140.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(name)
                        ])),
                Positioned(
                    right: 0,
                    top: 0,
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            imagePathList.remove(imageUrl);
                          });
                        },
                        child: Image.asset(
                          "images/delete2.png",
                          height: 34.w,
                          width: 34.w,
                          fit: BoxFit.cover,
                        )))
              ],
            ));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('图片'),
        ),
        body: Center(
            child: Column(
              children: [
                Container(
                    color:Colors.black,
                    padding:EdgeInsets.only(top:0.0,bottom:40.0),
                    child:Container(
                      child:Image.asset("images/logo.png"),
                      width:1500.0,
                      height:200.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    )
                ),

                Container(
                  margin: EdgeInsets.only(left: 20),
                  height: 40,
                  width: 100,
                  alignment: Alignment.center,
                  child: TextField(
                      onChanged: (str) {
                        setState(() {
                          name = str;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: '先命名再上传',
                        hintMaxLines: 2,
                        contentPadding: EdgeInsets.only(left: 20),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    if (name == '' || name == null) {
                      return;
                    }
                    imagename.add(name);
                    getImage();
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 15),
                    height: 40,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(
                      '上传图片',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  child: Row(
                    children: getImageList(),
                  ),
                )
              ],
            )));
  }
}



