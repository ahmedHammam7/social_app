import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Cubit/SocialCubit/SocialCubit.dart';
import 'package:social_app/Cubit/SocialCubit/SocialState.dart';
import 'package:social_app/Models/UserModel.dart';
import 'package:social_app/Screens/ChatDetailsScreen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  final id="ChatScreen";
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
         BlocProvider.of<SocialCubit>(context).GetAllUsers();
        return BlocConsumer<SocialCubit, SocialState>(
          listener: (context, state) {},
          builder: (context, state) {
            return ConditionalBuilder(
              condition: BlocProvider.of<SocialCubit>(context).users.length > 0,
              builder: (context) => ListView.separated(
                  itemBuilder: (context, index) => BuidUserItem(
                      BlocProvider.of<SocialCubit>(context).users[index],context),
                  separatorBuilder: (context, index) => Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey[300],
                      ),
                  itemCount: BlocProvider.of<SocialCubit>(context).users.length),
              fallback: (context) => const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            );
          },
        );
      }
    );
  }

  Widget BuidUserItem(UserModel model,context) => InkWell(
        onTap: () {
          Navigator.pushNamed(context, ChatDetailsScreen().id,arguments:model );
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage("${model.image}"),
                radius: 24,
              ),
              const SizedBox(width: 10),
              Text(
                "${model.name}",
                textAlign: TextAlign.start,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              )
            ],
          ),
        ),
      );
}
