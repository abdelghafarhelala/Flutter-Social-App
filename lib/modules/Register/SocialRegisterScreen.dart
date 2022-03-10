// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Shared/Componentes/Componentes.dart';

import 'package:social_app/modules/Login/SocialLoginScreen.dart';
import 'package:social_app/modules/Register/RegisterCubit/SocialRegisterCubit.dart';
import 'package:social_app/modules/Register/RegisterCubit/SocialRegisterStates.dart';
import 'package:social_app/modules/layout/layout_screen.dart';



// ignore: must_be_immutable
class SocialRegisterScreen extends StatelessWidget {
      var emailController=TextEditingController();
      var phoneController=TextEditingController();
      var nameController=TextEditingController();
      var passwordController=TextEditingController();
     var formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: ( BuildContext context) =>SocialRegisterCubit() ,
      
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context, state) {
          if(state is SocialUserCreateSuccessState){
            navigateAndFinsh(context, SocialLayoutScreen());
            }
          

        },
        builder: (context, state) {
          return Scaffold(
          appBar: AppBar(
            title: Title(color: Colors.grey, child: Text("Register")),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: 
                    [
                      Text(
                        'Register',
                        style: Theme.of(context).textTheme.headline3?.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        'Register now to get our hot offers',
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                       SizedBox(height: 20,),
                      defaulttextfield(
                        lable: 'Name',
                        prefix: Icons.person,
                        validate: (String value){if(value.isEmpty){return 'Name con\'t be empty';}}, 
                        context: context,
                        type: TextInputType.name,
                        controller: nameController
                        ),
                      SizedBox(height: 20,),
                      defaulttextfield(
                        lable: 'Email',
                        prefix: Icons.email_outlined,
                        validate: (String value){if(value.isEmpty){return 'Email con\'t be empty';}}, 
                        context: context,
                        type: TextInputType.emailAddress,
                        controller: emailController
                        ),
                        SizedBox(height: 20,),
                         defaulttextfield(
                           isSecure: SocialRegisterCubit.get(context).ispass,
                        lable: 'Password',
                        prefix: Icons.lock_open_outlined,
                        validate: (String value){if(value.isEmpty){return 'Password con\'t be empty';}}, 
                        context: context,
                        type: TextInputType.visiblePassword,
                        controller: passwordController,
                        suffix: SocialRegisterCubit.get(context).suffix,
                        suffixPressed: (){
                          SocialRegisterCubit.get(context).changePasswordVisibilty();
                          
                        }
                        ),
                         SizedBox(height: 20,),
                      defaulttextfield(
                        lable: 'Phone',
                        prefix: Icons.phone,
                        validate: (String value){if(value.isEmpty){return 'Phone con\'t be empty';}}, 
                        context: context,
                        type: TextInputType.phone,
                        controller: phoneController
                        ),
                        SizedBox(height: 20,),
                        
                        ConditionalBuilder(
                          condition:state is!SocialRegisterLoodingState  ,
                          builder:(context) {
                            return defaultbutton(
                            onpress:(){
                              if(formkey.currentState!.validate()){
                                SocialRegisterCubit.get(context).userRegister(
                                  context,
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text
                                 );
                              }
                            } , 
                            text: 'Register');
                          } ,
                          fallback: (context) => CircularProgressIndicator(),
                          
                        ),
                
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("have an account"),
                               TextButton(onPressed: (){
                                 navigateTo(context, SocialLoginScreen());
                               }, child: Text("Login")),
                            ],
                          ),
                         
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
        })
    );
  }
}