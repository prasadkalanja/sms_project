import 'package:flutter/material.dart';
import 'package:sms_project/admin/login.dart';
import 'package:sms_project/first.dart';
import 'package:sms_project/student/login.dart';
import 'package:sms_project/student/student_zone.dart';

import '../model/student.dart';

class StudentProfile extends StatefulWidget {
  final student profile;
  StudentProfile({required this.profile});
  @override
  _StudentProfileState createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {

  Widget _getHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              //borderRadius: BorderRadius.all(Radius.circular(10.0)),
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        "http://assets.stickpng.com/images/585e4bf3cb11b227491c339a.png"))
              // color: Colors.orange[100],
            ),
          ),
        ),
      ],
    );
  }

  Widget _profileName(String name) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80, //80% of width,
      child: Center(
        child: Text(
          "Name: ${widget.profile.student_name}",
          style: TextStyle(

              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  Widget _heading(String heading) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80, //80% of width,
      child: Text(
        heading,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _detailsCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            //row for each details
            ListTile(
              leading: Icon(Icons.email),
              title: Text("${widget.profile.email}"),
            ),
            Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text("${widget.profile.phone_no}"),
            ),
            Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.note),
              title: Text("${widget.profile.classs}"),
            ),
            Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.location_city),
              title: Text("${widget.profile.address}"),
            ),
            Divider(
              color: Colors.black87,
              height: 0.6,
            ),


          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names

  Widget logoutButton() {
    return InkWell(
      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>First())),
      child: Container(
          color: Color(0xfff5435d),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Text(
                  "Logout",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
          )),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context,false);
              },
            child: Icon(Icons.arrow_back, size: 30,),
          ),
          backgroundColor:  Color(0xfff5435d),
          centerTitle: true,
          title: Text(
            'STUDENT PROFILE',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      body: SafeArea(
          child: Column(
            children: [

              _getHeader(),
              SizedBox(
                height: 10,
              ),
              _profileName('${widget.profile.student_name}'),
              SizedBox(
                height: 14,
              ),
              _heading("Personal Details"),
              SizedBox(
                height: 6,
              ),
              _detailsCard(),
              SizedBox(
                height: 6,
              ),
              SizedBox(
                height: 6,
              ),
              Spacer(),
              logoutButton()
            ],
          )),
    );
  }
}

