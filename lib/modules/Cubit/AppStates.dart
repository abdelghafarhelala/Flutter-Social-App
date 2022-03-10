abstract class AppStates{}
class AppIntialState extends AppStates{}
class AppLoadingState extends AppStates{}
class AppSuccessState extends AppStates{}
class AppErrorState extends AppStates{
  final String error;
  AppErrorState(this.error);
}
class AppChangeButtomNavState extends AppStates{}
class AppChangeAddPostButtomNavState extends AppStates{}

class AppPickProfileImageSuccessState extends AppStates{}
class AppPickProfileImageErrorState extends AppStates{

}
class AppPickCoverImageSuccessState extends AppStates{}
class AppPickCoverImageErrorState extends AppStates{}
class AppUpdateCoverImageSuccessState extends AppStates{}
class AppUpdateCoverImageErrorState extends AppStates{}
class AppUpdateProfileImageSuccessState extends AppStates{}
class AppUpdateProfileImageErrorState extends AppStates{}
class AppUpdateProfileLoadingState extends AppStates{}
class AppUpLoadProfileLoadingState extends AppStates{}
class AppUpLoadCoverLoadingState extends AppStates{}
class AppUpdateProfileErrorState extends AppStates{}


//New Post
class AppPickPostImageSuccessState extends AppStates{}
class AppPickPostImageErrorState extends AppStates{}
class AppUpLoadPostImageLoadingState extends AppStates{}
class AppPostImageSuccessState extends AppStates{}
class AppPostImageErrorState extends AppStates{}
class AppAddPostSuccessState extends AppStates{}
class AppAddPostErrorState extends AppStates{}
class AppAddPostLoadingState extends AppStates{}
class RemovePostImageState extends AppStates{}

//get Post
class AppGetPostLoadingState extends AppStates{}
class AppGetPostSuccessState extends AppStates{}
class AppGetPosterrorState extends AppStates{}

//Like Post
class AppLikePostSuccessState extends AppStates{}
class AppLikePostErrorState extends AppStates{}



//New Comment
class AppPickCommentImageSuccessState extends AppStates{}
class AppPickCommentImageErrorState extends AppStates{}
class AppUpLoadCommentImageLoadingState extends AppStates{}
class AppCommentImageSuccessState extends AppStates{}
class AppCommentImageErrorState extends AppStates{}
class AppAddCommentSuccessState extends AppStates{}
class AppAddCommentErrorState extends AppStates{}
class AppAddCommentLoadingState extends AppStates{}
class RemoveCommentImageState extends AppStates{}

//get Post
class AppGetCommentLoadingState extends AppStates{}
class AppGetCommentSuccessState extends AppStates{}
class AppGetCommenterrorState extends AppStates{}

//Comment Post
class AppCommentPostSuccessState extends AppStates{}
class AppCommentPostErrorState extends AppStates{}

//Get All Users
class AppGetAllUsersSuccessState extends AppStates{}
class AppGetAllUsersErrorState extends AppStates{}

//Send Messages
class AppSendMessagesSuccessState extends AppStates{}
class AppSendMessagesErrorState extends AppStates{}

//Get Messages
class AppGetMessagesSuccessState extends AppStates{}

