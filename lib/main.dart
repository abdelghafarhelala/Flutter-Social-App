// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, non_constant_identifier_names

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Shared/Componentes/Componentes.dart';
import 'package:social_app/Shared/Style/style.dart';
import 'package:social_app/Shared/blocObserver/blocObserver.dart';
import 'package:social_app/Shared/const/Const.dart';
import 'package:social_app/modules/Cubit/AppCubit.dart';
import 'package:social_app/modules/Login/SocialLoginScreen.dart';
import 'package:social_app/modules/layout/layout_screen.dart';

import 'Network/local/CacheHelper.dart';

//firebase background messages
   Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();

        print(message.data.toString());
      showToast(text: 'Hello From Background Message ', state: ToastStates.success);
}



void main()async {
  
 
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ChacheHelper.init();
  


  uId=ChacheHelper.getData(key: 'uId');
   Widget  widget;
      if(uId !=null){
      widget=SocialLayoutScreen();
    }
    else{
      widget=SocialLoginScreen();
    }
  BlocOverrides.runZoned(
    () {
      // Use cubits...
      runApp(MyApp(startWidget: widget,));
    },
    blocObserver: MyBlocObserver(),);


  var token=await FirebaseMessaging.instance.getToken();
  print('the token is ' + token!);

    //firebase foreground messages
    FirebaseMessaging.onMessage.listen((event) {
      print(event.data.toString());
      showToast(text: 'Hello From On Message', state: ToastStates.success);
    });
   FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print(event.data.toString());
      showToast(text: 'Hello From On Message opend app', state: ToastStates.success);
    });
    //firebase background messages
   FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

 
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  // ignore: avoid_types_as_parameter_names
  MyApp({required this.startWidget} );
  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: ( BuildContext context) => AppCubit()..getData()..getPosts(),
      child: MaterialApp(
         debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: lightthem,
        themeMode: ThemeMode.light,
        home:startWidget ,
      ),
    );
  }
}



