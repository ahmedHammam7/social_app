import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/Cubit/SocialCubit/SocialCubit.dart';
import 'package:social_app/Cubit/SocialCubit/SocialState.dart';
import 'package:social_app/Models/MessageModel.dart';
import 'package:social_app/Models/UserModel.dart';

class ChatDetailsScreen extends StatelessWidget {
  const ChatDetailsScreen({super.key});
  final id = "ChatDetailsScreen";
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        var model = ModalRoute.of(context)!.settings.arguments as UserModel;
        BlocProvider.of<SocialCubit>(context).GetMessage(reciverUid:model.Uid);
        return BlocConsumer<SocialCubit, SocialState>(
          listener: (context, state) {},
          builder: (context, state) {
            var controller = TextEditingController();
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                elevation: 0.0,
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage("${model.image}"),
                      radius: 20,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "${model.name}",
                      style: const TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ConditionalBuilder(
                        condition: BlocProvider.of<SocialCubit>(context).messages.length>0,
                        builder:(context) => ListView.separated(
                            itemBuilder: (context, index) {
                              if(BlocProvider.of<SocialCubit>(context).model!.Uid==BlocProvider.of<SocialCubit>(context).messages[index].SenderUid)
                                return BuildMyMessageItem(BlocProvider.of<SocialCubit>(context).messages[index]);

                              return BuildRecMessageItem(BlocProvider.of<SocialCubit>(context).messages[index]);

                            },
                            separatorBuilder: (context, index) =>
                            const SizedBox(height: 15),
                            itemCount: BlocProvider.of<SocialCubit>(context).messages.length),
                        fallback: (context) => const Center(child: CircularProgressIndicator(
                          color: Colors.blue,
                        )),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                         border:Border.all(color: Colors.grey,),
                        borderRadius: BorderRadius.circular(15)
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: controller,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Write your message....",
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[500],
                                      fontSize: 14)),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                            child: IconButton(
                                onPressed: () {
                                  if (BlocProvider.of<SocialCubit>(context)
                                          .sendimage !=
                                      null) {
                                    BlocProvider.of<SocialCubit>(context).SendImage(
                                        text: controller.text,
                                        ReciverUid: model.Uid!,
                                        datetime: DateTime.now().toString());
                                    BlocProvider.of<SocialCubit>(context).RemoveImage();
                                  } else {
                                    BlocProvider.of<SocialCubit>(context)
                                        .SendMessage(
                                            text: controller.text,
                                            ReciverUid: model.Uid!,
                                            datetime: DateTime.now().toString());
                                    BlocProvider.of<SocialCubit>(context).RemoveImage();
                                  }
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.solidPaperPlane,
                                  color: Colors.blue,
                                )),
                          ),
                          SizedBox(
                            width: 40,
                            child: IconButton(
                                onPressed: () {
                                  BlocProvider.of<SocialCubit>(context)
                                      .PickSendImage();
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.image,
                                  color: Colors.blue,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    );
  }
}

Widget BuildMyMessageItem(MessageModel model) => Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              bottomStart: Radius.circular(10),
              topEnd: Radius.circular(10),
            )),
        child: Column(
          children: [

            Text("${model.text}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            if (model.image != null.toString())
              Image(image: NetworkImage(model.image))
          ],
        ),
      ),
    );
Widget BuildRecMessageItem(MessageModel model) => Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.blue[200],
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              bottomStart: Radius.circular(10),
              topEnd: Radius.circular(10),
            )),
        child: Column(
          children: [
            Text("${model.text}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            if(model.image!=null.toString())
              Image(image: NetworkImage(model.image))
          ],
        ),
      ),
    );

