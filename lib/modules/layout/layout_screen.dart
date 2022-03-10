// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Shared/Componentes/Componentes.dart';
import 'package:social_app/modules/Cubit/AppCubit.dart';
import 'package:social_app/modules/Cubit/AppStates.dart';


import '../posts/post_screen.dart';

// ignore: use_key_in_widget_constructors
class SocialLayoutScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var cubit=AppCubit.get(context);
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {
        if(state is AppChangeAddPostButtomNavState)
          // ignore: curly_braces_in_flow_control_structures
          navigateTo(context, PostsScreen());
      },
      builder: (context,state)=>Scaffold(
        appBar: AppBar(
          title: Title(color: Colors.red, 
          child: Text(cubit.titles[cubit.curentIndex ]),
          ),
          actions: [
            IconButton(onPressed: (){
              print(cubit.model);
              print('abdoooooooooooooo');
            }, icon: Icon(Icons.notifications_none),),
            IconButton(onPressed: (){}, icon: Icon(Icons.search),),
          ],
        ),
        body:cubit.screens[cubit.curentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.chat),label: 'Chats'),
            BottomNavigationBarItem(icon: Icon(Icons.post_add_rounded),label: 'Posts'),
            BottomNavigationBarItem(icon: Icon(Icons.location_history),label: 'Users'),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
            
          ],
          onTap: ( index){
            cubit.changeButtomNav(index);
          },
          currentIndex: cubit.curentIndex,
          ),
        
      ),
    );
  }
}