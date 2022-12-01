import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'admin/login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  @override
  Widget build(BuildContext context) {
return Container(
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/register.png'),
      fit: BoxFit.cover,
    ),
  ),
  child: Scaffold(
    backgroundColor: Colors.transparent,
    body: Stack(
      children: [
        Container(
          padding: EdgeInsets.only(left: 30, top:50,right: 30),
          child: Text('Register',
            style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.3,left: 35,right: 35),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      fillColor:Colors.black12,
                      filled: true,
                      hintText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      fillColor:Colors.black12,
                      filled: true,
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      fillColor:Colors.black12,
                      filled: true,
                      hintText: 'Contact',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      fillColor:Colors.black12,
                      filled: true,
                      hintText: 'Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor:Colors.black12,
                      filled: true,
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(onPressed: (){},
                    // padding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
                    // color: Colors.amber,
                  child: Text('Sign Up',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(onPressed: (){
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
                  },
                      child:Text('Already Have Account',style: TextStyle(fontSize: 20,
                          color: Colors.black,
                          decoration: TextDecoration.underline),
                      ),
                  ),
                ],
              ),
          ),
        ),
      ],
    ),
  ),
);

    // TODO: implement build
    throw UnimplementedError();
  }

}