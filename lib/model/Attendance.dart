class Attendance{
  final int? id;
  final String? student_name;
  final String? classs;
  final String? subject;
  final int? status;
  final String? date;
  Attendance({
    this.id,
  this.student_name,
  this.classs,
    this.subject,
    this.status,
    this.date,
  });
  factory Attendance.fromJson(Map<String,dynamic>json){
    return Attendance(
      id: json['id'],
      student_name: json["student_name"],
      classs: json["classs"],
      subject: json['subject'],
      status: json["status"],
      date: json["date"],
    );
  }
  Map<String,dynamic>toJson()=>{
    "id":id,
    "student_name":student_name,
    "classs":classs,
    "subject":subject,
    "status":status,
    "date":date,
  };
}