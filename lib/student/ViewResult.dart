import 'dart:convert';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms_project/student/result_detail.dart';
import 'package:sms_project/student/student_zone.dart';

import '../model/Env.dart';
import '../model/Result.dart';

class View_Result extends StatefulWidget {
  final String name;
  View_Result({ required this.name});
  @override
  _View_ResultState createState() => _View_ResultState();
}

class _View_ResultState extends State<View_Result> {
  final ScaffoldKey=GlobalKey<_View_ResultState>();
  var exam;
  String? name;
  late Future<List<Result>>result;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = widget.name;
    print(widget.name);
    result=SingleSresult();
  }
  Future<List<Result>>SingleSresult() async{
    //final  url = 'http://192.168.31.45/sm_system/student_list.php';
    final  response = await http.post(Uri.parse("${Env.URL_PREFIX}/SingleStudent_list.php"),
        body: {
          'name':widget.name.toString()
        }
    );
// final response=await http.get("{$Env.URL_PREFIX}/student_list.php");
    final items=json.decode(response.body).cast<Map<String,  dynamic>>();
    List<Result>result=items.map<Result>((json){
      return Result.fromJson(json);
    }).toList();

    // var count=students.length;
    // print(students[0].phone_no);
    //  // print(students[1].phone_no);
    // print(students[0].address);
    // print(students[0].id);

    return result;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ScaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          leading: InkWell(
            onTap: ()=>Navigator.pop(context, false),
            child: Icon(Icons.arrow_back, size: 30,),
          ),
          title: Text(
            'Student Result',
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor:  Color(0xff002c51),
        ),
      ),
      body:Scrollbar(
        child:
              FutureBuilder<List<Result>>(
                future: result,
                builder: (ctx, snapshot){
                  //show loading spinner
                  if(!snapshot.hasData)  return
                    //  Container(padding: EdgeInsets.only(top: 30,left: 120),
                    // child: Text('Result Not Declared',style: TextStyle(color: Colors.black,fontSize: 20,),));
                    CircularProgressIndicator() ;
                  //render student list
                  Alignment.center;
                  return
                    ListView.builder(
                        itemCount:snapshot.data!.length,
                        itemBuilder:(ctx,int index){
                          var data=snapshot.data![index];
                          // final data=snapshot.data as String;
                          return Card(
                            child: ListTile(
                              leading: Icon(Icons.person),
                              trailing: Icon(Icons.view_list),
                              title: Text(
                                data.exam_name!, style: TextStyle(fontSize: 20),),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ResultDetails(marks:data)),
                                );
                              },
                            ),
                          );

                        });
                },

              ),

        ),

    );
  }
}
