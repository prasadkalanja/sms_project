import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:sms_project/admin/manage_student_zone.dart';

import '../model/Env.dart';
class UploadFees extends StatefulWidget {
  @override
  _UploadFeesState createState() => _UploadFeesState();
}

class _UploadFeesState extends State<UploadFees> {
  final ScaffoldKey=GlobalKey<ScaffoldState>();
  final FormKey=GlobalKey<FormState>();
  final totfees=TextEditingController();
  final paidfees=TextEditingController();
  final refees=TextEditingController();
  bool visible=false;
  String? SelectedName;
  List getStudentList=[];
 var remain;
  void validate(){
    if(FormKey.currentState!.validate()){}

  }

  Future getAllStudentList() async {
    final url = 'http://192.168.31.45/sm_system/List.php';
    final response = await http.get(Uri.parse(url));
    final items = json.decode(response.body);

    setState(() {
      getStudentList = items;
    });
    print(getStudentList);
  }
  Future UploadFees() async{

    // Showing CircularProgressIndicator.
    setState(() {
      visible=true;
    });

    // Getting value from Controller
    String totalfee = totfees.text;
    String paidfee= paidfees.text;
    String refee=refees.text;
    String name=SelectedName.toString();
    // String result=SelectResult.toString();
    // String exam=SelectExam.toString();
    // String dob=tDOB.text;
    // String exp=texp.text;
    // String pass=password.text;

    // SERVER LOGIN API URL
   // var url = 'http://192.168.31.45/sm_system/Upload_fees.php';

    // Store all data with Param Name.
    var data = {'Name':name,'Totalfees':totalfee,'Paidfees':paidfee,'Refees':refee};
    // Starting Web API Call.
    var response = await http.post(Uri.parse("${Env.URL_PREFIX}/Upload_fees.php"),
        body: json.encode(data));

    // Getting Server response into variable.
    var msg = jsonDecode(response.body);
    print(msg);

    // If the Response Message is Matched.
    if(msg == 'Success')
    {


      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Upload Successful'),
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
    }else
      {
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
    return Scaffold(
      key: ScaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          leading: InkWell(
            onTap: ()=>Navigator.pop(context, false),
            child: Icon(Icons.arrow_back, size: 30,),
          ),
          title: Text(
            'UPLOAD FEES',
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xff002c51),
        ),
      ),
      body: Center(
        child:Form(
          key: FormKey,
        child: SingleChildScrollView(
              child:Column(
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
                    child: TextFormField(controller: totfees,
                      validator: (vtotfees){
                        if(vtotfees!.isEmpty){
                          return 'total fees requierd';
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.black12,
                        filled: true,
                        label: Text('Enter total Fees'),
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
                    child: TextFormField(controller: paidfees,
                      validator: (vpaidfee){
                        if(vpaidfee!.isEmpty){
                          return 'Paid Fees requierd';
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.black12,
                        filled: true,
                        label: Text('Enter paid fees'),
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
                    child: TextFormField(controller: refees,
                      // onTap: (){
                      //     //final res=int.parse(totfees.text)-int.parse(paidfees.text);
                      //       // refees!=res.toString();
                      // },
                      validator: (vrefees){
                        if(vrefees!.isEmpty){
                          return 'Remaing Fees requierd';
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.black12,
                        filled: true,
                        hintText: remain.toString(),
                        // label: Text('Enter Remaining Fees Marks'),
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
                    child: ElevatedButton(
                      child: Text('Submit',style: TextStyle(fontSize: 10),),
                      onPressed: () {
                        if(FormKey.currentState!.validate()){
                          UploadFees();
                        }

                        // FormField.currentState!.validate();
                      },
    ),
    ),
    ],
    ),

          ),
        ),
        ),
    );
  }
  void calculation(){
    setState(() {
      remain=int.parse(totfees.text)-int.parse(paidfees.text);
    });
    print(remain);
  }
}
