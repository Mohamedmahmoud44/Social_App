


import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/social_app/cubit/cubit.dart';
import '../../../layout/social_app/cubit/states.dart';
import '../../../models/social_app/user_model.dart';
import '../../../shareed/components/compnnents.dart';
import '../chat_deltills/chat_detalis.dart';

// datTime
class CatsScreen extends StatelessWidget {
  const CatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state){},
      builder: (context, state)
      {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.length > 0,
          builder:(context)=>ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index)=> buildChatItem(SocialCubit.get(context).users[index],context),
            separatorBuilder: (context, index)=> myDivider(),
            itemCount:  SocialCubit.get(context).users.length,) ,
          fallback: (context)=> Center(child: CircularProgressIndicator()),
        );
      },
    );
  }


  Widget buildChatItem(SocialUserModel model, context) => InkWell(
    onTap: ()
    {
      navigateTo(context, ChatDetailsScreen(userModel: model,),);
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(
              '${model.image}',
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: Text(
              '${model.name}',
              style: TextStyle(
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    ),
  );


}

