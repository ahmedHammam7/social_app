import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_app/Models/onBoardingModel.dart';
import 'package:social_app/Screens/LoginScreen.dart';
import 'package:social_app/SharedPreference/Preference.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});
 final id="onboarding";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                itemBuilder: (context, index) =>
                    onBoardingBuilder(onboardinglist[index],context),
                controller: controller,
                itemCount: onboardinglist.length),
          ),
        ],
      ),
    );
  }
}

PageController controller = PageController();
Widget onBoardingBuilder(onBoardingModel model,context) =>
    Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    const  Spacer(),
      Image(image: AssetImage("${model.image}")),
    const  Spacer(),
      Text(
        model.title,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
      ),
    const  SizedBox(
        height: 30,
      ),
      Text(
        model.desc,
        style: TextStyle(color: Colors.grey[700], fontSize: 16),
      ),
   const   Spacer(flex: 2),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            SmoothPageIndicator(
              axisDirection: Axis.horizontal,
              controller: controller,
              count: onboardinglist.length,
              effect:const ExpandingDotsEffect(
                dotColor: Colors.black,
                activeDotColor: Colors.deepPurple,
                dotHeight: 10,
                expansionFactor: 4,
                dotWidth: 10,
                spacing: 5,
              ),
            ),
            const Spacer(),
            TextButton(
                onPressed: () {
                 Preference.savaData(key: "onBoarding", value: true).then((value) {
                   if(value){
                     Navigator.pushNamed(context,const LoginScreen().id);
                   }
                 });

                },
                child: const Text(
                  "Skip",
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
          ],
        ),
      )
    ]);

List<onBoardingModel> onboardinglist = [
  onBoardingModel(
      image: "lib/Assets/onboarding1.png",
      desc: "chat with your friends and post with them ",
      title: "Texting With Her"),
  onBoardingModel(
      image: "lib/Assets/onboarding2.png",
      title: "Say Hello To Other",
      desc: "chat with your friends and post with them"),
  onBoardingModel(
      image: "lib/Assets/onboarding33.png",
      title: "Talk To Other",
      desc: "Chat with your friends and post with them"),
];
