import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Cubit/SocialCubit/SocialState.dart';
import 'package:social_app/Models/MessageModel.dart';
import 'package:social_app/Models/PostModel.dart';
import 'package:social_app/Models/UserModel.dart';
import 'package:social_app/Screens/ChatSceen.dart';
import 'package:social_app/Screens/FeedScreen.dart';
import 'package:social_app/Screens/LoginScreen.dart';
import 'package:social_app/Screens/SettingScreen.dart';
import 'package:social_app/Screens/UserSceen.dart';
import 'package:social_app/SharedPreference/Preference.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(intialSocialState());
  UserModel? model;
  getUserData() {
    emit(LoadingSocialState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(Preference.getData(key: "Uid"))
        .get()
        .then((value) {
      model = UserModel.fromJson(value.data()!);
      print(value.data());
      print(Preference.getData(key: "Uid"));
      emit(SuccessSocialState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorSocialState());
    });
  }

  int currentIndex = 0;
  List<Widget> Screens = [
    const FeedScreen(),
    const ChatScreen(),
    const UserScreen(),
    const SettingScreen(),
  ];
  List<String> titles = [
    "Home",
    "Chat",
    "Users",
    "Settings",
  ];
  void BottomNavChange(int index) {
    currentIndex = index;
    emit(BottomNavChangeState());
  }

  XFile? image;
  File? Profilephoto;

  void PickProfilePhoto() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    try {
      image = await picker.pickImage(source: ImageSource.gallery);
      Profilephoto = File(image!.path);
      emit(UpdateProfilePhotoError());
    } catch (error) {
      emit(UpdateProfilePhotoError());
    }
  }

  File? Coverphoto;
  void PickCoverPhoto() async {
    final ImagePicker picker = ImagePicker();

    try {
      image = await picker.pickImage(source: ImageSource.gallery);
      Coverphoto = File(image!.path);
      emit(UpdateCoverPhotoSuccess());
    } catch (error) {
      emit(UpdateCoverPhotoError());
    }
  }

  void UploadProfileImage({required name, required phone, required bio}) {
    if (Profilephoto == null) {
      return null;
    } else {
      emit(UpdateProfileLoading());
      FirebaseStorage.instance
          .ref()
          .child("Users/${Uri.file(Profilephoto!.path).pathSegments.last}")
          .putFile(Profilephoto!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          UpdateUserData(name: name, phone: phone, bio: bio, image: value);
          emit(UpdateProfilePhotoSuccess());
        }).catchError((error) {
          emit(UpdateProfilePhotoError());
        });
      }).catchError((error) {
        emit(UpdateProfilePhotoError());
      });
    }
  }

  void UploadCoverImage({required name, required phone, required bio}) {
    if (Coverphoto == null) {
      return null;
    } else {
      emit(UpdateCoverLoading());
      FirebaseStorage.instance
          .ref()
          .child("Users/${Uri.file(Coverphoto!.path).pathSegments.last}")
          .putFile(Coverphoto!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          UpdateUserData(name: name, phone: phone, bio: bio, cover: value);
          emit(UpdateCoverPhotoSuccess());
        }).catchError((error) {
          emit(UpdateCoverPhotoError());
        });
      }).catchError((error) {
        emit(UpdateCoverPhotoError());
      });
    }
  }

  void UpdateUserData(
      {required name,
      required phone,
      required bio,
      String? cover,
      String? image}) {
    emit(UpdateUserLoading());
    FirebaseFirestore.instance.collection("users").doc(model!.Uid).update({
      "Cover": cover ?? model!.Cover,
      "image": image ?? model!.image,
      "phone": phone,
      "name": name,
      "Bio": bio
    }).then((value) {
      getUserData();
    }).catchError((error) {
      print(error.toString());
      emit(UpdateUserError());
    });
  }

  File? Postphoto;
  void PickPostPhoto() async {
    final ImagePicker picker = ImagePicker();

    try {
      image = await picker.pickImage(source: ImageSource.gallery);
      Postphoto = File(image!.path);
      emit(UpdatePostPhotoSuccess());
    } catch (error) {
      emit(UpdatePostPhotoError());
    }
  }

  void RemovePostphoto() {
    Postphoto = null;
    emit(RemovePostPhoto());
  }

  PostModel? Postmodel;
  void CreatePost({String? postimage, String? text}) {
    emit(CreatePostLoading());
    Postmodel = PostModel(
        name: model!.name,
        image: model!.image,
        DateTime: DateTime.now().toString(),
        Postimage: postimage ?? null.toString(),
        text: text);
    FirebaseFirestore.instance
        .collection("Posts")
        .add(Postmodel!.toMap())
        .then((value) {
      emit(CreatePostSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(CreatePostError());
    });
  }

  void UploadPostImage({String? text}) {
    emit(CreatePostLoading());
    FirebaseStorage.instance
        .ref()
        .child("Postimages/${Uri.file(Postphoto!.path).pathSegments.last}")
        .putFile(Postphoto!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        CreatePost(text: text, postimage: value);
        emit(UpdatePostPhotoSuccess());
      }).catchError((error) {
        print(error.toString());
        emit(UpdatePostPhotoError());
      });
    }).catchError((error) {
      print(error.toString());
      emit(UpdatePostPhotoError());
    });
  }

  List<PostModel> posts = [];
  List<String> PostId = [];
  List<int> Comments = [];
  List<int> Likes = [];
  void GetPosts() {
    FirebaseFirestore.instance
        .collection("Posts")
        .orderBy("DateTime")
        .snapshots()
        .listen((event) {
      posts = [];
      event.docs.forEach((element) {
        PostId.add(element.id);
        posts.add(PostModel.fromJson(element.data()));
        element.reference.collection("comments").get().then((value) {
          Comments.add(event.docs.length);
        emit(GetCommentSuccess());})
            .catchError((error){
              print(error.toString());
              emit(GetCommentError());
        });
        element.reference
          .collection("likes").get().then((value) {
            Likes.add(event.docs.length);
        emit(GetLikesSuccess());})
            .catchError((error){
              print(error.toString());
              emit(GetLikesError());
        });
      });
      emit(GetPostSuccess());
    });
  }
  


  void MakeLike(String postId) {
    FirebaseFirestore.instance
        .collection("Posts")
        .doc(postId)
        .collection("likes")
        .add({"likes": true}).then((value) {
      emit(LikesSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(LikesError());
    });
  }

  void MakeComment(String postId, String comment) {
    FirebaseFirestore.instance
        .collection("Posts")
        .doc(postId)
        .collection("comments")
        .add({
      "comment": comment,
    }).then((value) {
      emit(CommentSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(CommentError());
    });
  }

  List<UserModel> users = [];


  void GetAllUsers() {
    if (users.isEmpty) {
      FirebaseFirestore.instance
          .collection("users")
          .get().then((value) {
        users = [];
        value.docs.forEach((element) {
          if (element.data()["Uid"] != model!.Uid) {
            users.add(UserModel.fromJson(element.data()));
          }
        });
        emit(GetAllUsersSuccess());
      }).catchError((err){
        print(err.toString());
        emit(GetAllUsersError());
      });
    }
  }

  MessageModel? messagemodel;
  void SendMessage(
      {required String text,
      required String ReciverUid,
      required datetime,
      String? image}) {
    messagemodel = MessageModel(
        text: text,
        RecieverUid: ReciverUid,
        SenderUid: model!.Uid!,
        datetime: datetime,
        image: image ?? null.toString());
    FirebaseFirestore.instance
        .collection("users")
        .doc(model!.Uid)
        .collection("chats")
        .doc(ReciverUid)
        .collection("messages")
        .add(messagemodel!.tomap())
        .then((value) {
      emit(SendMessageSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(SendMessageError());
    });
    FirebaseFirestore.instance
        .collection("users")
        .doc(ReciverUid)
        .collection("chats")
        .doc(model!.Uid)
        .collection("messages")
        .add(messagemodel!.tomap())
        .then((value) {
      emit(SendMessageSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(SendMessageError());
    });
  }

  List<MessageModel> messages = [];
  void GetMessage({required reciverUid}) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(model!.Uid)
        .collection("chats")
        .doc(reciverUid)
        .collection("messages")
        .orderBy("datetime")
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessageSuccess());
    });
  }

  File? sendimage;
  void PickSendImage() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    try {
      image = await picker.pickImage(source: ImageSource.gallery);
      sendimage = File(image!.path);
      emit(UpdateProfilePhotoError());
    } catch (error) {
      emit(UpdateProfilePhotoError());
    }
  }

  void SendImage({required text, required ReciverUid, required datetime}) {
    FirebaseStorage.instance
        .ref()
        .child("sendimages/${Uri.file(sendimage!.path).pathSegments.last}")
        .putFile(sendimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        SendMessage(
            text: text,
            ReciverUid: ReciverUid,
            datetime: datetime,
            image: value);
      }).catchError((error) {
        print(error.toString());
        emit(GetImageMessageError());
      });
      emit(GetImageMessageSuccess());
    }).catchError((error) {
      emit(GetImageMessageError());
    });
  }

  void RemoveImage() {
    sendimage = null;
    emit(RemoveSendImage());
  }

  void Signout(context) {
    Preference.sharedPreferences!.remove("Uid").then((value) {
      users=[];
      Preference.sharedPreferences!.remove("onBoarding").
      then((value) {Navigator.pushNamed(context, const LoginScreen().id);}).
      catchError((error){
        print(error.toString());
        emit(SignoutError());
      });
      emit(SignoutSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(SignoutError());
    });
  }

  @override
  void onChange(Change<SocialState> change) {
    // TODO: implement onChange
    super.onChange(change);
    print(change);
  }
}
