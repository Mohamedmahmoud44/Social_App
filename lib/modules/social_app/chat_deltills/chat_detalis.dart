// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:first_project/layout/social_app/cubit/cubit.dart';
// import 'package:first_project/layout/social_app/cubit/states.dart';
// import 'package:first_project/models/social_app/massage_model.dart';
// import 'package:first_project/models/social_app/user_model.dart';
// import 'package:first_project/shareed/styles/colors.dart';
// import 'package:first_project/shareed/styles/icon_broken.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class ChatDetailsScreen extends StatelessWidget {
//   SocialUserModel? userModel;
//
//   ChatDetailsScreen({this.userModel});
//
//   var massageController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Builder(
//       builder: (BuildContext context) {
//         SocialCubit.get(context).getMessage(receiverId: userModel!.uId!);
//         return BlocConsumer<SocialCubit, SocialStates>(
//           listener: (context, state) {},
//           builder: (context, state) {
//             return Scaffold(
//               appBar: AppBar(
//                 titleSpacing: 0.0,
//                 title: Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 20.0,
//                       backgroundImage: NetworkImage(
//                         userModel!.image!,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 15.0,
//                     ),
//                     Text(
//                       userModel!.name!,
//                     ),
//                   ],
//                 ),
//               ),
//               body: ConditionalBuilder(
//                 condition: SocialCubit.get(context).message.length > 0,
//                 builder: (context) => Padding(
//                   padding: const EdgeInsets.all(
//                     20.0,
//                   ),
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: ListView.separated(
//                           itemBuilder: (context, index)
//                           {
//                             var massage = SocialCubit.get(context).message[index];
//                             if(SocialCubit.get(context).userModel == massage.senderId)
//                               return buildMyMassage(massage);
//
//                             return buildMassage(massage);
//
//                           },
//                           separatorBuilder: (context, index)=>SizedBox(
//                             height: 15.0,
//                           ),
//                           itemCount: SocialCubit.get(context).message.length,
//                         ),
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.grey.withOpacity(
//                               .4,
//                             ),
//                             width: 1.0,
//                           ),
//                           borderRadius: BorderRadius.circular(
//                             10.0,
//                           ),
//                         ),
//                         clipBehavior: Clip.antiAliasWithSaveLayer,
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: TextFormField(
//                                 controller: massageController,
//                                 decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: 'type your massage ...',
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               height: 40.0,
//                               width: 50.0,
//                               color: defaultColor,
//                               child: MaterialButton(
//                                 onPressed: () {
//                                   SocialCubit.get(context).sendMessage(
//                                     receiverId: userModel!.uId!,
//                                     dateTime: DateTime.now().toString(),
//                                     text: massageController.text,
//                                   );
//                                 },
//                                 child: Icon(
//                                   IconBroken.Send,
//                                   size: 16,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 fallback: (context) =>
//                     Center(child: CircularProgressIndicator()),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   Widget buildMassage(MessageModel model) => Align(
//         alignment: AlignmentDirectional.centerStart,
//         child: Container(
//           padding: EdgeInsets.symmetric(
//             horizontal: 10.0,
//             vertical: 5.0,
//           ),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadiusDirectional.only(
//               topStart: Radius.circular(10.0),
//               topEnd: Radius.circular(10.0),
//               bottomEnd: Radius.circular(10.0),
//             ),
//             color: Colors.grey[300],
//           ),
//           child: Text(
//             model.text!,
//           ),
//         ),
//       );
//
//   Widget buildMyMassage(MessageModel model) => Align(
//         alignment: AlignmentDirectional.centerEnd,
//         child: Container(
//           padding: EdgeInsets.symmetric(
//             horizontal: 10.0,
//             vertical: 5.0,
//           ),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadiusDirectional.only(
//               topStart: Radius.circular(10.0),
//               topEnd: Radius.circular(10.0),
//               bottomStart: Radius.circular(10.0),
//             ),
//             color: defaultColor.withOpacity(
//               0.4,
//             ),
//           ),
//           child: Text(
//             model.text!,
//           ),
//         ),
//       );
// }

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/social_app/cubit/cubit.dart';
import '../../../layout/social_app/cubit/states.dart';
import '../../../models/social_app/massage_model.dart';
import '../../../models/social_app/user_model.dart';
import '../../../shareed/styles/colors.dart';
import '../../../shareed/styles/icon_broken.dart';

// flutter create .

class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel? userModel;

  ChatDetailsScreen({this.userModel});

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context)
    {
      SocialCubit.get(context).getMessage(receiverId: userModel!.uId!);

      return  BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 1.0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      userModel!.image!,
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(userModel!.name!),
                ],
              ),
            ),
            body: ConditionalBuilder(
              // condition: SocialCubit.get(context).message.length > 0,
              condition: true,
              builder: (context)=>Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                   Expanded(
                     child: ListView.separated(
                       itemBuilder: (context, index)
                       {
                         var message =SocialCubit.get(context).message[index];
                         if(SocialCubit.get(context).userModel!.uId == message.senderId)
                           return buildMyMessage(message);
                         return buildMessage(message);
                       },
                       separatorBuilder: (context, index)=> SizedBox(height: 15,),
                       itemCount: SocialCubit.get(context).message.length,
                     ),
                   ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.withOpacity(
                            .4,
                          ),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                              ),
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'type your massage ...',
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 40.0,
                            width: 50.0,
                            color: defaultColor,
                            child: MaterialButton(
                              onPressed: () {
                                SocialCubit.get(context).sendMessage(
                                  receiverId: userModel!.uId!,
                                  dateTime: DateTime.now().toString(),
                                  text: messageController.text,
                                );
                              },
                              child: Icon(
                                IconBroken.Send,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              fallback: (context)=> Center(child: CircularProgressIndicator()),
            )
          );
        },
      );
    },

    );
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              bottomEnd: Radius.circular(10.0),
            ),
            color: Colors.grey[300],
          ),
          child: Text(
            model.text!,
          ),
        ),
      );

  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              bottomStart: Radius.circular(10.0),
            ),
            color: defaultColor.withOpacity(
              0.4,
            ),
          ),
          child: Text(
            model.text!,
          ),
        ),
      );
}
