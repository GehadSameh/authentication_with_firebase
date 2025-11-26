class UserModel {
 final String name;
 final String phone;
 final String email;
 
 final String profilePic;

  UserModel({required this.name, required this.phone, required this.email,required this.profilePic});
factory UserModel.fromjson(json){
  return UserModel( name: json['name'] ?? 'anonymous user',
    phone: json['phone'] ?? '',
    email: json['email'] ?? '',
   
    profilePic: json['profilePic'] ?? 'assets/images/anonymous-user.webp',);
}
}


Map<String,dynamic> toMap(UserModel user){
  return {
    'name':user.name,
    'phone':user.phone,
    'email':user.email,
    
    'profilePic':user.profilePic


};}