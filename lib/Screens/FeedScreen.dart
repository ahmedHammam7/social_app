import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/Cubit/SocialCubit/SocialCubit.dart';
import 'package:social_app/Cubit/SocialCubit/SocialState.dart';
import 'package:social_app/Customs/CustomTextField.dart';
import 'package:social_app/Models/PostModel.dart';
import 'package:social_app/Screens/AddPostScreen.dart';
import 'package:social_app/Screens/SettingScreen.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        var commentController = TextEditingController();
        return ConditionalBuilder(
          condition: (BlocProvider.of<SocialCubit>(context).posts.length>0&&BlocProvider.of<SocialCubit>(context).Likes.length>0) ,
          builder: (context) => Scaffold(
              body: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: false,
                  itemBuilder: (context, index) => BuildFeedItem(
                      context,
                      BlocProvider.of<SocialCubit>(context).posts[index],
                      index,
                      commentController),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 5,
                      ),
                  itemCount:
                      BlocProvider.of<SocialCubit>(context).posts.length)),
          fallback: (context) => const Center(
              child: CircularProgressIndicator(
            color: Colors.blue,
          )),
        );
      },
    );
  }
}

Widget BuildFeedItem(context, PostModel model, index,
        TextEditingController commentController) =>
    SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          const Stack(
            alignment: Alignment.bottomRight,
            children: [
              Card(
                elevation: 5,
                child: Image(
                  image: NetworkImage(
                      "https://img.freepik.com/free-photo/tall-lighthouse-north-sea-cloudy-sky_181624-49637.jpg?w=900&t=st=1691293231~exp=1691293831~hmac=6c862cddbe3d5f9be978d883cb9cd59b306b382e08bce7b2e14b6b2bd3346176"),
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "communicate with friends",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          Card(
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, const SettingScreen().id);
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage("${model.image}"),
                          radius: 24,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${model.name}",
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.check_circle,
                                  color: Colors.blue,
                                  size: 16,
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Text(
                              "${model.DateTime}",
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, const AddPostScreen().id);
                        },
                        icon: const Icon(
                          Icons.add,
                        )),
                    const SizedBox(
                      width: 7,
                    ),
                    const Icon(Icons.more_horiz),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    color: Colors.grey[400],
                    height: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "${model.text}",
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Wrap(
                  children: [
                    SizedBox(
                      width: 70,
                      child: MaterialButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: const Text("#software",
                            style: TextStyle(color: Colors.blue)),
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      child: MaterialButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: const Text("#flutter",
                            style: TextStyle(color: Colors.blue)),
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      child: MaterialButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: const Text("#hammam",
                            style: TextStyle(color: Colors.blue)),
                      ),
                    ),
                    SizedBox(
                      width: 110,
                      child: MaterialButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: const Text("#free_palestine",
                            style: TextStyle(color: Colors.blue)),
                      ),
                    ),
                  ],
                ),
                if (model.Postimage != "null")
                  Card(
                    elevation: 5,
                    child: Image(
                      image: NetworkImage("${model.Postimage}"),
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              FontAwesomeIcons.heart,
                              color: Colors.red,
                              size: 18,
                            ),
                          ),
                          Text(
                              "${BlocProvider.of<SocialCubit>(context).Likes[index]}",

                            style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                FontAwesomeIcons.comment,
                                color: Colors.amber,
                                size: 18,
                              ),
                            ),
                            Text(
                               "${BlocProvider.of<SocialCubit>(context).Comments[index]}",
                             style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.grey[400],
                    width: double.infinity,
                    height: 1,
                  ),
                ),
                Card(
                  margin: EdgeInsets.zero,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage("${model.image}"),
                          radius: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CustomFormTextField(
                                              controller: commentController,
                                              icon: Icons.comment,
                                              keyboard: TextInputType.text,
                                              label: "Write your comment",
                                            ),
                                            const SizedBox(height: 10),
                                            OutlinedButton(
                                                onPressed: () {
                                                  BlocProvider.of<SocialCubit>(
                                                          context)
                                                      .MakeComment(
                                                          BlocProvider.of<
                                                                      SocialCubit>(
                                                                  context)
                                                              .PostId[index],
                                                          commentController
                                                              .text);
                                                },
                                                child: const Text(
                                                  "Comment",
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                "write a comment....",
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w500),
                              )),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            BlocProvider.of<SocialCubit>(context).MakeLike(
                                BlocProvider.of<SocialCubit>(context)
                                    .PostId[index]);
                          },
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  FontAwesomeIcons.heart,
                                  color: Colors.red,
                                  size: 18,
                                ),
                              ),
                              Text(
                                "like",
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
