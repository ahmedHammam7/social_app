import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/Cubit/RegisterCubit/RegisterState.dart';
import 'package:social_app/Models/UserModel.dart';

import '../../SharedPreference/Preference.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterIntialState());

  void CreateAccountWithEmail(
      String email, String password, String name, String phone) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      await Preference.savaData(key: "Uid", value: value.user!.uid);
      Fluttertoast.showToast(
        msg: "Register SUCCESSFULLY",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      UserModel? model = UserModel(
          phone: phone,
          name: name,
          email: email,
          Uid: Preference.getData(key: "Uid").toString(),
          isVerfied: false,
          image:
              "https://img.freepik.com/free-photo/excited-beautiful-girl-smiling-pointing-fingers-upper-left-corner-looking-pleased-logo_1258-19008.jpg?w=740&t=st=1691293958~exp=1691294558~hmac=8c6723d95ef2f1b85ca2a3805d9d88b20565c9a895363b1a076cc5273e9484e6",
          Bio: "write your bio....",
          Cover:
              "https://img.freepik.com/free-photo/beautiful-portrait-teenager-woman_23-2149453395.jpg?w=900&t=st=1691310229~exp=1691310829~hmac=7839be10f377299e4e6a44fd03b7be7559f0c69b518259e3688b1b7d57c552d6");
      FirebaseFirestore.instance
          .collection("users")
          .doc(model.Uid)
          .set(model.toMap())
          .then((value) {
        emit(UserADDtoFireStoreSuccess());
      }).catchError((error) {
        print(error.toString());
      });
      emit(RegisterSuccessState());
    }).catchError((error) {
      Fluttertoast.showToast(
        msg: "some thing error",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print(error.toString());
      emit(RegisterErrorState());
    });
  }

  @override
  void onChange(Change<RegisterState> change) {
    // TODO: implement onChange
    super.onChange(change);
    print(change);
  }
}
