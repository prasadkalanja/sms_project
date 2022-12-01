class Teacher{
  final int? id;
  final String? teacher_name;
  final String? email;
  final int? phone_no;
  final String? teaching_subject;
  final String? experience;
  final String? date_of_birth;
  final String? address;
  final String? gender;
  Teacher({
    this.id,
    this.teacher_name,
    this.email,
    this.phone_no,
    this.teaching_subject,
    this.experience,
    this.date_of_birth,
    this.address,
    this.gender
});
  factory Teacher.fromJson(Map<String, dynamic> json){
    return Teacher(
      id: json["id"],
      teacher_name: json["teacher_name"],
      email: json["email"],
      phone_no: json["phone_no"],
      teaching_subject: json["teaching_subject"],
      experience: json["experience"],
      date_of_birth: json["date_of_birth"],
      address: json["address"],
      gender: json["gender"],
    );
  }
  Map<String ,dynamic>toJson()=>{
    'teacher_name':teacher_name,
    'email':email,
    'phone_no':phone_no,
    'teaching_subject':teaching_subject,
    'experience':experience,
    'date_of_birth':date_of_birth,
    'address':address,
    'gender':gender,
  };
}
