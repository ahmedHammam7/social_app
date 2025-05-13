import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/Cubit/SocialCubit/SocialCubit.dart';
import 'package:social_app/Cubit/SocialCubit/SocialState.dart';
import 'package:social_app/Models/UserModel.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});
  final id = "addPostScreen";
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialCubit, SocialState>(
      builder: (context, state) {
       var PostImage=BlocProvider.of<SocialCubit>(context).Postphoto;
        UserModel model = BlocProvider.of<SocialCubit>(context).model!;
        var controller=TextEditingController();
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            elevation: 0,
            backgroundColor: Colors.white,
            title: const Text("Create Post",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            actions: [
              TextButton(
                  onPressed: () {
                    if(PostImage==null){
                      BlocProvider.of<SocialCubit>(context).CreatePost(text: controller.text);
                    }
                    else {
                      BlocProvider.of<SocialCubit>(context).UploadPostImage(text: controller.text);
                    }
                  },
                  child: const Text(
                    "Post",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is CreatePostLoading)
          const   SizedBox(
               height: 10,
               child:  LinearProgressIndicator(
                 color: Colors.blue,
               ),
             ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child:  CircleAvatar(
                        backgroundImage: NetworkImage(
                            "${model.image}"),
                        radius: 24,
                      ),
                    ),
                   const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${model.name}",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ],
                ),
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                   hintText: "what is on your mind...",hintStyle: TextStyle(
                    color: Colors.grey[600],fontWeight: FontWeight.bold,fontSize: 14
                  )
                  ),
                ),
              ),
                if(PostImage!=null)
                Card(
                  elevation: 10,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image(
                        image:
                             FileImage(PostImage),
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                      IconButton(
                          onPressed: () {
BlocProvider.of<SocialCubit>(context).RemovePostphoto();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.blue,
                          ))
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(onPressed: () {
                        BlocProvider.of<SocialCubit>(context).PickPostPhoto();
                      }, child:const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.image,color: Colors.blue,),
                          SizedBox(width: 10,),
                          Text("add photos",style: TextStyle(
                            color: Colors.blue,fontWeight: FontWeight.bold
                          )),
                        ],
                      )),
                    ),
                   Expanded(
                     child: TextButton(onPressed: () {
                     }, child:const Text("# tags",style: TextStyle(color: Colors.blue),)),
                   )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
