// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Shared/Componentes/Componentes.dart';
import 'package:social_app/modules/Cubit/AppCubit.dart';
import 'package:social_app/modules/Cubit/AppStates.dart';
import 'package:social_app/modules/Models/post_model.dart';
import 'package:social_app/modules/comments/comments_screen.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder:(context, state) {
        return ConditionalBuilder(
          condition: AppCubit.get(context).postes !=null,
          builder: (context)=> SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 5,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Image(
                    image: AssetImage('assets/images/image1.jpg'),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Comunicate with friends',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
                ),
              ),
            )
                ],
              )),
           ListView.separated(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildPostItem( AppCubit.get(context).postes[index],context,index),
          separatorBuilder:(context, index) =>SizedBox(height: 10,) ,
          itemCount: AppCubit.get(context).postes.length),
          ]),
      ),
          fallback:(context)=> Center(child: CircularProgressIndicator()),
        );
      },

    );

  }

  Widget buildPostItem(PostModel model, context,index)=>Card(
          elevation: 5,
           clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                   backgroundImage:NetworkImage(model.image),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Text(model.name,
                          style: Theme.of(context).textTheme.subtitle1
                        ),
                        Text(model.dateTime,
                          style:Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz_outlined))
                ],
                
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(model.text,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    height: 1.3
                  ),
                ),
                
              ),
              SizedBox(height: 10,),
              if(model.postImage !='')
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(image: NetworkImage(model.postImage!),
                  fit: BoxFit.cover
                  )
                ),
                height: 160,
                width: double.infinity,
               
              ),
              // SizedBox(height: 10,),
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
                                 AppCubit.get(context).likePost(AppCubit.get(context).postsId[index]);
                                 },  ),
                              Text('${AppCubit.get(context).likes[index]}',
                              style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                        onTap: (){},
                      ),
                    ), InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Icon(Icons.chat_outlined,color: Colors.amber,size: 20,),
                            Text('130 comment',
                            style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                      onTap: (){
                        navigateTo(context, CommentScreen());
                      },
                    )
                  ],
                ),
              ),
              // SizedBox(height: 10,),
              Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
              SizedBox(width: 7,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                             backgroundImage:NetworkImage(AppCubit.get(context).model.image),
                            ),
                            SizedBox(width: 7,),
                           
                            Text('Write a comment ....  ',
                              style:Theme.of(context).textTheme.caption,
                            ),
                           
                          ],
                          
                        ),
                        onTap: (){
                          navigateTo(context, CommentScreen());
                        },
                      ),
                    ),
                    InkWell(
                        child: Row(
                          children: [
                            Icon(Icons.favorite_border_outlined,color: Colors.red,size: 20,),
                            Text('Like',
                            style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                        onTap: (){},
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
    
}
