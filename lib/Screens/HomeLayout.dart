import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Cubit/SocialCubit/SocialCubit.dart';
import 'package:social_app/Cubit/SocialCubit/SocialState.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/Screens/AddPostScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  final id = "HomeScreen";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {
          if(state is AddPostState){
            Navigator.pushNamed(context, AddPostScreen().id);
          }
        },
        builder: (context, state) => Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context,const AddPostScreen().id);
                      },
                      icon: const Icon(
                        FontAwesomeIcons.add,
                        color: Colors.black,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        FontAwesomeIcons.bell,
                        color: Colors.black,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          FontAwesomeIcons.magnifyingGlass,
                          color: Colors.black,
                        )),
                  ),

                ],
                backgroundColor: Colors.white,
                titleTextStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
                elevation: 0,
                title: Text(
                  BlocProvider.of<SocialCubit>(context).titles[
                      BlocProvider.of<SocialCubit>(context).currentIndex],
                ),
              ),
              body: BlocProvider.of<SocialCubit>(context)
                  .Screens[BlocProvider.of<SocialCubit>(context).currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex:
                    BlocProvider.of<SocialCubit>(context).currentIndex,
                onTap: (value) {
                  BlocProvider.of<SocialCubit>(context).BottomNavChange(value);},
                showUnselectedLabels: true,
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
                fixedColor: Colors.blue,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.house),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.solidComment),
                    label: "Chat",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.users),
                    label: "Users",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.gear),
                    label: "Setting",
                  ),
                ],
              ),
            ));
  }
}
