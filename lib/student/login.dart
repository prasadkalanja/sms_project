import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sms_project/student/student_profile.dart';
import '../model/Env.dart';
import '../model/student.dart';
import '../student/student_zone.dart';
import 'package:http/http.dart'as http;

class StudentLogin extends StatefulWidget {
  @override
  _StudentLoginState createState() => _StudentLoginState();
}
class _StudentLoginState extends State<StudentLogin> {
   bool visible=true;
  final Scaffoldkey=GlobalKey<ScaffoldState>();
  final name=TextEditingController();
  final password=TextEditingController();
  final FormKey=GlobalKey<FormState>();
  Future studentLogin()async{
    setState(() {
      visible=true;
    });
    String Name=name.text;
    String pass=password.text;

    // SERVER LOGIN API URL
    var url = 'http://192.168.31.45/sm_system/student_login.php';

    // Store all data with Param Name.
    var data = {'Username':Name,'Password':pass};

    // Starting Web API Call.
    var response = await http.post(Uri.parse("${Env.URL_PREFIX}/student_login.php"), body: json.encode(data));

    // Getting Server response into variable.
    var msg = jsonDecode(response.body);

    // If the Response Message is Matched.
    if(msg == 'Login Matched')
    {
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Login Successful"),
            actions: <Widget>[
              TextButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Studentzone(name: Name,)));
                },
              ),
            ],
          );
        },
      );

      // Navigate to Profile Screen & Sending Email to Next Screen.


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
            title: new Text("Error"),
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
      backgroundColor: Colors.cyan[400],
      body:Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 130,top: 150),
            child: Icon(Icons.school_outlined,size: 125),

          ),
          Container(
            padding: EdgeInsets.only(left: 70,top:300),
            child: Text('Welcome Back',style: GoogleFonts.raleway(fontSize: 40,fontWeight: FontWeight.bold,),),
          ),

          SingleChildScrollView(
            child: Form(
              key: FormKey,
              child: Center(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 400,left: 30,right: 30),
                      child: TextFormField(
                        controller: name,
                        validator: (emailval){
                          if(emailval!.isEmpty)
                          {
                            return'Username required';
                          }
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Username',
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
                      if(FormKey.currentState!.validate()){
                        studentLogin();

                      }

                    },
                      // padding: EdgeInsets.only(left: 100,right: 100,top: 15,bottom: 15),
                      // shape: StadiumBorder(),
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