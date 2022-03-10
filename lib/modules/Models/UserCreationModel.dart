class UserCreationModel{
  late String name;
  late String phone;
  late String email;
  late String uid;
  late String image;
  late String cover;
  late String bio;
UserCreationModel({
  required this.email,
  required this.name,
  required this.phone,
  required this.uid,
  required this.image,
  required this.cover,
  required this.bio,
});

UserCreationModel.fromJson(Map <String,dynamic>json){
  name =json['name'];
  email =json['email'];
  phone =json['phone'];
  uid =json['uid'];
  image =json['image'];
  cover =json['cover'];
  bio =json['bio'];
}

Map<String,dynamic>toMap(){
  return {
    'name':name,
    'email':email,
    'phone':phone,
    'uid':uid,
    'image':image,
    'cover':cover,
    'bio':bio,
  };
}

}