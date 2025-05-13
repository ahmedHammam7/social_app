import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Cubit/RegisterCubit/RegisterCubit.dart';
import 'package:social_app/Cubit/RegisterCubit/RegisterState.dart';
import 'package:social_app/Customs/CustomAUTHitem.dart';
import 'package:social_app/Customs/CustomButton.dart';
import 'package:social_app/Customs/CustomTextField.dart';
import 'package:social_app/Screens/HomeLayout.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  final id = "RegisterScreen";
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formkey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String email;
  late String password;
  late String name;
  late String phone;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            Navigator.pushNamed(context, const HomeScreen().id);
          }
        },
        builder: (context, state) => Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                autovalidateMode: autovalidateMode,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Image(
                        image: AssetImage("lib/Assets/signupphoto.png"),
                        height: 230,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Text(
                      "Sign up",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        CustomAuthItem(() {}, "lib/Assets/Google-Symbol.png"),
                        const Spacer(),
                        CustomAuthItem(() {}, "lib/Assets/Facebook-logo.png"),
                        const Spacer(),
                        CustomAuthItem(() {}, "lib/Assets/applelogo.jpeg"),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                        child: Text(
                      "Or, register with email....",
                      style: TextStyle(color: Colors.grey[800]),
                    )),
                    const SizedBox(height: 15),
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
                      height: 10,
                    ),
                    CustomFormTextField(
                      icon: Icons.face,
                      keyboard: TextInputType.text,
                      label: "Full name",
                      onchanged: (value) {
                        name = value;
                      },
                      obsecure: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomFormTextField(
                      icon: Icons.phone_android,
                      keyboard: TextInputType.phone,
                      label: "phone",
                      onchanged: (value) {
                        phone = value;
                      },
                      obsecure: false,
                    ),
                    ConditionalBuilder(
                      condition: true,
                      builder: (context) => CustomButtom(
                        text: "Sign up",
                        ontab: () {
                          if (formkey.currentState!.validate()) {
                            BlocProvider.of<RegisterCubit>(context)
                                .CreateAccountWithEmail(
                                    email, password, name, phone);
                          } else {
                            autovalidateMode = AutovalidateMode.always;
                            setState(() {});
                          }
                        },
                      ),
                      fallback: (context) => CircularProgressIndicator(
                        color: Colors.blue[900],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "already have an account?",
                          style: TextStyle(color: Colors.grey[900]),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Login",
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
