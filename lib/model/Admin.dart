class Admin{
  final int? id;
  final String? admin_name;
  final String? email;
  final String? password;
  Admin({
    this.id,
    this.admin_name,
    this.email,
    this.password
});
  factory Admin.fromJson(Map<String, dynamic>json){
    return Admin(
      id: json['id'],
      admin_name: json['admin_name'],
      email: json['email'],
      password: json['password'],
    );
  }
  Map<String,dynamic>tojson()=>{
    'id':id,
    'admin_name':admin_name,
    'email':email,
    'password':password,
  };
}