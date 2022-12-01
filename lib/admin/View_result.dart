import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:sms_project/admin/Result_details.dart';
import '../model/Env.dart';
import '../model/Result.dart';
import 'manage_student_zone.dart';

class ViewResult extends StatefulWidget {
  @override
  _ViewResultState createState() => _ViewResultState();
}

class _ViewResultState extends State<ViewResult> {
  late Future<List<Result>>result;
  //late List<student>students;
  final studentListKey=GlobalKey<_ViewResultState>();
  //int count=0;
  @override
  void initState() {
    super.initState();
    result=getStudentList();
  }
  Future<List<Result>>getStudentList() async{
    //final  url = 'http://192.168.31.45/sm_system/Result_list.php';
    final  response = await http.get(Uri.parse("${Env.URL_PREFIX}/Result_list.php"));
// final response=await http.get("{$Env.URL_PREFIX}/student_list.php");

    final items=json.decode(response.body);
    //cast<Map<String,  dynamic>>();
    List<Result>result=items.map<Result>((json){
      return Result.fromJson(json);
    }).toList();
     //count=result.length;
    //print(result[0].student_name);
    //  // print(students[1].phone_no);
    // print(students[0].address);
    // print(students[0].id);
    return result;
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
            'VIEW RESULT',
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xff002c51),
        ),
      ),
      body:Scrollbar(
        child:
        FutureBuilder<List<Result>>(
          future: result,
          builder: (ctx, snapshot){
            //show loading spinner
            if(!snapshot.hasData) return CircularProgressIndicator() ;
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
                          data.student_name!, style: TextStyle(fontSize: 20),),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ResultDetails(result:data)),
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
