// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Shared/Componentes/Componentes.dart';
import 'package:social_app/modules/Login/SocialLoginCubit/SocialLoginCubit.dart';
import 'package:social_app/modules/Login/SocialLoginCubit/SocialLoginStates.dart';

import 'package:social_app/modules/Register/SocialRegisterScreen.dart';
import 'package:social_app/modules/layout/layout_screen.dart';

import '../../Network/local/CacheHelper.dart';


class SocialLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formkey = GlobalKey<FormState>();
    return BlocProvider(
        create: (BuildContext context) => SocialLoginCubit(),
        child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
            listener: (context, state) {
              if(state is SocialLoginErrorState){
                showToast(text: state.error, state: ToastStates.error);
              }
              else if(state is SocialLoginSuccessState){
                ChacheHelper.saveData(key: 'uId', value: state.uId)
                .then((value) {
                  navigateAndFinsh(context, SocialLayoutScreen());
                });
              }
            }, 
            builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Title(color: Colors.grey, child: Text("Login")),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: Theme.of(context).textTheme.headline3!.copyWith(
                                color: Colors.black,
                              ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Login now to get our hot offers',
                          style: Theme.of(context).textTheme.headline6?.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaulttextfield(
                            lable: 'Email',
                            prefix: Icons.email_outlined,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Email con\'t be empty';
                              }
                            },
                            context: context,
                            type: TextInputType.emailAddress,
                            controller: emailController),
                        SizedBox(
                          height: 20,
                        ),
                        defaulttextfield(
                            isSecure: SocialLoginCubit.get(context).ispass,
                            lable: 'Password',
                            prefix: Icons.lock_open_outlined,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Password con\'t be empty';
                              }
                            },
                            context: context,
                            type: TextInputType.visiblePassword,
                            controller: passwordController,
                            suffix: SocialLoginCubit.get(context).suffix,
                            suffixPressed: () {
                              SocialLoginCubit.get(context)
                                  .changePasswordVisibilty();
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoodingState,
                          builder: (context) {
                            return defaultbutton(
                                onpress: () {
                                  if (formkey.currentState!.validate()) {
                                    SocialLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                text: 'Login');
                          },
                          fallback: (context) => CircularProgressIndicator(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don\'t have an account"),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, SocialRegisterScreen());
                                },
                                child: Text("REGISTER")),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
