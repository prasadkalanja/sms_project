import 'package:flutter/material.dart';
import 'package:sms_project/admin/manage_student_zone.dart';
import 'package:sms_project/admin/view_student.dart';

import '../model/Appform.dart';
import '../model/Env.dart';
import '../model/student.dart';
import 'package:http/http.dart'as http;

class Edit extends StatefulWidget {
  final student students;
  Edit({required this.students});
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  final formKey=GlobalKey<FormState>();

  late TextEditingController student_nameController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController phone_noController;
  Future editStudent()async{
    //final  url = "http://192.168.31.45/sm_system/student_update.php";
    return await http.post(Uri.parse("${Env.URL_PREFIX}/student_update.php"),
      body:{
      "id":widget.students.id.toString(),
        "student_name":student_nameController.text,
        "email":emailController.text,
        "address":addressController.text,
        "phone_no":phone_noController.text,

      },
    );

  }
  void _onConfirm(context) async {
    await editStudent();
    // view_student.
Navigator.push(context, MaterialPageRoute(builder: (context)=>Mstudentzone()));
    // Navigator.of(context)
    //   .pushNamedAndRemoveUntil('/MStudent', (Route<dynamic> route) => false);
  }
  @override
  void initState() {
    student_nameController = TextEditingController(text: widget.students.student_name.toString());
    emailController = TextEditingController(text: widget.students.email.toString());
    addressController = TextEditingController(text: widget.students.address.toString());
    phone_noController = TextEditingController(text: widget.students.phone_no.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          child: Text('CONFIRM'),
          // color: Colors.blue,
          // textColor: Colors.white,
          onPressed: () {
              _onConfirm(context);
          },
        ),
      ),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: AppForm(
              formKey: formKey,
              student_nameController: student_nameController,
              emailController: emailController,
              addressController:addressController,
              phone_noController:phone_noController,
            ),
          ),
        ),
      ),
    );
  }
}

