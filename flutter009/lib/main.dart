import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import'../PicturePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        home: Scaffold(
          body: Login(),
        )
    );
  }
}
class Login extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  var _user= new TextEditingController();
  var _password=new TextEditingController();
  var result;
  static BaseOptions putOptions =BaseOptions(
      connectTimeout: 15000,
      baseUrl: '',
      responseType:ResponseType.plain,
      receiveTimeout: 15000,
      headers:null,
      contentType: "application/json"
  );

  Future postRequestFunction() async {
    Dio dio = new Dio(putOptions);
    Map<String,dynamic> formData={"id": _user.text, "pwd": _password.text,"token":"SOSD"};
    String url ="http://59.77.134.5:4999/";
    Response response = await dio.post(url, data: formData);
    result=jsonDecode(response.data);
    print(result);

  }
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:
      Stack(
        children: [
          Positioned(
            child: Image.asset(
              'images/e.png',
              fit: BoxFit.cover,
            ),
            top: 0,
            left: 0,
            right: 0,
            bottom: 20,
          ),
          Positioned(
            child: Container(
              child: Column(
                children: [
                  SizedBox(height:20),
                  Container(
                    child:TextField(

                      decoration:InputDecoration(
                        icon:Icon(Icons.people),
                        border: OutlineInputBorder(),
                        labelText: "用户名",
                      ),
                      onChanged: (value){
                        _user.text=value;
                      },

                    ),
                    height:50,
                    width:330,
                  ),
                  SizedBox(height:20),
                  Container(
                    child:TextField(
                        obscureText: true,
                        decoration:InputDecoration(
                          icon:Icon(Icons.home),
                          border: OutlineInputBorder(),
                          labelText: "密码",
                        ),
                        onChanged: (v){
                          _password.text= v;
                        }
                    ),
                    height:50,
                    width:330,
                  ),

                  SizedBox(height:20),
                  Container(
                    child:RaisedButton(
                        child:Text('登录'),
                        textColor:Colors.redAccent,
                        onPressed: () async {
                         await postRequestFunction();
                          if(result['message']=='登陆成功'){
                            print('123');
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => PicturePage()
                              ),
                            );
                            setState(() {
                            });
                          }
                        }


                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            '注册账号',
                            style: TextStyle(
                                fontSize: 13.0,
                                color: Color.fromARGB(255, 53, 53, 53)
                            ),
                          ),

                        ),
                        Container(
                          child:Text(
                            '忘记密码？',
                            style: TextStyle(
                                fontSize: 13.0,
                                color: Color.fromARGB(255, 53, 53, 53)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40))),
              height: 48.0,
              alignment: Alignment.center,

            ),
            top: 200,
            left: 0,
            right: 0,
            bottom: 0,
          ),
        ],

      ),
    );

  }


}


