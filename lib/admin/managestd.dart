import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms_project/admin/manage_student_zone.dart';
import 'package:sms_project/admin/view_student.dart';
import 'package:sms_project/main.dart';
import 'package:http/http.dart'as http;
import '../model/Env.dart';
import '../student/student_zone.dart';

class Mstudent extends StatefulWidget {
  @override
  _MstudentState createState() => _MstudentState();
}

class _MstudentState extends State<Mstudent> {
String gender='Male';
var items=[
  'Male',
  'Female',
];
  String standard='Class 5';
  var std=[
    'Class 5',
    'Class 6',
    'Class 7',
    'Class 8',
    'Class 9',
    'Class 10',
  ];
  final ScaffoldKey=GlobalKey<ScaffoldState>();
  final FormField=GlobalKey<FormState>();

  final sname=TextEditingController();
  final saddress=TextEditingController();
  final snumber=TextEditingController();
  final fname=TextEditingController();
  final mname=TextEditingController();
  final pnumber=TextEditingController();
  final semail=TextEditingController();
  final sDOB=TextEditingController();
  final sDOJ=TextEditingController();
  final password=TextEditingController();
  void ClearText(){
    sname.clear();
    saddress.clear();
    snumber.clear();
    fname.clear();
    mname.clear();
    pnumber.clear();
    semail.clear();
    sDOJ.clear();
    sDOB.clear();
    password.clear();
  }
  @override
  void dispose()
  {
    //clean up the controller when the widget is removed
    sDOB.dispose();
    super.dispose();
    sDOJ.dispose();
    super.dispose();
    sname.dispose();
    super.dispose();
  }
  // final sclass=TextEditingController();
  @override
  Widget build(BuildContext context) {
   return Container(
     decoration: BoxDecoration(
       gradient: LinearGradient(
         begin: Alignment.topLeft,
         end: Alignment.bottomRight,
         colors: [Colors.white60,Colors.white70],
       ),
     ),
     child: Scaffold(
       key:ScaffoldKey,
       backgroundColor: Colors.transparent,
       appBar: AppBar(
         leading:GestureDetector(
           child: Icon(Icons.arrow_back),
           onTap: ()=>Navigator.pop(context, false),
         ),
         centerTitle: true,
         backgroundColor: Colors.orange,
         title: Text('Manage Student'),
       ),
       body: Center(
         child: SingleChildScrollView(
           child: Form(
             key: FormField,
             child: Column(
               children: [
                 SizedBox(height: 20),
                 Container(
                   child: Text('Add Student',
                     style: TextStyle(fontSize: 30,
                         fontWeight: FontWeight.bold),
                     textAlign: TextAlign.center,
                   ),
                 ),
                 SizedBox(height: 20),
                 Container(
                   padding: EdgeInsets.only(left: 35,right: 35),
                   child: TextFormField(controller: sname,
                     validator: (snameval){
                       if(snameval!.isEmpty)
                       {
                         return "Name required.";
                       }
                     },
                     decoration: InputDecoration(
                       label: Text('Student Name'),
                       hintText: 'Student Name',
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
                   child: TextFormField(controller: saddress,
                     validator: (saddressval){
                       if(saddressval!.isEmpty)
                       {
                         return "Address requierd.";
                       }
                     },
                     decoration: InputDecoration(
                       label: Text('Student Address'),
                       hintText: 'Student Address',
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
                   child: TextFormField(controller: sDOB,
                     validator: (sDOBval)
                     {
                       if(sDOBval!.isEmpty)
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
                       sDOB.text=date.toString().substring(0,10);
                     },
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
                        value: gender,
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

                 SizedBox(height: 20),
                 Container(
                   padding: EdgeInsets.only(left: 35,right: 35),
                   child: TextFormField(controller: snumber,
                     validator: (snumberval){
                       if(snumberval!.isEmpty)
                       {
                         return "Number required.";
                       }
                     },
                     decoration: InputDecoration(
                       label: Text("Student Phone_no"),
                       hintText: 'Student Contact No',
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
                   child: TextFormField(controller: fname,
                     validator: (fnameval){
                       if(fnameval!.isEmpty)
                       {
                         return "Father name required.";
                       }
                     },
                     decoration: InputDecoration(
                       label: Text('Student Father_name'),
                       hintText: 'Father Name',
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
                   child: TextFormField(controller: mname,
                     validator: (mnameval){
                       if(mnameval!.isEmpty)
                       {
                         return "Mother name required.";
                       }
                     },
                     decoration: InputDecoration(
                       label: Text('Student Mother_name'),
                       hintText: 'Mother Name',
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
                   child: TextFormField(controller: pnumber,
                     validator: (pnumberval){
                       if(pnumberval!.isEmpty)
                       {
                         return "Parent numuber required.";
                       }
                     },
                     decoration: InputDecoration(
                       label: Text('Parents Phone_no'),
                       hintText: 'Parents Contact No',
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
                   child: TextFormField(controller: semail,
                     validator: (semailval)
                     {
                       if(semailval!.isEmpty)
                       {
                         return "Email required.";
                       }
                     },
                     decoration: InputDecoration(
                       label: Text('Student Email'),
                       hintText: 'Student Email-id',
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
                   padding: EdgeInsets.only(left: 35,right:35),
                   child: TextFormField( controller: sDOJ,
                     readOnly: true,
                     validator: (sDOJval){
                          if(sDOJval!.isEmpty)
                            {
                              return "DOJ is required";
                            }
                     },
                     decoration: InputDecoration(
                       label: Text('Joining Date'),
                       hintText: "Select Joining date",
                       fillColor: Colors.black12,
                       filled: true,
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(10),
                       ),
                     ),
                     onTap: ()async{
                       DateTime date=DateTime.now();
                       sDOJ.text=date.toString().substring(0,10);
                     },
                   ),
                 ),
                 SizedBox(height: 20),
                 Container(
                   padding: EdgeInsets.only(left: 35,right: 35),
                   child: DropdownButtonFormField(

                       decoration: InputDecoration(
                         hintText: 'Class',
                         label: Text('Select Class'),
                         fillColor: Colors.black12,
                         filled: true,
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(10),
                         ),
                       ),
                       value: standard,
                       items: std.map((String std){
                         return DropdownMenuItem(
                           value: std,
                           child: Text(std),);
                       }).toList(),
                       onChanged: (String? newValue){
                         setState(() {
                           standard=newValue!;
                         });
                       }),
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
                       hintText: 'Student Password',
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
                   child:Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.spaceAround,

                     children: [
                       ElevatedButton(
                         child: Text('Add'),
                         onPressed: ()async{
                           if(FormField.currentState!.validate()){

                           //final  String BASE_URL='http://192.168.31.45/sm_system/api.php';
                          final newUser=Map<String,String>();
                              newUser["Sname"]=sname.text;
                              newUser["Saddress"]=saddress.text;
                              newUser["Sdob"]=sDOB.text;
                              newUser["Sgender"]=gender.toString();
                              newUser["Snumber"]=snumber.text;
                              newUser["Fname"]=fname.text;
                              newUser["Mname"]=mname.text;
                              newUser["Pnumber"]=pnumber.text;
                              newUser["Smail"]=semail.text;
                              newUser["Sdoj"]=sDOJ.text;
                              newUser["Standard"]=standard.toString();
                              newUser["Password"]=password.text;
                              newUser["command"]="NEW_USER_REGISTRATION";
                           final response= await http.post(Uri.parse("${Env.URL_PREFIX}/api.php"),body:newUser);
                           if(response.statusCode==200)
                           {

                            // print(response.body);
                             showDialog(
                               context: context,
                               builder: (BuildContext context) {
                                 return AlertDialog(
                                   title: new Text("Upload Successful!!"),
                                   actions: <Widget>[
                                     TextButton(
                                       child: new Text("OK"),
                                       onPressed: () {
                                         ClearText();
                                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Mstudentzone()));
                                       },
                                     ),
                                   ],
                                 );
                               },
                             );
                             //Fluttertoast.showToast(msg:  'Registered Successfully');


                           }else{
                             AlertDialog(
                               content: Text('Server Not Found'),
                               actions: <Widget>[
                                 ElevatedButton(
                                   child: Icon(Icons.check_box_sharp),
                                   // color: Colors.blue,
                                   onPressed: () =>Mstudent(),

                                   // textColor: Colors.white,
                                 ),
                               ],
                             );
                           }
                           }
                         },
                         style: ElevatedButton.styleFrom(
                           primary: Colors.blueAccent,
                           padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                           textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                         ),
                       ),
                       // SizedBox(height: 30,),
                       //
                       // ElevatedButton(
                       //   child: Text('View'),
                       //   onPressed: (){
                       //     FormField.currentState!.validate();
                       //     Navigator.push(
                       //         context,
                       //         MaterialPageRoute(builder: (context)=>Viewstudent()));
                       //   },
                       //   style: ElevatedButton.styleFrom(
                       //     primary: Colors.blueAccent,
                       //     padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                       //     textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                       //   ),
                       // ),
                       SizedBox(height: 30,),
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
    // TODO: implement build
    throw UnimplementedError();
  }

}

