import 'dart:io';


import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/social_app/cubit/states.dart';

import '../../../models/social_app/massage_model.dart';
import '../../../models/social_app/post_model.dart';
import '../../../models/social_app/user_model.dart';
import '../../../modules/social_app/chats/chats_screen.dart';
import '../../../modules/social_app/feeds/feeds_screen.dart';
import '../../../modules/social_app/new_post/new_post_screen.dart';
import '../../../modules/social_app/settings/setting_screen.dart';
import '../../../modules/social_app/users/users_screen.dart';
import '../../../shareed/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// dateTime

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      // print(value.data());
      userModel = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    CatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> tittle = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 1) getUsers();
    if (index == 2)
      emit(SocialNewPostState());
    else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File? coverImage;

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('no image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('no image selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  // void updateImages({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(SocialUserUpdateLoadingState());
  //
  //   if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (coverImage != null && profileImage != null) {
  //   } else {
  //     updateUser(
  //       name: name,
  //       phone: phone,
  //       bio: bio,
  //     );
  //   }
  // }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel!.email,
      image: image ?? userModel!.image,
      cover: cover ?? userModel!.cover,
      uId: userModel!.uId,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      print(error.toString());
      print(uId);

      emit(SocialUserUpdateErrorState());
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('no image selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost(
      {required String dateTime, required String text, String? postImage}) {
    emit(SocialCreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!.image,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
      });

      emit(SocialGetPostSuccessState());
    }).catchError((error) {
      emit(SocialGetPostErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users = [];

  void getUsers() {
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel!.uId)
            users.add(SocialUserModel.fromJson(element.data()));
        });

        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
  }

  // void sendMassage({
  //   required String receiverId,
  //   required String datTime,
  //   required String text,
  // }) {
  //   MassageModel model = MassageModel(
  //     senderId: userModel!.uId,
  //     receiverId: receiverId,
  //     datTime: datTime,
  //     text: text,
  //   );
  //
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userModel!.uId)
  //       .collection('chats')
  //       .doc(receiverId)
  //       .collection('massage')
  //       .add(model.toMap())
  //       .then((value) {
  //     emit(SocialSendMassageSuccessState());
  //   }).catchError((error) {
  //     emit(SocialSendMassageErrorState());
  //   });
  //
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(receiverId)
  //       .collection('chats')
  //       .doc(userModel!.uId)
  //       .collection('massage')
  //       .add(model.toMap())
  //       .then((value) {
  //     emit(SocialSendMassageSuccessState());
  //   }).catchError((error) {
  //     emit(SocialSendMassageErrorState());
  //   });
  // }
  //
  // List<MassageModel> massages = [];
  //
  // void getMassages({
  //   required String receiverId,
  // })
  // {
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userModel!.uId)
  //       .collection('chats')
  //       .doc(receiverId)
  //       .collection('massage')
  //       .snapshots()
  //       .listen((event)
  //   {
  //
  //     massages = [];
  //
  //     event.docs.forEach((element)
  //     {
  //       massages.add(MassageModel.fromJson(element.data()));
  //     });
  //     emit(SocialGetMassageSuccessState());
  //   });
  // }


void sendMessage({
  required String receiverId,
  required String dateTime,
  required String text,
})
{
  MessageModel model = MessageModel(
    senderId: userModel!.uId,
    receiverId: receiverId,
    dateTime: dateTime,
    text: text
  );

  FirebaseFirestore.instance
  .collection('users')
  .doc(userModel!.uId)
  .collection('chats')
  .doc(receiverId)
  .collection('messages')
  .add(model.toMap())
  .then((value)
  {
    emit(SocialSendMessageSuccessState());
  })
  .catchError((error)
  {
    emit(SocialSendMessageErrorState());
  });

  FirebaseFirestore.instance
      .collection('users')
      .doc(receiverId)
      .collection('chats')
      .doc(userModel!.uId)
      .collection('messages')
      .add(model.toMap())
      .then((value)
  {
    emit(SocialSendMessageSuccessState());
  })
      .catchError((error)
  {
    emit(SocialSendMessageErrorState());
  });


}



List<MessageModel> message=[];


  void getMessage({
    required String receiverId,
  })
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .snapshots()
        .listen((event)
    {
      message=[];

      event.docs.forEach((element)
      {
        message.add(MessageModel.fromJson(element.data()));
      });

      emit(SocialGetMessageSuccessState());
    });
        
  }

}
