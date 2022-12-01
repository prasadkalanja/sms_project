import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms_project/model/Attendance.dart';
// import 'package:sms_project/student/student_zone.dart';
import 'package:sms_project/teacher/ADetails.dart';

// import '../admin/manage_student_zone.dart';
import '../model/Env.dart';
// import '../model/student.dart';
import 'package:http/http.dart'as http;

class ShowAttendance extends StatefulWidget {

  final String? date;
  final String? cls;
  final String? sub;
  ShowAttendance({this.date,this.cls,this.sub});
  @override
  _ShowAttendanceState createState() => _ShowAttendanceState();
}

class _ShowAttendanceState extends State<ShowAttendance> {
 //String? attendance;
  Future<List<Attendance>>?attendance;
  final AttendanceListKey=GlobalKey<_ShowAttendanceState>();
@override
void initstate(){
  super.initState();
  attendance=getShowAttend();
}
     Future<List<Attendance>> getShowAttend()async{
       final  response = await http.post(Uri.parse("${Env.URL_PREFIX}/get_attendance.php"),
       body:{
              'date':widget.date.toString(),
              'class':widget.cls.toString(),
               'sub':widget.sub.toString(),
           }
       );
// final response=await http.get("{$Env.URL_PREFIX}
// /student_list.php");

       final items=json.decode(response.body).cast<Map<String,  dynamic>>();
       List<Attendance>attendance=items.map<Attendance>((json){
         return Attendance.fromJson(json);
       }).toList();
       // count=students.length;
       // print(students[0].phone_no);
       //  // print(stude
       //  nts[1].phone_no);
       // print(students[0].address);
       // print(students[0].id);
       return attendance;
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: AttendanceListKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          leading: InkWell(
            onTap: ()=>Navigator.pop(context,false),

            child: Icon(Icons.arrow_back, size: 30,),
          ),
          title: Text(
            'View Attendance',
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xff002c51),
        ),
      ),
      body:Scrollbar(
        child:
        FutureBuilder<List<Attendance>>(
          future: attendance,
          builder: (ctx, snapshot){
            //show loading spinner
            if(!snapshot.hasData) return CircularProgressIndicator();
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

                        trailing: Icon(Icons.view_list),
                        title: Text(
                          data.student_name!, style: TextStyle(fontSize: 20),),
                        leading: Text(data.classs!,style: TextStyle(fontSize: 10),),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ADetail(attend: data)),
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
