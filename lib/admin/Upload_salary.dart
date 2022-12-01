import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/Env.dart';
import '../student/student_zone.dart';
import 'package:http/http.dart'as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'manage_teacher_zone.dart';

class UploadSalary extends StatefulWidget {
  @override
  _UploadSalaryState createState() => _UploadSalaryState();
}

class _UploadSalaryState extends State<UploadSalary> {
  bool visible=false;
  String? SelectedName;
  List getTeacherList=[];
  String months='Select Month';
  var items=[
    'Select Month',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'Agust',
    'September',
    'October',
    'November',
    'December',
  ];
  // String subject='Kannada';
  // var sub=[
  //   'Kannada',
  //   'English',
  //   'Hindi',
  //   'Maths',
  //   'Science',
  //   'Social-Science',
  // ];
  final ScaffoldKey=GlobalKey<ScaffoldState>();
  final FormField=GlobalKey<FormState>();
  final amount=TextEditingController();
  void ClearText(){
    amount.clear();
  }
  // final taddress=TextEditingController();
  // final tnumber=TextEditingController();
  // final temail=TextEditingController();
  // final tDOB=TextEditingController();
  // final texp=TextEditingController();
  // final password=TextEditingController();
  // final tsubject=TextEditingController();


  Future getAllTeacherList() async {
    final url = '${Env.URL_PREFIX}/teacher_list.php';
    final response = await http.get(Uri.parse(url));
    final items = json.decode(response.body);

    setState(() {
      getTeacherList = items;
    });
    print(getTeacherList);
  }
  Future UploadSal() async{

    // Showing CircularProgressIndicator.
    setState(() {
      visible=true;
    });

    // Getting value from Controller
    String name = SelectedName.toString();
    String month = months.toString();
    String amounts=amount.text;
    // String mail=temail.text;
    // String sex=gender.toString();
    // String sub=subject.toString();
    // String dob=tDOB.text;
    // String exp=texp.text;
    // String pass=password.text;



    // SERVER LOGIN API URL
    //var url = 'http://192.168.31.45/sm_system/Upload_salary.php';
try {
  // Store all data with Param Name.
  var data = {'Name': name, 'Months': month, 'Amount': amounts};
  // Starting Web API Call.
  var response = await http.post(
      Uri.parse("${Env.URL_PREFIX}/Upload_salary.php"),
      body: json.encode(data));

  // Getting Server response into variable.
  var msg = jsonDecode(response.body);

  // If the Response Message is Matched.
  if (msg == 'Success') {
    // Hiding the CircularProgressIndicator.
    setState(() {
      visible = false;
    });
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Mteacherzone()));
              },
            ),
          ],
        );
      },
    );
  } else {
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
                ClearText();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}catch(e){
  Fluttertoast.showToast(msg: "Server Not Found");
}
  }

  @override
  void initState() {
    super.initState();
    getAllTeacherList();
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
            onTap: (){
              Navigator.pop(context,false);
  },
          ),


          title: Text('Upload Salary'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: FormField,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 35,right: 35),
                    child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          hintText: 'Name',
                          label: Text('Select Name'),
                          fillColor: Colors.black12,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        value:SelectedName,

                        items: getTeacherList.map((teacher){
                          return DropdownMenuItem(
                            value: teacher['teacher_name'],
                            child: Text(teacher['teacher_name']),);
                        }).toList(),
                        onChanged: (newValue){
                          setState(() {
                            SelectedName=newValue as String?;
                          });
                        }),
                  ),

                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.only(left: 35,right: 35),
                    child: DropdownButtonFormField(

                        decoration: InputDecoration(
                          hintText: 'Months',
                          label: Text('Select Months'),
                          fillColor: Colors.black12,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        value:months,

                        items: items.map((String items){
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),);
                        }).toList(),
                        onChanged: (String? newValue){
                          setState(() {
                            months=newValue!;
                          });
                        }),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.only(left: 35,right: 35),
                    child: TextFormField(controller: amount,
                      validator: (vamount){
                        if(vamount!.isEmpty)
                        {
                          return "Amount required.";
                        }
                      },
                      decoration: InputDecoration(
                        label: Text("Amount"),
                        hintText: 'Amount',
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
                          child: Text('Submit'),
                          onPressed: (){
                            if(FormField.currentState!.validate()){
                              UploadSal();
                            }
                            },
                            style: ElevatedButton.styleFrom(
                            primary:
                           Colors.blueAccent,
                            padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                            textStyle: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                          ),
                        ),
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

