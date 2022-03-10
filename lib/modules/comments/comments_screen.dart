// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/Cubit/AppCubit.dart';
import 'package:social_app/modules/Cubit/AppStates.dart';

class CommentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
      var commentController=TextEditingController();
      var commentImage=AppCubit.get(context).commentImage;
       final now = DateTime.now();
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(onPressed: (){
                AppCubit.get(context).CommentData(text: commentController.text, dateTime: now.toString());
              }, child: Text('COMMENT'))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
            children: [
              Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 1),
                                child: Row(
                                  children: [
                                    IconButton( icon:Icon(Icons.favorite_border_outlined,color: Colors.red,size: 20,),
                                     onPressed: () {
                                      //  AppCubit.get(context).likePost(AppCubit.get(context).postsId[index]);
                                       },  ),
                                    Text('11',
                                    style: Theme.of(context).textTheme.caption,
                                    )
                                  ],
                                ),
                              ),
                              onTap: (){},
                            ),
                          ), 
                        ],
                      ),
                    ),
                    Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Write You Comment ....',
                        border: InputBorder.none,
                      ),
                      controller: commentController,
                    ),
                  ),
                   SizedBox(
                  height: 20,
                ),
                if(commentImage !=null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: FileImage(commentImage),
                            fit: BoxFit.cover),
                      ),
                    ),
                    CircleAvatar(
                        radius: 20,
                        child: IconButton(
                          onPressed: () {
                            AppCubit.get(context).removeCommentImage();
                          },
                          icon: Icon(Icons.close),
                        )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          AppCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.photo_library_outlined),
                            Text(
                              'add Photo',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'tages',
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