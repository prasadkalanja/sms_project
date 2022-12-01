import 'package:flutter/material.dart';
import 'package:sms_project/admin/Upload_fees.dart';
import 'package:sms_project/admin/Upload_result.dart';
import 'package:sms_project/admin/admin_zone.dart';
import 'package:sms_project/admin/managestd.dart';
import 'package:sms_project/admin/view_student.dart';
import 'View_fees.dart';
import 'View_result.dart';

class Mstudentzone extends StatefulWidget {
  @override
  _MstudentzoneState createState() => _MstudentzoneState();
}

class _MstudentzoneState extends State<Mstudentzone> {
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
          backgroundColor:Colors.cyan[500],
          centerTitle: true,
          title: Text('STUDENT MANAGE ZONE',style: TextStyle(fontSize: 20),
          ),
          // actions: [
          //   IconButton(onPressed:(){},
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Mstudent()));
                    },
                    child: Text('Add Student',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),textAlign:TextAlign.center),
                  ),
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('assets/images/ADD_S.png'),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 10,
                shadowColor: Colors.black,
                color: Colors.white60,
                // color: Colors.white,
                child: Container(
                  child: InkWell(
                    onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadFees()));
                    },
                    child: Text('M_Fees',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),textAlign:TextAlign.center),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/S_FEES.png'),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadResult()));
                    },
                    child: Text('Upload Result',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),textAlign:TextAlign.center),
                  ),
                  decoration: BoxDecoration(image: DecorationImage(
                    image: AssetImage('assets/images/UPLOAD_R.png'),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Viewstudent()));
                    },
                    child: Text('View Student',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),textAlign:TextAlign.center),
                  ),
                  decoration: BoxDecoration(image: DecorationImage(
                    image: AssetImage('assets/images/VIEW_S.png'),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewResult()));
                    },
                    child: Text('View Result',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),textAlign:TextAlign.center),
                  ),
                  decoration: BoxDecoration(image: DecorationImage(
                    image: AssetImage('assets/images/VIEW_S.png'),
                  )
                  ),
                ),
              ),
              Card(
                elevation: 10,
                shadowColor: Colors.black,
                color: Colors.white60,
                // color: Colors.white,
                child: Container(
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewFees()));
                    },
                    child: Text('View_Fees',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),textAlign:TextAlign.center),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/S_FEES.png'),
                      )
                  ),
                ),

              ),
              // Card(
              //   child: Container(
              //     child: InkWell(
              //       onTap: (){
              //
              //       },
              //       child: Text('Exam',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),textAlign:TextAlign.center),
              //     ),
              //     decoration: BoxDecoration(
              //         image: DecorationImage(
              //           image: AssetImage('assets/images/exam.jpg'),
              //         )
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

