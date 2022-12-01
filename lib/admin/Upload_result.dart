import 'dart:convert';
// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:sms_project/first.dart';
//import 'package:sms_project/student/result.dart';
import '../model/Env.dart';
import '../model/student.dart';
import 'manage_student_zone.dart';

class UploadResult extends StatefulWidget {
  @override
  _UploadResultState createState() => _UploadResultState();
}

class _UploadResultState extends State<UploadResult> {
 final FormField=GlobalKey<FormState>();
  final studentListKey=GlobalKey<_UploadResultState>();
  final marks=TextEditingController();
  final percentage=TextEditingController();
  // final mark3=TextEditingController();
  // final mark4=TextEditingController();
  // final mark5=TextEditingController();
  // final mark6=TextEditingController();
  final total=TextEditingController();
  bool visible=false;
  String SelectExam='Select Exam';
  var Exam=[
    'Select Exam',
        'Semester 1',
        'Semester 2',
        'Internal 1',
            'Internal 2',
            'Internal 3',
            'Internal 4',
  ];
  // String SelectSubject="Select Subjects";
  // var Subject=[
  //   'Select Subjects',
  //   'Kannada',
  //   'English',
  //   'Hindi',
  //   'Maths',
  //   'Science',
  //   'Social-Science',
  // ];
 String SelectResult="Select Result";
 var result=[
   'Select Result',
   'Pass',
   'fail',
 ];

 String? SelectedName;
 List getStudentList=[];

  Future getAllStudentList() async {
    final url = 'http://192.168.31.45/sm_system/List.php';
    final response = await http.get(Uri.parse(url));
    final items = json.decode(response.body);

    setState(() {
      getStudentList = items;
    });
    print(getStudentList);
  }

  Future UploadResult() async{

    // Showing CircularProgressIndicator.
    setState(() {
      visible=true;
    });

    // Getting value from Controller
    String mark = marks.text;
    String percent= percentage.text;
    String tot=total.text;

    String name=SelectedName.toString();
    String result=SelectResult.toString();
    String exam=SelectExam.toString();
    // String dob=tDOB.text;
    // String exp=texp.text;
    // String pass=password.text;

    // SERVER LOGIN API URL
    //var url = 'http://192.168.31.45/sm_system/Upload_result.php';

    // Store all data with Param Name.
    var data = {'Name':name,'Exam':exam,'Marks':mark,'Total':tot,'Percentage':percent,'Result':result};
    // Starting Web API Call.
    var response = await http.post(Uri.parse("${Env.URL_PREFIX}/Upload_result.php"), body: json.encode(data));

    // Getting Server response into variable.
    var msg = jsonDecode(response.body);

    // If the Response Message is Matched.
    if(msg == 'Upload Success')
    {
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Upload Successful!!'),
            actions: <Widget>[
              TextButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Mstudentzone()));
                },
              ),
            ],
          );
        },
      );
     // Fluttertoast.showToast(msg: "Upload Succefull");

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
            title: new Text('Duplicate Entry'),
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
  void initState() {
    super.initState();
    getAllStudentList();
  }

  @override
  Widget build(BuildContext context) {
    // var name;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          leading: InkWell(
            onTap: ()=>Navigator.pop(context, false),
            child: Icon(Icons.arrow_back, size: 30,),
          ),
          title: Text(
            'UPLOAD RESULT',
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xff002c51),
        ),
      ),
      body:Center(
        child: SingleChildScrollView(
          child:
              Form(
               key: FormField,
                child: Column(
                  children: [
                  Container(
                    padding: EdgeInsets.only(left: 35,right: 35),
                    child: DropdownButton(
                        borderRadius: BorderRadius. circular( 10),
                        hint: Text("Select Name"),
                        isExpanded: true,
                        value: SelectedName,
                        items: getStudentList.map((student){
                          return DropdownMenuItem(
                              value: student['student_name'],
                              child: Text(student['student_name']));
                        }).toList(),
                        onChanged: (value){
                          setState(() {
                            SelectedName=value as String?;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 35,right: 35),
                    child: DropdownButtonFormField(

                        decoration: InputDecoration(
                          hintText: 'Exam',
                          label: Text('Select Exam'),
                          fillColor: Colors.black12,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        value:SelectExam,

                        items: Exam.map((String Exam){
                          return DropdownMenuItem(
                            value: Exam,
                            child: Text(Exam),);
                        }).toList(),
                        onChanged: (String? newValue){
                          setState(() {
                            SelectExam=newValue!;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 35,right: 35),
                    child: TextFormField(controller: marks,
                      validator: (vmarks){
                        if(vmarks!.isEmpty){
                          return 'Obtained Marks requierd';
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.black12,
                        filled: true,
                        label: Text('Enter Obtained Marks'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10) ,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 35,right: 35),
                    child: TextFormField(controller: total,
                      validator: (vtotal){
                        if(vtotal!.isEmpty){
                          return 'total requierd';
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.black12,
                        filled: true,
                        label: Text('Enter total Marks'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10) ,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 35,right: 35),
                    child: TextFormField(controller: percentage,
                      validator: (vper){
                        if(vper!.isEmpty){
                          return 'percentage requierd';
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.black12,
                        filled: true,
                        label: Text('Enter percentage'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10) ,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 35,right: 35),
                    child: DropdownButtonFormField(

                        decoration: InputDecoration(
                          hintText: 'Result',
                          label: Text('Select Result'),
                          fillColor: Colors.black12,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        value:SelectResult,

                        items: result.map((String result){
                          return DropdownMenuItem(
                            value: result,
                            child: Text(result),);
                        }).toList(),
                        onChanged: (String? newValue){
                          setState(() {
                            SelectResult=newValue!;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: ElevatedButton(
                      child: Text('Submit',style: TextStyle(fontSize: 10),),
                      onPressed:(){
                        if(FormField.currentState!.validate()){
                          UploadResult();
                        }
                      },

                    ),
                  ),
                ],),

              ),
            ),
      ),

    );
  }
}
