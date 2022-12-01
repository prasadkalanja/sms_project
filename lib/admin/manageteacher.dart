import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sms_project/admin/admin_zone.dart';
import 'package:sms_project/admin/manage_teacher_zone.dart';
import 'package:sms_project/admin/view_teacher.dart';
import '../model/Env.dart';
import '../student/student_zone.dart';
import 'package:http/http.dart'as http;
import 'package:fluttertoast/fluttertoast.dart';

class Mteacher extends StatefulWidget {
  @override
  _MteacherState createState() => _MteacherState();
}

class _MteacherState extends State<Mteacher> {
  bool visible=false;

  String gender='Male';
  var items=[
    'Male',
    'Female',
  ];
  String subject='Kannada';
  var sub=[
    'Kannada',
    'English',
    'Hindi',
    'Maths',
    'Science',
    'Social-Science',
  ];
  final ScaffoldKey=GlobalKey<ScaffoldState>();
  final FormField=GlobalKey<FormState>();
  final tname=TextEditingController();
  final taddress=TextEditingController();
  final tnumber=TextEditingController();
  final temail=TextEditingController();
  final tDOB=TextEditingController();
  final texp=TextEditingController();
  final password=TextEditingController();
  void ClearText(){
    tname.clear();
    taddress.clear();
    tnumber.clear();
    temail.clear();
    tDOB.clear();
    texp.clear();
    password.clear();
  }
  // final tsubject=TextEditingController();
  Future teacherReg() async{

    // Showing CircularProgressIndicator.
    setState(() {
      visible=true;
    });

    // Getting value from Controller
    String name = tname.text;
    String address = taddress.text;
    String number=tnumber.text;
    String mail=temail.text;
    String sex=gender.toString();
    String sub=subject.toString();
    String dob=tDOB.text;
    String exp=texp.text;
    String pass=password.text;

    // SERVER LOGIN API URL
   // var url = 'http://192.168.31.45/sm_system/teacher_register.php';

    // Store all data with Param Name.
    var data = {'Name':name,'Address':address,'Number':number,'Mail':mail,'Gender':sex,'Subject':sub,'Dob':dob,'Exp':exp,'Password':pass};
     if(data.isEmpty)
       {
         return 'Data is Requierd';
       }

       // Starting Web API Call.
       var response = await http.post(Uri.parse("${Env.URL_PREFIX}/teacher_register.php"), body: json.encode(data));

       // Getting Server response into variable.
       var msg = jsonDecode(response.body);

    // If the Response Message is Matched.
    if(msg == 'Register Success')
    {
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(msg),
            actions: <Widget>[
              TextButton(
                child: new Text("OK"),
                onPressed: () {
                  ClearText();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Mteacherzone()));
                },
              ),
            ],
          );
        },
      );


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
            title: new Text("Duplicate Entry"),
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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.orange,Colors.purpleAccent],
        ),
      ),
      child: Scaffold(
        key:ScaffoldKey,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: ()=>Navigator.pop(context, false),
          ),
          title: Text('Manage Teachers'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: FormField,
              child: Column(
                children: [
                  Container(
                    child: Text('Add Teacher',
                      style: TextStyle(fontSize: 30,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.only(left: 35,right: 35),
                    child: TextFormField(controller: tname,
                      validator: (snameval){
                        if(snameval!.isEmpty)
                        {
                          return "Name required.";
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Teacher Name',
                        fillColor: Colors.black12,
                        filled: true,

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.only(left: 35,right: 35),
                    child: TextFormField(controller: taddress,
                      validator: (saddressval){
                        if(saddressval!.isEmpty)
                        {
                          return "Address requierd.";
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Teacher Address',
                        fillColor: Colors.black12,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.only(left: 35,right: 35),
                    child: DropdownButtonFormField(

                        decoration: InputDecoration(
                          hintText: 'Gender',
                          label: Text('Select Gender'),
                          fillColor: Colors.black12,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        value:gender,

                        items: items.map((String items){
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),);
                        }).toList(),
                        onChanged: (String? newValue){
                          setState(() {
                            gender=newValue!;
                          });
                        }),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.only(left: 35,right: 35),
                    child: TextFormField(controller: tDOB,
                      validator: (tDOBval)
                      {
                        if(tDOBval!.isEmpty)
                        {
                          return "DOB requierd.";
                        }

                      },

                      decoration: InputDecoration(
                        hintText: 'DOB',
                        label: Text('Date of Birth'),
                        fillColor: Colors.black12,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onTap: ()async{
                        DateTime? date =DateTime(1900);
                        FocusScope.of(context).requestFocus(new FocusNode());

                        date= await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        tDOB.text=date.toString().substring(0,10);
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.only(left: 35,right: 35),
                    child: TextFormField(controller: tnumber,
                      validator: (snumberval){
                        if(snumberval!.isEmpty)
                        {
                          return "Number required.";
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Teacher Contact No',
                        fillColor: Colors.black12,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.only(left: 35,right: 35),
                    child: TextFormField(controller: temail,
                      validator: (semailval)
                      {
                        if(semailval!.isEmpty)
                        {
                          return "Email required.";
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Teacher Email-id',
                        fillColor: Colors.black12,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.only(left: 35,right: 35),
                    child: DropdownButtonFormField(

                        decoration: InputDecoration(
                          hintText: 'Subject',
                          label: Text('Select Subject'),
                          fillColor: Colors.black12,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        value: subject,

                        items:sub.map((String sub){
                          return DropdownMenuItem(
                            value: sub,
                            child: Text(sub),);
                        }).toList(),
                        onChanged: (String? newValue){
                          setState(() {
                            subject=newValue!;
                          });
                        }),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.only(left: 35,right: 35),
                    child: TextFormField(controller: texp,
                      validator: (texpval){
                        if(texpval!.isEmpty)
                        {
                          return "Experience required.";
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Experience ',
                        fillColor: Colors.black12,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.only(left: 35,right: 35),
                    child: TextFormField(controller: password,
                      validator: (passval){
                        if(passval!.isEmpty)
                        {
                          return "Password required.";
                        }
                      },
                      decoration: InputDecoration(
                        label: Text("Password"),
                        hintText: 'Teacher Password',
                        fillColor: Colors.black12,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: Column(
                      children: [
                        ElevatedButton(
                          child: Text('Add'),
                          onPressed:teacherReg,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent,
                            padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                            textStyle: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 30,),
                        // ElevatedButton(
                        //   child: Text('View'),
                        //   onPressed: (){
                        //     Navigator.push(context, MaterialPageRoute(builder: (context)=>Viewteacher()));
                        //   },
                        //   style: ElevatedButton.styleFrom(
                        //     primary: Colors.blueAccent,
                        //     padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                        //     textStyle: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

