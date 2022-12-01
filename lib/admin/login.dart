import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sms_project/admin/admin_zone.dart';
import '../model/Env.dart';
import '../student/student_zone.dart';
import 'package:http/http.dart'as http;
class Adminlogin extends StatefulWidget {
  @override
  _AdminloginState createState() => _AdminloginState();
}

class _AdminloginState extends State<Adminlogin> {

  bool visible=true;
  final Formkey=GlobalKey<FormState>();
  final email=TextEditingController();
  final password=TextEditingController();
  Future adminLogin()async{
    setState(() {
      visible=true;
    });
    String mail=email.text;
    String pass=password.text;

    // SERVER LOGIN API URL
    //var url = 'http://192.168.31.45/sm_system/admin_login.php';

    // Store all data with Param Name.
    var data = {'Email':mail,'Password':pass};

    // Starting Web API Call.
    var response = await http.post(Uri.parse("${Env.URL_PREFIX}/admin_login.php"), body: json.encode(data));

    // Getting Server response into variable.
    var msg = jsonDecode(response.body);

    // If the Response Message is Matched.
    if(msg == 'Login Matched')
    {
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });
      Fluttertoast.showToast(msg: "Login Succefull");

      // Navigate to Profile Screen & Sending Email to Next Screen.

      Navigator.push(context, MaterialPageRoute(builder: (context)=>Adminzone(email: mail,)));
    }else{

      // If Email or Password did not Matched.
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });

      // Showing Alert Dialog with Response JSON Message.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(msg),
            actions: <Widget>[
              TextButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[400],
        body:Stack(
            children: [
              Container(
                margin: EdgeInsets.only(left: 130,top: 150),
                child: Icon(Icons.admin_panel_settings_outlined,size: 125),

              ),
              Container(
                padding: EdgeInsets.only(left: 70,top:300),
                child: Text('Welcome Back',style: GoogleFonts.raleway(fontSize: 40,fontWeight: FontWeight.bold,),),
              ),

              SingleChildScrollView(
                child: Form(
                 key: Formkey,
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.only(top: 400,left: 30,right: 30),
                       child: TextFormField(
                          controller: email,
                          validator: (emailval){
                            if(emailval!.isEmpty)
                              {
                                return'Email required';
                              }
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )
                          ),
                        ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 30,right: 30),
                        child:TextFormField(
                          controller: password,
                          validator: (passval){
                            if(passval!.isEmpty)
                            {
                              return'Password required';
                            }
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                          fillColor: Colors.white,
                              filled: true,
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )
                          ),
                        ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(onPressed:(){
                          if(Formkey.currentState!.validate()){
                                 adminLogin();

                              }

                              },
                         // padding: EdgeInsets.only(left: 100,right: 100,top: 15,bottom: 15),
                         //  shape: StadiumBorder(),
                          child: Text('Sign In',style: TextStyle(fontSize: 20),),
                          // color: Colors.yellowAccent,

                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
  
}