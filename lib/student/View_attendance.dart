import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sms_project/model/Attendance.dart';
import 'package:sms_project/model/Env.dart';
import 'package:http/http.dart'as http;
class ViewAttendance extends StatefulWidget {
  final String? name;
  ViewAttendance({this.name});

  @override
  _ViewAttendanceState createState() => _ViewAttendanceState();
}

class _ViewAttendanceState extends State<ViewAttendance> {
  late Future<List<Attendance>>status;
  String? name;
  var state;
  // var adata;
  // DateTime now=new DateTime.now();
 // DateTime date= new DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
   static final DateTime now = DateTime.now();
   static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);

  @override
  void initState(){
    super.initState();
    name=widget.name;
    print(widget.name);
  status=SingleAttend();

    // print(formatted);
  }

  Future<List<Attendance>>SingleAttend() async{

    //final  url = 'http://192.168.31.45/sm_system/student_list.php';
    final  response = await http.post(Uri.parse("${Env.URL_PREFIX}/View_attendance.php"),
    body: {
      'Name':widget.name.toString(),
      'Date':formatted,
    }
    );
// fial response=await http.get("{$Env.URL_PREFIX}/student_list.php");
    final items=json.decode(response.body).cast<Map<String,  dynamic>>();
    List<Attendance>status=items.map<Attendance>((json){
      return Attendance.fromJson(json);
    }).toList();



    // var count=students.length;
    // print(students[0].phone_no);
    //  // print(students[1].phone_no);
    // print(students[0].address);
    // print(students[0].id);

    return status;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          leading: InkWell(
            onTap: (){Navigator.pop(context, false);},
            child: Icon(Icons.arrow_back, size: 30,),
          ),
          backgroundColor: Colors.greenAccent[400],
          centerTitle: true,
          title: Text('ATTENDANCE', style: TextStyle(fontSize: 20),
          ),
          // actions: [
          //   IconButton(onPressed: () {},
          //       icon: Icon(Icons.logout, color: Colors.white,)),
          // ],
        ),
      ),
      body:Scrollbar(
        child:
        FutureBuilder<List<Attendance>>(
          future: status,
          builder: (ctx, snapshot){
            //show loading spinner
            if(!snapshot.hasData)  return Container(child: Text('Attendance Not Declared'),);
              //CircularProgressIndicator() ;
              // Container(padding: EdgeInsets.only(top: 30,left: 120),
              //     child: Text('Result Not Declared',style: TextStyle(color: Colors.black,fontSize: 20,),));
            //CircularProgressIndicator() ;
            //render student list
            
            Alignment.center;
            return
              ListView.builder(
                  itemCount:snapshot.data!.length,
                  itemBuilder:(ctx,int index){
                    var data=snapshot.data![index];
                    // var state;
                    if(data.status==0)
                    {
                      state='Absent';
                    }else{
                       state='present';
                    }
                    // final data=snapshot.data as String;
                    return Card(

                      child: ListTile(
                        leading: Icon(Icons.person),

                          trailing:Text(state),
                        title: Text(
                          data.subject!, style: TextStyle(fontSize: 20),),
                        // onTap: () {
                        //   Navigator.push(context, MaterialPageRoute(builder: (context)=>SalaryDetail(details: data)),
                        //   );
                        // },
                      ),
                    );

                  });
          },

        ),

      ),
      );

  }
}
