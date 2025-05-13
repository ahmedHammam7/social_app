

class UserModel{

 late String? email;
 late String? name;
 late  String? phone;
 late String? Uid;
 late bool? isVerfied;
 late String? image;
 late String? Cover;
 late String? Bio;


  UserModel({ this.phone, this.name, this.email, this.Uid, this.isVerfied, this.image, this.Cover, this.Bio});


  UserModel.fromJson(Map<String,dynamic>json) {
    email=json["email"];
    name=json["name"];
    phone=json["phone"];
    Uid=json["Uid"];
    isVerfied=json["isVerfied"];
    image=json["image"];
    Cover=json["Cover"];
    Bio=json["Bio"];
  }
  Map<String,dynamic>toMap(){

    return{
      "email":email,
      "name":name,
      "phone":phone,
      "Uid":Uid,
      "isVerfied":isVerfied,
      "image":image,
      "Cover":Cover,
      "Bio":Bio

    };
  }
}