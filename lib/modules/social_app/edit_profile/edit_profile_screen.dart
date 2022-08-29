
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/social_app/cubit/cubit.dart';
import '../../../layout/social_app/cubit/states.dart';
import '../../../shareed/components/compnnents.dart';
import '../../../shareed/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit
            .get(context)
            .userModel;
        var profileImage = SocialCubit
            .get(context)
            .profileImage;
        var coverImage = SocialCubit
            .get(context)
            .coverImage;

        nameController.text = userModel!.name!;
        phoneController.text = userModel.phone!;
        bioController.text = userModel.bio!;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                IconBroken.Arrow___Left_2,
              ),
            ),
            titleSpacing: 5.0,
            title: Text(
              'Edit Profile',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  SocialCubit.get(context).updateUser(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                  );
                },
                child: Text(
                  'Update',
                ),
              ),
              SizedBox(
                width: 15.0,
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is SocialUserUpdateLoadingState)
                    LinearProgressIndicator(),
                  if (state is SocialUserUpdateLoadingState)
                    SizedBox(
                      height: 10.0,
                    ),
                  Container(
                    height: 180.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(
                                      6.0,
                                    ),
                                    topLeft: Radius.circular(
                                      6.0,
                                    ),
                                  ),
                                  image: DecorationImage(
                                    image: coverImage == null
                                        ? NetworkImage(
                                      '${userModel.cover}',
                                    )
                                        : FileImage(coverImage)
                                    as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon: CircleAvatar(
                                    radius: 20.0,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 16.0,
                                    ),
                                  ))
                            ],
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 65.0,
                              backgroundColor:
                              Theme
                                  .of(context)
                                  .scaffoldBackgroundColor,
                              child: CircleAvatar(
                                  radius: 60.0,
                                  backgroundImage: profileImage == null
                                      ? NetworkImage(
                                    '${userModel.image}',
                                  )
                                      : FileImage(profileImage)
                                  as ImageProvider),
                            ),
                            IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getProfileImage();
                                },
                                icon: CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 16.0,
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  if(SocialCubit
                      .get(context)
                      .profileImage != null || coverImage != null)
                    Row(
                      children:
                      [
                        if(SocialCubit
                            .get(context)
                            .profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  function: ()
                                  {
                                    SocialCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,);
                                  },
                                  text: 'Upload Profile',
                                ),
                                if (state is SocialUserUpdateLoadingState)
                                  SizedBox(
                                  height: 5.0,),
                                if (state is SocialUserUpdateLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),

                          ),
                        SizedBox(
                          width: 5.0,
                        ),
                        if(SocialCubit
                            .get(context)
                            .coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  function: ()
                                  {
                                    SocialCubit.get(context).uploadCoverImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,);
                                  },
                                  text: 'Upload Cover',
                                ),
                                if (state is SocialUserUpdateLoadingState)
                                  SizedBox(
                                  height: 5.0,),
                                if (state is SocialUserUpdateLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),

                          ),
                      ],
                    ),
                  if(SocialCubit
                      .get(context)
                      .profileImage != null || coverImage != null)
                    SizedBox(
                      height: 20.0,
                    ),
                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      label: 'name',
                      prefix: IconBroken.User,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultFormField(
                      controller: bioController,
                      type: TextInputType.text,
                      label: 'Bio',
                      prefix: IconBroken.Info_Circle,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'bio must not be empty';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      label: 'phone',
                      prefix: IconBroken.Call,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'phone number must not be empty';
                        }
                        return null;
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
