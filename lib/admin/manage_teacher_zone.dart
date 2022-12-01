import 'package:flutter/material.dart';
import 'package:sms_project/admin/admin_zone.dart';
import 'package:sms_project/admin/login.dart';
import 'package:sms_project/admin/manageteacher.dart';
import 'package:sms_project/admin/tDetails.dart';
import 'package:sms_project/admin/view_teacher.dart';

import 'Upload_salary.dart';
import 'View_Salary.dart';

class Mteacherzone extends StatefulWidget {
  @override
  _MteacherzoneState createState() => _MteacherzoneState();
}

class _MteacherzoneState extends State<Mteacherzone> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // drawer: Drawer(
      //       child: ListView(
      //       children: [
      //         UserAccountsDrawerHeader(
      //           decoration: BoxDecoration(color: Colors.black),
      //           accountName: Text('PRASADA KALANJA'),
      //           accountEmail:Text('prasadkalanja@gmail.com'),
      //           currentAccountPicture: CircleAvatar(backgroundColor: Colors.amber,
      //             child: Text('P',style: TextStyle(fontSize: 40.0),
      //             ),
      //           ),
      //         ),
      //         ListTile(
      //           onTap: (){
      //             Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
      //           },
      //           leading:  Icon(Icons.logout),title: Text('LogOut'),
      //         ),
      //       ],
      //       ),
      // ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          leading: InkWell(
            onTap: (){
              Navigator.pop(context,false);
            },
            child: Icon(Icons.arrow_back,size: 30,),
          ),
          backgroundColor: Colors.deepPurple[500],
          centerTitle: true,
          title: Text(' TEACHER MANAGE ZONE',style: TextStyle(fontSize: 20),
          ),
          // actions: [
          //   IconButton(onPressed:(){
          //     Navigator.push(context, MaterialPageRoute(builder: (context)=>Adminzone()));
          //   },
          //       icon: Icon(Icons.logout,color: Colors.white,)),
          // ],
        ),
      ),
      body:
      // Column(
      //              children: [
      //                Padding(
      //                    padding:const EdgeInsets.only( left: 25,right: 15,bottom: 16),
      //                child: Column(
      //                      children: [
      //                          SizedBox(height: 24,),
      //                        InkWell(
      //                          child: Row(
      //                                children: [
      //                                  InkWell(
      //                                    child:Image( "assets/images/calendar.png"),
      //                                  ),
      //                                ],
      //                          ),
      //                        ),
      //                      ],
      //                ),
      //                ),
      //
      //              ],
      // ),
      Center(
        child: Container(
          padding: EdgeInsets.only(top:100,left: 20,right: 20),
          child: GridView.count(
            crossAxisSpacing: 10,
            mainAxisSpacing: 20,
            crossAxisCount:2,
            // padding: EdgeInsets.all(30),
            scrollDirection: Axis.vertical,
            children: [
              Card(
                elevation: 10,
                shadowColor: Colors.black,
                color: Colors.white60,
                child: Container(
                  // color: Colors.transparent,
                  // child: ListTile(onTap: (){
                  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>mstudent()));
                  // },
                  // ),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Mteacher()));
                    },
                    child: Text('Add Teacher',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),textAlign:TextAlign.center),
                  ),
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('assets/images/ADD_T.png'),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 10,
                shadowColor: Colors.black,
                color: Colors.white60,
                child: Container(
                  child: InkWell(
                    onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadSalary()));
                    },
                    child: Text('Upload Salary',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),textAlign:TextAlign.center),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/UPLOAD_S.png'),
                      )
                  ),
                ),

              ),
              Card(
                elevation: 10,
                shadowColor: Colors.black,
                color: Colors.white60,
                child: Container(
                  child: InkWell(
                    onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Viewteacher()));
                    },
                    child: Text('View Teachers',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),textAlign:TextAlign.center),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/VIEW_T.png'),
                      )
                  ),
                ),

              ),
              Card(
                elevation: 10,
                shadowColor: Colors.black,
                color: Colors.white60,
                child: Container(
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewSalary()));
                    },
                    child: Text('View Salary',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),textAlign:TextAlign.center),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/UPLOAD_S.png'),
                      )
                  ),
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}

