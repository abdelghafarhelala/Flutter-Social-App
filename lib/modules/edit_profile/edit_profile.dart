// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Shared/Componentes/Componentes.dart';
import 'package:social_app/modules/Cubit/AppCubit.dart';
import 'package:social_app/modules/Cubit/AppStates.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = AppCubit.get(context).model;
        var nameController = TextEditingController();
        var phoneController = TextEditingController();
        var bioController = TextEditingController();
        nameController.text = userModel.name;
        phoneController.text = userModel.phone;
        bioController.text = userModel.bio;
        File ? profileImage=AppCubit.get(context).profileImage;
        File ? coverImage=AppCubit.get(context).coverImage;
        return Scaffold(
          appBar: AppBar(
            title: Title(color: Colors.black, child: Text('Edit Profile')),
            actions: [
              TextButton(
                onPressed: () {
                  AppCubit.get(context).updateProfileData(
                    name: nameController.text, 
                    bio: bioController.text, 
                    phone: phoneController.text
                    );
                  },
                 child: Text('UPDATE')),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is AppUpdateProfileLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 210,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadiusDirectional.only(
                                      topStart: Radius.circular(5),
                                      topEnd: Radius.circular(5)),
                                  image: DecorationImage(
                                      image:coverImage ==null? NetworkImage(userModel.cover):FileImage(coverImage)as ImageProvider,
                                      fit: BoxFit.cover),
                                ),
                              ),
                              CircleAvatar(
                                  radius: 20,
                                  child: IconButton(
                                    onPressed: () {
                                      AppCubit.get(context).getcoverImage();
                                    },
                                    icon: Icon(Icons.camera_alt_outlined),
                                  )),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 65,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                // backgroundImage: NetworkImage('${model?.image}'),
                                backgroundImage:profileImage !=null ? FileImage(profileImage) :NetworkImage(userModel.image) as ImageProvider ,
                                
                              ),
                            ),
                             CircleAvatar(
                    
                            radius: 17,
                            child: IconButton(
                              onPressed: () {AppCubit.get(context).getProfileImage();},
                              icon: Icon(Icons.camera_alt_outlined,size: 20,),
                              
                            )),
                          ],
                        ),
                       
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if(profileImage !=null || coverImage != null)
                  Row(children: [
                    if(profileImage!=null)
                    Expanded(
                      child: Column(
                      children: [
                        defaultbutton(onpress: (){
                          AppCubit.get(context).updateProfileImage(
                            name: nameController.text, 
                            bio: bioController.text, 
                            phone: phoneController.text
                            );
                        }, text: 'UPLPOAD PROFILE'),
                    if(state is AppUpLoadProfileLoadingState)
                        LinearProgressIndicator(),
                      ],
                    )),
                    SizedBox(width: 5,),
                    if(coverImage!=null)
                    Expanded(child: Column(
                      children: [
                        defaultbutton(onpress: (){
                          AppCubit.get(context).updateCoverImage(
                            name: nameController.text, 
                            bio: bioController.text, 
                            phone: phoneController.text
                            );
                        }, text: 'UPLPOAD COVER'),
                    if(state is AppUpLoadCoverLoadingState)
                        LinearProgressIndicator(),
                      ],
                    )),
                  ],),
                  SizedBox(
                    height: 20,
                  ),
                  defaulttextfield(
                    lable: 'Name',
                    prefix: Icons.person,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Name must not be empty';
                      }
                      return null;
                    },
                    context: context,
                    type: TextInputType.name,
                    controller: nameController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaulttextfield(
                    lable: 'Phone',
                    prefix: Icons.person,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Phone must not be empty';
                      }
                      return null;
                    },
                    context: context,
                    type: TextInputType.phone,
                    controller: phoneController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaulttextfield(
                    lable: 'Bio',
                    prefix: Icons.person,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Bio must not be empty';
                      }
                      return null;
                    },
                    context: context,
                    type: TextInputType.text,
                    controller: bioController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
