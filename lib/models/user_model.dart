class UserModel {
 final String name;
 final String phone;
 final String email;
 final String password;
 final String confirmPassword;
 final String profilePic;

  UserModel({required this.name, required this.phone, required this.email, required this.password, required this.confirmPassword, required this.profilePic});
factory UserModel.fromjson(json){
  return UserModel( name: json['name'] ?? '',
    phone: json['phone'] ?? '',
    email: json['email'] ?? '',
    password: json['password'] ?? '',
    confirmPassword: json['confirmPassword'] ?? '',
    profilePic: json['profilePic'] ?? '',);
}
}


Map<String,dynamic> toMap(UserModel user){
  return {
    'name':user.name,
    'phone':user.phone,
    'email':user.email,
    'password':user.password,
    'confirmPassword':user.confirmPassword,
    'profilePic':user.profilePic


};}