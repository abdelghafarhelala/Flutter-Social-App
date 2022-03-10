// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Shared/Componentes/Componentes.dart';
import 'package:social_app/modules/Cubit/AppCubit.dart';
import 'package:social_app/modules/Cubit/AppStates.dart';
import 'package:social_app/modules/Models/UserCreationModel.dart';
import 'package:social_app/modules/chat_details/chat_ditals.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: AppCubit.get(context).users.length > 0,
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) =>
                  buildChatItem(AppCubit.get(context).users[index], context),
              separatorBuilder: (context, index) => lineSpreate(),
              itemCount: AppCubit.get(context).users.length),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(UserCreationModel model, context) => InkWell(
        onTap: () {
          navigateTo(context, ChatDetailsScreen(model: model));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(model.image),
              ),
              SizedBox(
                width: 10,
              ),
              Text(model.name, style: Theme.of(context).textTheme.subtitle1),
            ],
          ),
        ),
      );
}
