class UserModel {
 final String name;
 final String phone;
 final String email;
 final String password;
 final String confirmPassword;
 final String profilePic;

  UserModel({required this.name, required this.phone, required this.email, required this.password, required this.confirmPassword, required this.profilePic});
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