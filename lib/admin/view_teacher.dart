import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sms_project/admin/manage_teacher_zone.dart';
import 'package:sms_project/admin/tDetails.dart';
import 'package:sms_project/model/teacher.dart';
import 'package:http/http.dart'as http;

import '../model/Env.dart';
class Viewteacher extends StatefulWidget {
  @override
  _ViewteacherState createState() => _ViewteacherState();
}

class _ViewteacherState extends State<Viewteacher> {

  late Future<List<Teacher>>teacher;
  //late List<student>students;
  final teacherListKey=GlobalKey<_ViewteacherState>();
  //int count=0;
  @override
  void initState() {
    super.initState();
    teacher=getTeacherList();
  }
  Future<List<Teacher>>getTeacherList() async{
    //final  url = 'http://192.168.31.45/sm_system/teacher_list.php';
    final  response = await http.get(Uri.parse("${Env.URL_PREFIX}/teacher_list.php"));
// final response=await http.get("{$Env.URL_PREFIX}/student_list.php");

    final items=json.decode(response.body).cast<Map<String,  dynamic>>();
    List<Teacher>teacher=items.map<Teacher>((json){
      return Teacher.fromJson(json);
    }).toList();
    // count=students.length;
    // print(teacher[0].phone_no);
    //  // print(students[1].phone_no);
    // print(students[0].address);
    // print(students[0].id);
    return teacher;
  }
  //List<String>Student=["prasad","rakshith","avinash"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: teacherListKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          leading: InkWell(
            onTap: ()=>Navigator.pop(context, false),
            child: Icon(Icons.arrow_back, size: 30,),
          ),
          title: Text(
            'VIEW TEACHERS',
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xff002c51),
        ),
      ),
      body:Scrollbar(
        child:
        FutureBuilder<List<Teacher>>(
          future: teacher,
          builder: (ctx, snapshot){
            //show loading spinner
            if(!snapshot.hasData) return CircularProgressIndicator();
            //render student list
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
                          data.teacher_name!, style: TextStyle(fontSize: 20),),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Tdetails(teacher:data)),
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

