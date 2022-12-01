import 'package:flutter/material.dart';

class AppForm extends StatefulWidget {
  GlobalKey<FormState>formKey= GlobalKey<FormState>();

  late TextEditingController student_nameController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController phone_noController;

  AppForm({
    required this.formKey,
    required this.student_nameController,
    required this.emailController,
    required this.addressController,
    required this.phone_noController}) ;
  @override
  _AppFormState createState() => _AppFormState();
}

class _AppFormState extends State<AppForm> {

  // String? _validateName(String value){
  //   if (value.length<3) return 'Name must be more than 2 character';
  //   return null;
  // }
  // String? _validateEmail(String value){
  //   RegExp regex= new RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  //   if(!regex.hasMatch(value)) return 'Email is not valid';
  //   return null;
  // }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      // autovalidateMode:true,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: widget.student_nameController,
            keyboardType: TextInputType.text,
            readOnly: true,
            decoration: InputDecoration(labelText: 'Name'),
            //validator:_validateName,
          ),
          TextFormField(
            controller: widget.emailController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Email'),
            // validator: _validateAge,
          ),
          TextFormField(
            controller: widget.addressController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Address'),
            // validator: _validateAge,
          ),
          TextFormField(
            controller: widget.phone_noController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Phone_No'),
            // validator: _validateAge,
          ),
        ],
      ),
    );
  }

}
