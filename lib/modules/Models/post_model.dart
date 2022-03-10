
class PostModel{
  late String name;
  late String text;
  late String dateTime;
  late String uid;
  late String image;
  late String ?postImage;

PostModel({
  required this.name,
  required this.uid,
  required this.image,
  required this.text,
  required this.dateTime,
  required this.postImage,

});

PostModel.fromJson(Map <String,dynamic>json){
  name =json['name'];
  text =json['text'];
  dateTime =json['dateTime'];
  uid =json['uid'];
  image =json['image'];
  postImage =json['postImage'];
}

Map<String,dynamic>toMap(){
  return {
    'name':name,
    'text':text,
    'dateTime':dateTime,
    'uid':uid,
    'image':image,
    'postImage':postImage,
  };
}

}