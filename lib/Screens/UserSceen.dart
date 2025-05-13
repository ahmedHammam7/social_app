import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Cubit/SocialCubit/SocialCubit.dart';
import 'package:social_app/Cubit/SocialCubit/SocialState.dart';
import 'package:social_app/Customs/CustomCard.dart';
import 'package:social_app/Models/UserModel.dart';
import 'package:social_app/Screens/ChatDetailsScreen.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
              child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1,
                crossAxisSpacing: 2,
                mainAxisSpacing: 20,
              ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                itemCount: BlocProvider.of<SocialCubit>(context).users.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) =>CustomCard(model: BlocProvider.of<SocialCubit>(context).users[index],context: context) ,),
            ),
        );
      },
    );
  }
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