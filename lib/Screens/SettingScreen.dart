import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/Cubit/SocialCubit/SocialCubit.dart';
import 'package:social_app/Cubit/SocialCubit/SocialState.dart';
import 'package:social_app/Screens/EditScreen.dart';


class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});
final id="SettingScreen";
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        BlocProvider.of<SocialCubit>(context).getUserData();
        return BlocConsumer<SocialCubit, SocialState>(
          listener: (context, state) {},
          builder: (context, state) {
            var model = BlocProvider
                .of<SocialCubit>(context)
                .model;

            return Scaffold(
              body: ConditionalBuilder(
                condition:state is! LoadingSocialState,
                builder: (context) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 190,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topCenter,
                                child: Card(
                                  elevation: 10,
                                  child: Image(
                                    image: NetworkImage(model!.Cover!),
                                    width: double.infinity,
                                    height: 140,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: CircleAvatar(
                                  radius: 64,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(model.image!),
                                    radius: 60,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          model.name!,
                          style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          model.Bio!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 26),
                                child: InkWell(
                                  child: Column(
                                    children: [
                                      const Text("100", style: TextStyle(
                                          fontSize: 14, fontWeight: FontWeight.bold),),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text("Posts", style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.grey[700]),)
                                    ],
                                  ), onTap: () {

                                },),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 26),
                                child: InkWell(
                                  child: Column(
                                    children: [
                                      const Text("350", style: TextStyle(
                                          fontSize: 14, fontWeight: FontWeight.bold),),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text("Photos", style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.grey[700]),)
                                    ],
                                  ), onTap: () {

                                },),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 26),
                                child: InkWell(
                                  child: Column(
                                    children: [
                                      const Text("90k", style: TextStyle(
                                          fontSize: 14, fontWeight: FontWeight.bold),),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text("Followers", style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.grey[700]),)
                                    ],
                                  ), onTap: () {

                                },),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 26),
                                child: InkWell(
                                  child: Column(
                                    children: [
                                      const Text("52", style: TextStyle(
                                          fontSize: 14, fontWeight: FontWeight.bold),),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text("Following", style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.grey[700]),)
                                    ],
                                  ), onTap: () {

                                },),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                    onPressed:
                                        () {},
                                    child: const Text("Add Photos", style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),)),
                              ),
                              const SizedBox(width: 10),
                              OutlinedButton(onPressed: () {
                                Navigator.pushNamed(context, const EditScreen().id);
                              },
                                  child: const Icon(
                                    FontAwesomeIcons.penToSquare, size: 16,)),

                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                                onPressed:
                                    () {
                                  BlocProvider.of<SocialCubit>(context).Signout(context);
                                },
                                child: const Text("Sign out ", style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),)),
                          ),
                        ), ],
                    ),
                  );
                },
                fallback:(context) => const Center(child: CircularProgressIndicator(
                  color: Colors.blue,
                )),
              ),
            );
          },
        );
      }
    );
  }}