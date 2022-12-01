import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:sms_project/admin/manage_teacher_zone.dart';
import '../model/Env.dart';
import '../model/Salary.dart';
import 'SalDetails.dart';

class ViewSalary extends StatefulWidget {
  @override
  _ViewSalaryState createState() => _ViewSalaryState();
}

class _ViewSalaryState extends State<ViewSalary> {
  late Future<List<Salary>>salary;
  //late List<student>students;
  final studentListKey=GlobalKey<_ViewSalaryState>();
  //int count=0;
  @override
  void initState() {
    super.initState();
    salary=getSal();
  }
  Future<List<Salary>>getSal() async {
    // final  url = 'http://192.168.31.45/sm_system/student_list.php';
    final response = await http.get(
        Uri.parse("${Env.URL_PREFIX}/salary_list.php"));
// final response=await http.get("{$Env.URL_PREFIX}
// /student_list.php");

    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Salary>salary = items.map<Salary>((json) {
      return Salary.fromJson(json);
    }).toList();
    // count=students.length;
    // print(students[0].phone_no);
    //  // print(stude
    //  nts[1].phone_no);
    // print(students[0].address);
    // print(students[0].id);
    return salary;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: studentListKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          leading: InkWell(
            onTap: ()=>Navigator.pop(context, false),

            child: Icon(Icons.arrow_back, size: 30,),
          ),
          title: Text(
            'View Salary',
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xff002c51),
        ),
      ),
      body:Scrollbar(
        child:
        FutureBuilder<List<Salary>>(
          future: salary,
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
                        leading: Icon(Icons.person),
                        trailing: Icon(Icons.view_list),
                        title: Text(
                          data.teacher_name!, style: TextStyle(fontSize: 20),),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SalDetails(Sdetails:data)),
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
