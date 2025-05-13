

class PostModel{

  late String? name;
  late String? image;
  late String? Postimage;
  late String? DateTime;
  late String? text;



  PostModel({ this.image, this.name, this.text,this.DateTime,this.Postimage});


  PostModel.fromJson(Map<String,dynamic>json) {
    name=json["name"];
    Postimage=json["Postimage"];
    DateTime=json["DateTime"];
    image=json["image"];
    text=json["text"];
  }
  Map<String,dynamic>toMap(){
    return{
      "name":name,
      "Postimage":Postimage,
      "DateTime":DateTime,
      "image":image,
      "text":text
    };
  }
}