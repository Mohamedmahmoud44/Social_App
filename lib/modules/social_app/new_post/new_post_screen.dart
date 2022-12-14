import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/social_app/cubit/cubit.dart';
import '../../../layout/social_app/cubit/states.dart';
import '../../../shareed/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {


  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
            title: Text(
              'Create Post',
            ),
            actions: [
              TextButton(
                onPressed: ()
                {

                  var now = DateTime.now();

                  if(SocialCubit.get(context).postImage==null)
                  {
                    SocialCubit.get(context).createPost(
                        dateTime: now.toString(),
                        text: textController.text,
                    );
                  }else
                    {
                      SocialCubit.get(context).uploadPostImage(
                          dateTime: now.toString(),
                          text: textController.text,
                      );
                    }
                },
                child: Text('Post'),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  SizedBox(height: 10.0,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-photo/happy-female-college-student-showing-thumbs-up-isolated_231208-10405.jpg?w=740&t=st=1658984850~exp=1658985450~hmac=c00a3152be46634d5d0f6e4c41a1c5e35e57e394c2140eaef91b866cadd89d37',
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        'Mohamed Mahmoud',
                        style: TextStyle(
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'What is on your mind ...,',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 25.0,),
                if(SocialCubit.get(context).postImage!= null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 140.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0,),
                        image: DecorationImage(
                          image:  FileImage(SocialCubit.get(context).postImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          SocialCubit.get(context).removePostImage();
                        },
                        icon: CircleAvatar(
                          radius: 20.0,
                          child: Icon(
                            Icons.close,
                            size: 16.0,
                          ),
                        ))
                  ],
                ),
                SizedBox(height: 25.0,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: ()
                        {
                          SocialCubit.get(context).getPostImage();
                        },
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Icon(
                                IconBroken.Image
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'Add Photo',
                            ),
                          ],
                        ),


                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          '# Tags',
                        ),


                      ),
                    ),
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
