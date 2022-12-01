class Result{
  final int? id;
  final String? student_name;
  final int? total_marks;
  final String? exam_name;
  final String? result;
  final int? percentage;
  final int? obtained_marks;
Result({
    this.id,
   this.student_name,
  this.total_marks,
  this.exam_name,
  this.result,
  this.percentage,
  this.obtained_marks,

});
factory Result.fromJson(Map<String, dynamic>json){
  return Result(
    id: json['id'],
    student_name: json['student_name'],
    total_marks: json['total_marks'],
    exam_name: json['exam_name'],
    result: json['result'],
    percentage: json['percentage'],
    obtained_marks: json['obtained_marks'],
  );
}
Map<String, dynamic> toJson() =>{
  'id':id,
  'student_name':student_name,
  'total_marks':total_marks,
  'exam_name':exam_name,
  'result':result,
  'percentage':percentage,
  'obtained_marks':obtained_marks,
  };
}