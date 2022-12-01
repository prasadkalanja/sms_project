
// import 'dart:convert';
//
// List<Student> checkListFromJson(String str) => List<Student>.from(json.decode(str).map((x) => Student.fromJson(x)));
//
// String checkListToJson(List<Student> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class student{
  final int? id;
  final String? student_name;
  final String? email;
  final String? address;
  final int? phone_no;
  final String? father_name;
  final String? classs;
  final String? date_of_birth;
  student({ this.id,
      this.student_name,
     this.email,
      this.address,
      this.phone_no,
     this.father_name,
     this.classs,
    this.date_of_birth
  });

  factory student.fromJson(Map<String, dynamic> json){
    return student(
      id: json["id"],
      student_name: json['student_name'],
      email: json['email'],
      address: json['address'],
      phone_no: json['phone_no'],
      father_name: json['father_name'],
      classs: json['classs'],
      date_of_birth: json['date_of_birth'],

    );
  }
  Map<String, dynamic> toJson() =>{
    'student_name':student_name,
    'email':email,
    'address':address,
    'phone_no':phone_no,
    'father_name':father_name,
    'classs':classs,
    'date_of_birth':date_of_birth,
  };
}