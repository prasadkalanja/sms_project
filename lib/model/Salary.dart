class Salary{
  final int? id;
  final String? teacher_name;
  final String? month;
  final int? amount;
  Salary({
    this.id,
    this.teacher_name,
    this.month,
    this.amount,
});
  factory Salary.fromJson(Map<String, dynamic>json){
    return Salary(
      id: json['id'],
      teacher_name: json['teacher_name'],
      month: json['month'],
      amount: json['amount'],
    );
  }
  Map<String,dynamic>toJson()=>{
    'id':id,
    'teacher_name':teacher_name,
    'month':month,
    'amount':amount,
  };
}