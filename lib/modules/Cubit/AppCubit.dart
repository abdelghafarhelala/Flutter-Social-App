// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_is_empty, avoid_single_cascade_in_expression_statements, curly_braces_in_flow_control_structures, duplicate_ignore, avoid_function_literals_in_foreach_calls

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/modules/Cubit/AppStates.dart';
import 'package:social_app/modules/Models/UserCreationModel.dart';
import 'package:social_app/modules/Models/comment_model.dart';
import 'package:social_app/modules/Models/massage.dart';
import 'package:social_app/modules/Models/post_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feed/feed_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../Shared/const/Const.dart';
import '../posts/post_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIntialState());
  static AppCubit get(context) => BlocProvider.of(context);

  late UserCreationModel model;
  void getData() {
    emit(AppLoadingState());
    FirebaseFirestore.instance.collection('Users').doc(uId).get().then((value) {
      print(value.data());
      model = UserCreationModel.fromJson(value.data()!);
      emit(AppSuccessState());
    }).catchError((error) {
      emit(AppErrorState(error.toString()));
    });
  }

  int curentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    PostsScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = ['Home', 'Chats', 'Users', 'Posts', 'Settings'];

  void changeButtomNav(int index) {
    if(index==1){
      getAllUsers();
    }
    if (index == 2) {
      emit(AppChangeAddPostButtomNavState());
    } else {
      curentIndex = index;
      emit(AppChangeButtomNavState());
    }
  }

  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      profileImage = File(pickerFile.path);
      emit(AppPickProfileImageSuccessState());
    } else {
      print('No Image Selected');
      emit(AppPickProfileImageErrorState());
    }
  }

  File? coverImage;
  Future<void> getcoverImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      coverImage = File(pickerFile.path);
      emit(AppPickCoverImageSuccessState());
    } else {
      print('No Image Selected');
      emit(AppPickCoverImageErrorState());
    }
  }

  String profileImageUrl = '';
  void updateProfileImage(
      {required String name, required String bio, required String phone}) {
    emit(AppUpLoadProfileLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateProfileData(
          name: name,
          bio: bio,
          phone: phone,
          image: value,
        );
        emit(AppUpdateProfileImageSuccessState());
      }).catchError((error) {
        emit(AppUpdateProfileImageErrorState());
      });
    }).catchError((error) {
      emit(AppUpdateProfileImageErrorState());
    });
  }

  void updateCoverImage(
      {required String name, required String bio, required String phone}) {
    emit(AppUpLoadCoverLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateProfileData(
          name: name,
          bio: bio,
          phone: phone,
          cover: value,
        );
        emit(AppUpdateCoverImageSuccessState());
      }).catchError((error) {
        emit(AppUpdateCoverImageErrorState());
      });
    }).catchError((error) {
      emit(AppUpdateCoverImageErrorState());
    });
  }

  void updateProfileData({
    required String name,
    required String bio,
    required String phone,
    String? image,
    String? cover,
  }) {
    emit(AppUpdateProfileLoadingState());

    UserCreationModel userModel = UserCreationModel(
      name: name,
      email: model.email,
      phone: phone,
      uid: model.uid,
      image: image ?? model.image,
      cover: cover ?? model.cover,
      bio: bio,
    );

    FirebaseFirestore.instance
        .collection("Users")
        .doc(userModel.uid)
        .update(userModel.toMap())
        .then((value) {
      getData();
    }).catchError((error) {
      print(error.toString());
      emit(AppUpdateProfileErrorState());
    });
  }

  File? postImage;
  Future<void> getPostImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      postImage = File(pickerFile.path);
      emit(AppPickPostImageSuccessState());
    } else {
      print('No Image Selected');
      emit(AppPickPostImageErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImageState());
  }

  void uploadPostImage({
    required String text,
    required String dateTime,
  }) {
    emit(AppAddPostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        postData(text: text, dateTime: dateTime, postImage: value);
        emit(AppPostImageSuccessState());
      }).catchError((error) {
        emit(AppPostImageErrorState());
      });
    }).catchError((error) {
      emit(AppPostImageErrorState());
    });
  }

  late PostModel createPostmodel;
  void postData({
    required String text,
    required String dateTime,
    String? postImage,
    String? uid,
    String? name,
    String? image,
  }) {
    emit(AppAddPostLoadingState());

    PostModel postmodel = PostModel(
      text: text,
      dateTime: dateTime,
      postImage: postImage??'',
      uid: model.uid,
      image: model.image,
      name: model.name,
    );

    FirebaseFirestore.instance
        .collection("posts")
        .add(postmodel.toMap())
        .then((value) {
      // postmodel=PostModel.fromJson(value.parent)

      emit(AppAddPostSuccessState());
      print(value);
    }).catchError((error) {
      print(error.toString());
      emit(AppAddPostErrorState());
    });
  }

  List<PostModel> postes = [];
  List<String> postsId = [];
  List<int> likes = [];

  void getPosts() {
    emit(AppGetPostLoadingState());

    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postes.add(PostModel.fromJson(element.data()));
          postsId.add(element.id);
          
        }).catchError((error) {});
      });
      emit(AppGetPostSuccessState());
    }).catchError((error) {
      emit(AppGetPosterrorState());
      print(error.toString());
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model.uid)
        .set({'like': true}).then((value) {
      emit(AppLikePostSuccessState());
    }).catchError((error) {
      emit(AppLikePostErrorState());
    });
  }



File? commentImage;
  Future<void> getCommentImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      commentImage = File(pickerFile.path);
      emit(AppPickCommentImageSuccessState());
    } else {
      print('No Image Selected');
      emit(AppPickCommentImageErrorState());
    }
  }

  void removeCommentImage() {
    commentImage = null;
    emit(RemoveCommentImageState());
  }

  void uploadCommentImage({
    required String text,
    required String dateTime,
  }) {
    emit(AppAddCommentLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${Uri.file(commentImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        CommentData(text: text, dateTime: dateTime, commentImage: value);
        emit(AppCommentImageSuccessState());
      }).catchError((error) {
        emit(AppCommentImageErrorState());
      });
    }).catchError((error) {
      emit(AppCommentImageErrorState());
    });
  }

  late CommentModel createCommentmodel;
  void CommentData({
    required String text,
    required String dateTime,
    String? commentImage,
    String? uid,
    String? name,
    String? image,
    String ?postId,
  }) {
    emit(AppAddCommentLoadingState());

    CommentModel commentmodel = CommentModel(
      text: text,
      dateTime: dateTime,
      commentImage: commentImage,
      uid: model.uid,
      image: model.image,
      name: model.name,
    );

    FirebaseFirestore.instance
        .collection("posts").doc(postId).collection('comments').doc(model.uid)
        .set(commentmodel.toMap())
        .then((value) {
      // postmodel=PostModel.fromJson(value.parent)

      emit(AppAddCommentSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppAddCommentErrorState());
    });
  }


  void CommentPost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(model.uid)
        .set({'comment': true}).then((value) {
      emit(AppCommentPostSuccessState());
    }).catchError((error) {
      emit(AppCommentPostErrorState());
    });
  }

  List<CommentModel> comments = [];
  List<String> commentsId = [];
  List<int> likesk = [];

  void getComment() {
    emit(AppGetCommentLoadingState());

    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('comments').get().then((value) {
          likes.add(value.docs.length);
          comments.add(CommentModel.fromJson(element.data()));
          commentsId.add(element.id);
          
        }).catchError((error) {});
      });
      emit(AppGetCommentSuccessState());
    }).catchError((error) {
      emit(AppGetCommenterrorState());
      print(error.toString());
    });
  }


  List<UserCreationModel> users = [];


void getAllUsers(){

  if(users.length==0)
    // ignore: curly_braces_in_flow_control_structures
    FirebaseFirestore.instance.collection('Users').get().then((value) {
      value.docs.forEach((element) {
        print(element.data());
        if(element.data()['uid']!=model.uid)
        users.add(UserCreationModel.fromJson(element.data()));


        
      });
      emit(AppGetAllUsersSuccessState());
    }).catchError((error) {
      emit(AppGetAllUsersErrorState());
      print(error.toString());
    });
    }


    void sendMassage({
      required text,
      required reciverId,
      required dateTime
    }){
      MassageModel massagemodel=MassageModel(
        reciverId: reciverId, 
        senderId: model.uid, 
        dateTime: dateTime, 
        text: text
        );
        //sender chat
        FirebaseFirestore.instance.collection('Users')
        .doc(model.uid).collection('chats').doc(reciverId).collection('massages').add(massagemodel.toMap())
        .then((value) {
          emit(AppSendMessagesSuccessState());
        })
        .catchError((error){
          emit(AppSendMessagesErrorState());

        });

        //reciver chat
         FirebaseFirestore.instance.collection('Users')
        .doc(reciverId).collection('chats').doc(model.uid).collection('massages').add(massagemodel.toMap())
        .then((value) {
          emit(AppSendMessagesSuccessState());
        })
        .catchError((error){
          emit(AppSendMessagesErrorState());

        });
    }
  List <MassageModel>messages=[];
    void getMessages({
      required reciverId,
      }){
        
        FirebaseFirestore.instance.collection('Users')
        .doc(model.uid)
        .collection('chats')
        .doc(reciverId).collection('massages')..orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages=[];
          event.docs.forEach((element) {
            messages.add(MassageModel.fromJson(element.data()));
          });
          emit(AppGetMessagesSuccessState());
        });
      }

    




}
