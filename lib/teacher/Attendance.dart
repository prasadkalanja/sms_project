import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:sms_project/teacher/Show_attendance.dart';
import '../model/Env.dart';
import '../model/student.dart';
import '../model/teacher.dart';

class TakeAttendance extends StatefulWidget {
  final Teacher data;
  TakeAttendance({required this.data});
  @override
  _TakeAttendanceState createState() => _TakeAttendanceState();
}

class _TakeAttendanceState extends State<TakeAttendance> {

  final studentListKey=GlobalKey<_TakeAttendanceState>();
  final sdate=TextEditingController();
  //final value=GlobalKey();
  //late Future<List<student>>students;
  // var Absent;
  // var Present;
List getStudentList=[] ;
 String SelectedClass='Select class';
 var item=[
   'Select class',
   'Class 5',
   'Class 6',
   'Class 7',
   'Class 8',
   'Class 9',
   'Class 10',
 ];
 bool _canShowWidget=true;
void hideWidget(){
  setState(() {
    _canShowWidget=!_canShowWidget;
  });
}

  Future getAllStudentList() async{
    String Class=SelectedClass.toString();

    //final  url = 'http://192.168.31.45/sm_system/attendance_list.php';
     var data={'class':Class};
    final  response = await http.post(Uri.parse('${Env.URL_PREFIX}/attendance_list.php'),body: json.encode(data));
    final items=  jsonDecode(response.body);
   
    setState(() {
      getStudentList=items;
    });
    print(getStudentList);
  }
  
  Future UploadPdata(String value)async{
    String Class=SelectedClass.toString();
   // String date=sdate.text;
  var data={
    'class':Class,
    'date':sdate.text,
    'status':1,
    'subject':widget.data.teaching_subject.toString(),
    'name':value,
  };
  final response=await http.post(Uri.parse("${Env.URL_PREFIX}/upload_attendance.php"),body: json.encode(data));
  final msg=jsonDecode(response.body);
  print(msg);
  }

  Future UploadAdata(String value)async{
    String Class=SelectedClass.toString();
    //String date=sdate.text;
    var data={
      'class':Class,
      'date':sdate.text,
      'status':0,
      'subject':widget.data.teaching_subject.toString(),
      'name':value,
    };
    final response=await http.post(Uri.parse('${Env.URL_PREFIX}/upload_attendance.php'),body: json.encode(data));
    final msg=jsonDecode(response.body);
    print(msg);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: studentListKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          leading: InkWell(
            onTap: ()=>Navigator.pop(context,false)
            ,
            child: Icon(Icons.arrow_back, size: 30,),
          ),
          title: Text(
            'TAKE ATTENDANCE',
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xff002c51),
        ),
      ),
      body:SafeArea(

        child:SingleChildScrollView(
            child:Column(
              children: [
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.all(25),
                  child: DropdownButtonFormField(

                      decoration: InputDecoration(
                        hintText: 'Class',
                        label: Text('Select Class'),
                        fillColor: Colors.black12,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      value:SelectedClass,

                      items: item.map((String item){
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),);
                      }).toList(),
                      onChanged: (String? newValue){
                        setState(() {
                          SelectedClass=newValue!;
                        });
                      }),
                ),
                
                Container(
                  child: ElevatedButton(
                    child: Text('Get Data',style: TextStyle(fontSize: 10),),
                    onPressed:getAllStudentList,

                  ),
                ),
                
                getStudentList.isNotEmpty
                ?Container(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                    itemCount: getStudentList.length,
                      itemBuilder: (context,index){
                      return Card(
                        elevation: 10,
                        shadowColor: Colors.black,
                        color: Colors.cyanAccent,
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          leading: InkWell(
                            child: Icon(Icons.person),
                          ),
                          title:Row(
                            children: [
                              Text(getStudentList[index]["student_name"],style:TextStyle(fontWeight:FontWeight.bold)),
                            ],
                          ),
                          // title: Text(getStudentList[index]["id"]),
                          subtitle: Text(getStudentList[index]["id"]),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton(
                                  onPressed:(){
                                    UploadAdata(getStudentList[index]["student_name"]);
                              }, child: Text('Absent',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize:20),)),
                            //  !_canShowWidget
                                 // SizedBox.shrink()
                              TextButton(onPressed:(){
                                UploadPdata(getStudentList[index]["student_name"]);
                               // hideWidget();
                              }, child: Text('Present',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize:20))),
                              //IconButton(onPressed:(){},icon:Icon(Icons.clear,size: 20,),),
                            ],
                          ),
                        ),
                      );
                      }
                  ),
                )
                : Container(child: Text('No data found'),),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.only(left: 35,right:35),
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: '${widget.data.teaching_subject}',
                      border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.only(left: 35,right:35),
                  child: TextFormField( controller:sdate,
                    readOnly: true,
                    validator: (sDOJval){
                      if(sDOJval!.isEmpty)
                      {
                        return "DOJ is required";
                      }
                    },
                    decoration: InputDecoration(
                      label: Text('Current date'),
                      hintText: "Select date",
                      fillColor: Colors.black12,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onTap: ()async{
                      DateTime date=DateTime.now();
                      sdate.text=date.toString().substring(0,10);
                    },
                  ),
                ),
                SizedBox(height: 20,),
      //           Container(
      //             child: ElevatedButton(onPressed:(){
      //               Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowAttendance(date: sdate.toString(),cls:SelectedClass,sub: widget.data.teaching_subject.toString(),)));
      //             },
      //                 child: Text("Submit")),
      // ),
              ],
            ),
        ),
      ),
    );
  }
}
