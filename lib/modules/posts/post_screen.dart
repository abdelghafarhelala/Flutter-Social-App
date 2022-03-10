// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/Cubit/AppCubit.dart';
import 'package:social_app/modules/Cubit/AppStates.dart';

class PostsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var textController = TextEditingController();
        final now = DateTime.now();
       late var postImage = AppCubit.get(context).postImage;
       var model=AppCubit.get(context).model;
        return Scaffold(
          appBar: AppBar(
            title: Title(
              color: Colors.black,
              child: Text('New Post'),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (postImage == null) {
                      AppCubit.get(context).postData(
                          text: textController.text, dateTime: now.toString());
                    } else {
                      AppCubit.get(context).uploadPostImage(
                          text: textController.text, dateTime: now.toString());
                    }
                  },
                  child: Text('Post'))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is AppAddPostLoadingState) LinearProgressIndicator(),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(model.image),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(model.name,
                          style: Theme.of(context).textTheme.subtitle1),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Write what\'s in your Mind ....',
                      border: InputBorder.none,
                    ),
                    controller: textController,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if(postImage !=null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: FileImage(postImage),
                            fit: BoxFit.cover),
                      ),
                    ),
                    CircleAvatar(
                        radius: 20,
                        child: IconButton(
                          onPressed: () {
                            AppCubit.get(context).removePostImage();
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
