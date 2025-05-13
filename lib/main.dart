import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Cubit/SocialCubit/SocialCubit.dart';
import 'package:social_app/Screens/AddPostScreen.dart';
import 'package:social_app/Screens/ChatDetailsScreen.dart';
import 'package:social_app/Screens/ChatSceen.dart';
import 'package:social_app/Screens/EditScreen.dart';
import 'package:social_app/Screens/HomeLayout.dart';
import 'package:social_app/Screens/LoginScreen.dart';
import 'package:social_app/Screens/OnBoarding.dart';
import 'package:social_app/Screens/RegisterScreen.dart';
import 'package:social_app/Screens/SettingScreen.dart';
import 'package:social_app/SharedPreference/Preference.dart';

import 'firebase_options.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("on background message");
  print(message.data.toString());
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var MSSGtoken=await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
  });
  FirebaseMessaging.onBackgroundMessage((message) =>  firebaseMessagingBackgroundHandler(message));

  await Preference.init();

  var Uid = Preference.getData(key: "Uid");
  var onBoarding = Preference.getData(key: "onBoarding");
  late Widget startWidget;

  if (onBoarding != null) {
     if (Uid != null) {
       startWidget = const HomeScreen();
     } else if(Uid==null) {
       startWidget = const LoginScreen();
     }
  } else if(onBoarding==null) {

    startWidget = const OnBoarding();
  }
  runApp(SocialApp(
    widget: startWidget,
  ));

 var token= FirebaseMessaging.instance.getToken();
 FirebaseMessaging.onMessage.listen((event) {
   print("hello");
 });
}

class SocialApp extends StatelessWidget {
  const SocialApp({
    super.key,
    required this.widget,

  });
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context) => SocialCubit()..getUserData()..GetPosts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: widget,
        routes: {
          const SettingScreen().id:(context) => const SettingScreen(),
          const AddPostScreen().id:(context) => const AddPostScreen(),
          const HomeScreen().id: (context) => const HomeScreen(),
          const OnBoarding().id: (context) => const OnBoarding(),
          const LoginScreen().id: (context) => const LoginScreen(),
          const RegisterScreen().id: (context) => const RegisterScreen(),
          const EditScreen().id:(context) => const EditScreen(),
          const ChatDetailsScreen().id:(context) => const ChatDetailsScreen(),
          const ChatScreen().id:(context) => const ChatScreen(),
        },
      ),
    );
  }
}
