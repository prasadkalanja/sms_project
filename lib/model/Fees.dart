class Fees{
  final int? id;
  final String? student_name;
  final int? total_fees;
  final int? paid_fees;
  final int? remaining_fees;
  Fees({
    this.id,
    this.student_name,
    this.total_fees,
    this.paid_fees,
    this.remaining_fees,

});
 factory Fees.fromJson(Map<String, dynamic>json){
   return Fees(
     id: json['id'],
     student_name: json['student_name'],
     total_fees: json['total_fees'],
     paid_fees: json['paid_fees'],
     remaining_fees: json['remaining_fees'],
   );
 }
Map<String,dynamic>toJson()=>{
   'id':id,
  'student_name':student_name,
  'total_fees':total_fees,
  'paid_fees':paid_fees,
  'remaining_fees':remaining_fees,
};
}