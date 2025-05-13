

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_app/Cubit/LoginCubit/LoginState.dart';
import 'package:social_app/SharedPreference/Preference.dart';


class LoginCubit extends Cubit<LoginState>{

  LoginCubit():super(LoginIntialState());



  void LoginWithEmail(String email,String password){
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) async{
      Fluttertoast.showToast(
        msg: "lOGIN SUCCESSFULLY",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
     await Preference.savaData(key: "Uid", value: value.user!.uid);
      emit(LoginSuccessState());
    }).catchError((error){
      Fluttertoast.showToast(
        msg: "Invalid Password or Email",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print(error.toString());
      emit(LoginErrorState());
    });
  }


 LoginWithGoogle()async{
    emit(LoginWithGoogleLoading());
    final GoogleSignInAccount? gUser=await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? gAuth=await gUser!.authentication;
    final Credential=GoogleAuthProvider.credential(
      accessToken: gAuth!.accessToken,
      idToken: gAuth.idToken
    );
    return await FirebaseAuth.instance.signInWithCredential(Credential).then((value) { emit(LoginWithGoogleSuccess());})
        .catchError((error){
          emit(LoginWithGoogleError());
    });



}






  @override
  void onChange(Change<LoginState> change) {
    // TODO: implement onChange
    super.onChange(change);
    print(change);
  }
}