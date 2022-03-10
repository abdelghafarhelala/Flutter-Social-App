

// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/Models/UserCreationModel.dart';
import 'package:social_app/modules/Register/RegisterCubit/SocialRegisterStates.dart';


class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterIntialState());
 

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister(
    context,
    {
      required String name,
      required String email,
      required String password,
      required String phone,
      }
      ) {
    emit(SocialRegisterLoodingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
       )
    .then((value){
      userCreate(name: name, email: email, phone: phone, uId: value.user!.uid);
      print(value.user?.email);
      print(value.user?.uid);
    emit(SocialRegisterSuccessState());

    })
    .catchError((error){
      print(error.toString());
    emit(SocialRegisterErrorState(error.toString()));

    });

  }
  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }){
    UserCreationModel model=UserCreationModel(
      name: name,
       email: email, 
       phone: phone, 
       uid: uId,
       image: 'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?t=st=1646243817~exp=1646244417~hmac=52157a75069c5a424c69017bb0668f10643574c7bab7a39fd4828e65c1f1f29d&w=900',
       cover: 'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?t=st=1646243817~exp=1646244417~hmac=52157a75069c5a424c69017bb0668f10643574c7bab7a39fd4828e65c1f1f29d&w=900',
       bio: 'Write Your Bio ...',
       );
    FirebaseFirestore.instance.collection("Users")
    .doc(uId)
    .set(model.toMap())
    .then((value) {
      emit(SocialUserCreateSuccessState());
    })
    .catchError((error){
      print(error.toString());
      emit(SocialUserCreateErrorState(error.toString()));
    });

  }


  bool ispass = true;
  IconData suffix = Icons.visibility_outlined;
  void changePasswordVisibilty() {
    ispass = !ispass;
    ispass ? suffix = Icons.visibility_outlined : suffix = Icons.visibility_off_outlined;
    emit(SocialRegisterPasswordShown());
  }
}
