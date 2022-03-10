// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Shared/Componentes/Componentes.dart';
import 'package:social_app/modules/Cubit/AppCubit.dart';
import 'package:social_app/modules/Cubit/AppStates.dart';
import 'package:social_app/modules/edit_profile/edit_profile.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      builder:(context, state) {
       var model =AppCubit.get(context).model;
        return  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height:210 ,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Align(
                alignment: AlignmentDirectional.topCenter,
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(5),
                          topEnd: Radius.circular(5)
                        ),
                        image: DecorationImage(
                            image: NetworkImage(model.cover),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 65,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: CircleAvatar(
                      radius: 60,
                      // backgroundImage: NetworkImage('${model?.image}'),
                       backgroundImage: NetworkImage(model.image),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Text(model.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
             SizedBox(height: 5,),
            Text(model.bio,
              style: Theme.of(context).textTheme.caption,
              ),
            SizedBox(height: 10,),
            Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text('78',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                            Text('Photos',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                   Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text('100',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                            Text('Posts',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                   Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text('10k',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                            Text('Followers',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                   Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text('244',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                            Text('Following',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          
                        ],
                      ),
                      onTap: (){},
                    ),
                  ), 
                ],
              ),
            SizedBox(height: 20,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: OutlinedButton(onPressed: (){}, 
                    child: Text('ADD PHOTOS')),
                ),
                OutlinedButton(onPressed: (){
                  navigateTo(context, EditProfile());
                }, 
                  child: Icon(Icons.edit_outlined)),
               
              ],
            )
          ],
        ),
      );
      },  listener: (context,state){
  
      });
      
    
  }
}
