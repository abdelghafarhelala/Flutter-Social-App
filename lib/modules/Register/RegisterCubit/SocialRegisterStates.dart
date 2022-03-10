
abstract class SocialRegisterStates {}
 class SocialRegisterIntialState extends SocialRegisterStates{}
 class SocialRegisterLoodingState extends SocialRegisterStates{}
 class SocialRegisterSuccessState extends SocialRegisterStates{}
 class SocialRegisterErrorState extends SocialRegisterStates{
   final String error;
   SocialRegisterErrorState(this.error);
 }


 class SocialUserCreateSuccessState extends SocialRegisterStates{}
 class SocialUserCreateErrorState extends SocialRegisterStates{
   final String error;
   SocialUserCreateErrorState(this.error);
 }
 class SocialRegisterPasswordShown extends SocialRegisterStates{}

