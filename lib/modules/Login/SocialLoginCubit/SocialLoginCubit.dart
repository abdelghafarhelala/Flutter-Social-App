// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/Login/SocialLoginCubit/SocialLoginStates.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginIntialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({required String email, required String password}) {
    emit(SocialLoginLoodingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: email,
         password: password)
        .then((value) {
          print(value.user?.email);
          print(value.user?.uid);
          emit(SocialLoginSuccessState(value.user!.uid));
        })
        .catchError((error) {
          emit(SocialLoginErrorState(error.toString()));

        });
  }

  bool ispass = true;
  IconData suffix = Icons.visibility_outlined;
  void changePasswordVisibilty() {
    ispass = !ispass;
    ispass
        ? suffix = Icons.visibility_outlined
        : suffix = Icons.visibility_off_outlined;
    emit(SocialLoginPasswordShown());
  }
}
