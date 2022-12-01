import 'package:flutter/material.dart';
import 'package:sms_project/admin/manage_teacher_zone.dart';
import 'package:sms_project/admin/manageteacher.dart';

import '../model/AppformT.dart';
import '../model/Env.dart';
import '../model/teacher.dart';
import 'package:http/http.dart'as http;

class Tedit extends StatefulWidget {
  final Teacher teacher;
  Tedit({required this.teacher});
  @override
  _TeditState createState() => _TeditState();
}

class _TeditState extends State<Tedit> {
  final formKey=GlobalKey<FormState>();
  late TextEditingController teacher_nameController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController phone_noController;
  late TextEditingController experienceController;
  Future editTeacher()async{
    //final  url = "http://192.168.31.45/sm_system/teacher_update.php";
    return await http.post(Uri.parse("${Env.URL_PREFIX}/teacher_update.php"),
      body:{
        "id":widget.teacher.id.toString(),
        "teacher_name":teacher_nameController.text,
        "email":emailController.text,
        "address":addressController.text,
        "phone_no":phone_noController.toString(),
        "experience":experienceController.text,
      },
    );

  }
  void _onConfirm(context) async {
    await editTeacher();
    // view_student.
Navigator.push(context, MaterialPageRoute(builder: (context)=>Mteacherzone()));
    // Navigator.of(context)
    //     .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }
  @override
  void initState() {
    teacher_nameController = TextEditingController(text: widget.teacher.teacher_name.toString());
    emailController = TextEditingController(text: widget.teacher.email.toString());
    addressController = TextEditingController(text: widget.teacher.address.toString());
    phone_noController = TextEditingController(text: widget.teacher.phone_no.toString());
    experienceController = TextEditingController(text: widget.teacher.experience.toString());
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
            child: AppFormT(
              formKey: formKey,
              teacher_nameController: teacher_nameController,
              emailController: emailController,
              addressController:addressController,
              phone_noController:phone_noController,
              experienceController:experienceController,
            ),
          ),
        ),
      ),
    );
  }
}

