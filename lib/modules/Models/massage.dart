
class MassageModel{

  late String dateTime;
  late String senderId;
  late String reciverId;
  late String text;

MassageModel({
  required this.reciverId,
  required this.senderId,
  required this.dateTime,
  required this.text,

});

MassageModel.fromJson(Map <String,dynamic>json){
  dateTime =json['dateTime'];
  text =json['text'];
  senderId =json['senderId'];
  reciverId =json['reciverId'];
}

Map<String,dynamic>toMap(){
  return {

    'dateTime':dateTime,
    'reciverId':reciverId,
    'senderId':senderId,
    'text':text,
  };
}

}