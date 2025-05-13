import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Cubit/SocialCubit/SocialCubit.dart';
import 'package:social_app/Cubit/SocialCubit/SocialState.dart';
import 'package:social_app/Customs/CustomButton.dart';
import 'package:social_app/Customs/CustomTextField.dart';
import 'package:social_app/Models/UserModel.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});
  final id = "EditScreen";
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        UserModel model = BlocProvider.of<SocialCubit>(context).model!;
        var Profileimage = BlocProvider.of<SocialCubit>(context).Profilephoto;
        var Coverimage = BlocProvider.of<SocialCubit>(context).Coverphoto;
        var NameController = TextEditingController();
        var BioController = TextEditingController();
        var PhoneController = TextEditingController();
        PhoneController.text = model.phone!;
        NameController.text = model.name!;
        BioController.text = model.Bio!;

        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
              title: const Text("Edit Profile",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextButton(
                    onPressed: () {
                      BlocProvider.of<SocialCubit>(context).UpdateUserData(
                          name: NameController.text,
                          phone: PhoneController.text,
                          bio: BioController.text);
                    },
                    child: const Text("Update",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(children: [
                if (state is UpdateUserLoading)
                  const LinearProgressIndicator(
                    color: Colors.blue,
                  ),
                SizedBox(
                  height: 190,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Card(
                          elevation: 10,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Image(
                                image: Coverimage != null
                                    ? FileImage(Coverimage) as ImageProvider
                                    : NetworkImage(model.Cover!),
                                width: double.infinity,
                                height: 140,
                                fit: BoxFit.cover,
                              ),
                              IconButton(
                                  onPressed: () {
                                    BlocProvider.of<SocialCubit>(context)
                                        .PickCoverPhoto();
                                  },
                                  icon: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.blue,
                                  ))
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                backgroundImage: Profileimage != null
                                    ? FileImage(Profileimage) as ImageProvider
                                    : NetworkImage(model.image!),
                                radius: 60,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  BlocProvider.of<SocialCubit>(context)
                                      .PickProfilePhoto();
                                },
                                icon: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.blue,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  model.name!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22),
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
                if (Profileimage != null || Coverimage != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        if (Profileimage != null)
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton(
                                      onPressed: () {
                                        BlocProvider.of<SocialCubit>(context)
                                            .UploadProfileImage(
                                                name: NameController.text,
                                                phone: PhoneController.text,
                                                bio: BioController.text);
                                      },
                                      child: const Text(
                                        "Update Profile",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                if(state is UpdateProfileLoading)
                                const LinearProgressIndicator(
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (Coverimage != null)
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton(
                                      onPressed: () {
                                        BlocProvider.of<SocialCubit>(context)
                                            .UploadCoverImage(
                                                name: NameController.text,
                                                phone: PhoneController.text,
                                                bio: BioController.text);
                                      },
                                      child: const Text(
                                        "Update Cover",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                             const   SizedBox(
                                  height: 5,
                                ),
                              if(state is UpdateCoverLoading)
                              const  LinearProgressIndicator(
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      CustomFormTextField(
                        icon: Icons.edit,
                        controller: NameController,
                        keyboard: TextInputType.text,
                        label: "Name",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormTextField(
                        icon: Icons.man,
                        controller: BioController,
                        keyboard: TextInputType.text,
                        label: "Bio",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormTextField(
                        icon: Icons.phone,
                        controller: PhoneController,
                        keyboard: TextInputType.phone,
                        label: "phone",
                      ),
                    ],
                  ),
                ),
              ]),
            ));
      },
    );
  }
}
