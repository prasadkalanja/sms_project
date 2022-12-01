import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:sms_project/model/teacher.dart';
import 'package:sms_project/teacher/View_SalDetail.dart';
import 'package:sms_project/teacher/teacher_zone.dart';
import '../model/Env.dart';
import '../model/teacher.dart';
import '../model/Salary.dart';

class VSalary extends StatefulWidget {
  final Teacher? tname;
  VSalary({this.tname});
  @override
  _VSalaryState createState() => _VSalaryState();
}

class _VSalaryState extends State<VSalary> {
  final ScaffoldKey=GlobalKey<_VSalaryState>();

  String? name;

  late Future<List<Salary>>sal;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name =widget.tname?.teacher_name.toString();
    print(name);
    sal = getSalary();
  }

  Future<List<Salary>>getSalary() async{
    //final  url = 'http://192.168.31.45/sm_system/student_list.php';
    final  response = await http.post(Uri.parse("${Env.URL_PREFIX}/Single_salary_list.php"),
        body: {
          'name':widget.tname?.teacher_name.toString()
        }
    );
// final response=await http.get("{$Env.URL_PREFIX}/student_list.php");
    final items=json.decode(response.body).cast<Map<String,  dynamic>>();
    List<Salary>sal=items.map<Salary>((json){
      return Salary.fromJson(json);
    }).toList();

    // var count=students.length;
    // print(students[0].phone_no);
    //  // print(students[1].phone_no);
    // print(students[0].address);
    // print(students[0].id);

    return sal;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ScaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          leading: InkWell(
            onTap: ()=>Navigator.pop(context,false),
            child: Icon(Icons.arrow_back, size: 30,),
          ),
          title: Text(
            'Salary Details',
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor:  Color(0xff002c51),
        ),
      ),
      body:Scrollbar(
        child:
        FutureBuilder<List<Salary>>(
          future: sal,
          builder: (ctx, snapshot){
            //show loading spinner
            if(!snapshot.hasData)  return
              // Container(padding: EdgeInsets.only(top: 30,left: 120),
              //     child: Text('Result Not Declared',style: TextStyle(color: Colors.black,fontSize: 20,),));
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
                          data.month!, style: TextStyle(fontSize: 20),),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SalaryDetail(details: data)),
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
