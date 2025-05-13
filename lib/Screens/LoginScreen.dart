import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Cubit/LoginCubit/LoginCubit.dart';
import 'package:social_app/Cubit/LoginCubit/LoginState.dart';
import 'package:social_app/Customs/CustomAUTHitem.dart';
import 'package:social_app/Customs/CustomButton.dart';
import 'package:social_app/Customs/CustomTextField.dart';
import 'package:social_app/Screens/HomeLayout.dart';
import 'package:social_app/Screens/RegisterScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  final String id = "loginScreen";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.pushNamed(context, const HomeScreen().id);
          }
        },
        builder: (context, state) => Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Form(
                autovalidateMode: autovalidateMode,
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Center(
                        child: Image(
                            image: AssetImage("lib/Assets/loginphoto.png"),
                            fit: BoxFit.cover,
                            height: 250)),
                    const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    CustomFormTextField(
                      icon: Icons.alternate_email,
                      keyboard: TextInputType.emailAddress,
                      label: "Email",
                      onchanged: (value) {
                        email = value;
                      },
                      obsecure: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomFormTextField(
                      icon: Icons.lock_outlined,
                      keyboard: TextInputType.visiblePassword,
                      label: "Password",
                      onchanged: (value) {
                        password = value;
                      },
                      obsecure: true,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ConditionalBuilder(
                      condition: state is! LoginLoadingState && state is! LoginWithGoogleLoading,
                      builder: (context) => CustomButtom(
                        text: "Login",
                        ontab: () {
                          if (formkey.currentState!.validate()) {
                            BlocProvider.of<LoginCubit>(context)
                                .LoginWithEmail(email!, password!);
                          } else {
                            autovalidateMode = AutovalidateMode.always;
                            setState(() {});
                          }
                        },
                      ),
                      fallback: (context) => Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue[900],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                        child: Text(
                      "Or,login with....",
                      style: TextStyle(color: Colors.grey[800]),
                    )),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        CustomAuthItem(() async{
                       await  BlocProvider.of<LoginCubit>(context).LoginWithGoogle();
                        }, "lib/Assets/Google-Symbol.png"),
                        const Spacer(),
                        CustomAuthItem(() {}, "lib/Assets/Facebook-logo.png"),
                        const Spacer(),
                        CustomAuthItem(() {}, "lib/Assets/applelogo.jpeg"),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Dont have an account?",
                          style: TextStyle(color: Colors.grey[900]),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, const RegisterScreen().id);
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(color: Colors.blue[900]),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
