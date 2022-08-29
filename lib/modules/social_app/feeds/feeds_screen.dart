import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/social_app/cubit/cubit.dart';
import '../../../layout/social_app/cubit/states.dart';
import '../../../models/social_app/post_model.dart';
import '../../../shareed/styles/colors.dart';
import '../../../shareed/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
     listener: (context, state){},
     builder: (context, state)
     {
       return  ConditionalBuilder(
         condition: SocialCubit.get(context).posts.length > 0 && SocialCubit.get(context).userModel != null,
         builder:(context)=> SingleChildScrollView(
           physics: BouncingScrollPhysics(),
           child: Column(
             children: [
               Card(
                 clipBehavior: Clip.antiAliasWithSaveLayer,
                 elevation: 10.0,
                 margin: EdgeInsets.all(
                   10.0,
                 ),
                 child: Stack(
                   alignment: AlignmentDirectional.bottomEnd,
                   children: [
                     Image(
                       image: NetworkImage(
                         'https://img.freepik.com/free-photo/happy-young-caucasian-female-wearing-blue-long-sleeved-shirt-making-thumb-up-sign_176420-15015.jpg?w=740&t=st=1658983858~exp=1658984458~hmac=4f056571fff8a4b59054a8530be8e3bfeb80bd21db2c41dc6e67c842c23a4ea0',
                       ),
                       fit: BoxFit.cover,
                       height: 200,
                       width: double.infinity,
                     ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text(
                         'communicate with friends',
                         style: Theme.of(context).textTheme.subtitle1?.copyWith(
                           color: Colors.white,
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
               ListView.separated(
                 shrinkWrap: true,
                 physics: NeverScrollableScrollPhysics(),
                 itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts[index],context, index),
                 separatorBuilder: (context, index) => SizedBox(
                   height: 10.0,
                 ),
                 itemCount: SocialCubit.get(context).posts.length,
               )
             ],
           ),
         ) ,
         fallback: (context)=> Center(child: CircularProgressIndicator()),
       );
     },
    );
  }

  Widget buildPostItem(PostModel model  , context, index ) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10.0,
        margin: EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                      '${model.image}'
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: TextStyle(
                                height: 1.4,
                              ),
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Icon(
                              Icons.check_circle,
                              size: 16.0,
                              color: defaultColor,
                            ),
                          ],
                        ),
                        Text(
                          '${model.dateTime}',
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              ?.copyWith(height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz,
                      size: 20,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${model.text}',
                style: TextStyle(
                  height: 1.4,
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //     bottom: 10.0,
              //     top: 5.0,
              //   ),
              //   child:
              //   Container(
              //     width: double.infinity,
              //     child:
              //     Wrap(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(
              //             end: 6.0,
              //           ),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: Text('#software',
              //                   style: Theme.of(context)
              //                       .textTheme
              //                       .caption
              //                       ?.copyWith(
              //                         color: defaultColor,
              //                       )),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              if(model.postImage != '')
                Padding(
                padding: const EdgeInsets.only(top: 15.0,),
                child: Container(
                  height: 140.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      4.0,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        '${model.postImage}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Heart,
                                size: 16.0,
                                color: Colors.cyan,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '${SocialCubit.get(context).likes[index]}',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                IconBroken.Chat,
                                size: 16.0,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '0 comment',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18.0,
                            backgroundImage: NetworkImage(
                              '${SocialCubit.get(context).userModel!.image}',
                            ),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            'Write a comment...',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      onTap: ()
                      {

                      },
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 16.0,
                          color: Colors.cyan,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    onTap: ()
                    {
                      SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
