// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Shared/Componentes/Componentes.dart';
import 'package:social_app/Shared/Style/style.dart';
import 'package:social_app/modules/Cubit/AppCubit.dart';
import 'package:social_app/modules/Cubit/AppStates.dart';
import 'package:social_app/modules/Models/UserCreationModel.dart';
import 'package:social_app/modules/Models/massage.dart';

class ChatDetailsScreen extends StatelessWidget {
  late UserCreationModel model;
  ChatDetailsScreen({
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubit.get(context).getMessages(reciverId: model.uid);
        return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var massageController = TextEditingController();
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(model.image),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(model.name, style: Theme.of(context).textTheme.subtitle1),
                ],
              ),
            ),
            body: ConditionalBuilder(
              condition: AppCubit.get(context).messages.length>0,
              builder: (context)=>Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                   Expanded(
                     child: ListView.separated(
                       itemBuilder: (context,index){
                         var message=AppCubit.get(context).messages[index];
                         if(AppCubit.get(context).model.uid==message.senderId){
                           return buildMyMessages(message);
                         }
                         else{
                           return buildReciverMassages(message);
                         }
                       },
                       separatorBuilder: (context,index)=>SizedBox(height: 15,),
                        itemCount: AppCubit.get(context).messages.length
                         ),
                   ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: massageController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'write your massage here ...',
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                AppCubit.get(context).sendMassage(
                                  text: massageController.text, 
                                  reciverId: model.uid, 
                                  dateTime: DateTime.now().toString());
                              },
                              icon: Icon(
                                Icons.send,
                                // size: 10,
                                color: defaultColor,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              fallback:(context)=> Center(child: CircularProgressIndicator()),
            ),
          );
        },
      );
      },

    );
  }

  Widget buildReciverMassages( MassageModel model) => Align(
        alignment: AlignmentDirectional.topStart,
        child: Container(
            padding: EdgeInsetsDirectional.all(10),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(10),
                  topStart: Radius.circular(10),
                  bottomEnd: Radius.circular(10),
                )),
            child: Text(model.text)),
      );

  Widget buildMyMessages(MassageModel model) => Align(
        alignment: AlignmentDirectional.bottomEnd,
        child: Container(
            padding: EdgeInsetsDirectional.all(10),
            decoration: BoxDecoration(
                color: defaultColor[300],
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(10),
                  topStart: Radius.circular(10),
                  bottomStart: Radius.circular(10),
                )),
            child: Text(model.text)),
      );
}
