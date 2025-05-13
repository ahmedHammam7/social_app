class MessageModel {
  late String SenderUid;
  late String RecieverUid;
  late String text;
  late String datetime;
  late String image;

  MessageModel(
      {required this.text,
      required this.RecieverUid,
      required this.SenderUid,
      required this.datetime,
      required this.image});

  MessageModel.fromJson(Map<String, dynamic> json) {
    text = json["text"]??null.toString();
    RecieverUid = json["RecieverUid"];
    SenderUid = json["SenderUid"];
    datetime = json["datetime"];
    image = json["image"]??null.toString();
  }

  Map<String, dynamic> tomap() {
    return {
      "text": text,
      "RecieverUid": RecieverUid,
      "SenderUid": SenderUid,
      "datetime": datetime,
      "image": image
    };
  }
}
