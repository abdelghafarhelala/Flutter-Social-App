

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultbutton({
  double width = double.infinity,
  Color color = Colors.blue,
  required Function onpress,
  required String text,
  double radius = 0.0,
  bool isupper = true,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: (){
          onpress();
        },
        child: Text(
          isupper ? text.toUpperCase() : text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
    );

Widget defaulttextfield({
  required String lable,
  required IconData prefix,
  required Function? validate,
  required context,
  IconData? suffix,
  Function? suffixPressed,
  bool isSecure = false,
  required TextInputType type,
  var controller,
  // Function? ontap,
  // Function? onChange,
  
}) =>
    TextFormField(
      style: Theme.of(context).textTheme.button,
      decoration: InputDecoration(
        
        labelText: lable,
        border: const UnderlineInputBorder(),
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(icon: Icon(suffix),
        onPressed: (){
          suffixPressed!();
        }),
      ),
      keyboardType: type,
      obscureText: isSecure,
      validator: (String? s){
        return  validate!(s);
      },
      controller: controller,
      // onTap: (){
      //   ontap!();
      // },
      // onChanged: (String s){
      //     onChange!(s);
      // },

      
    );

// Widget buildTasks(Map model, context) => Dismissible(
//       key: Key(model['id'].toString()),
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 40,
//               child: Text("${model["time"]}"),
//             ),
//             const SizedBox(
//               width: 20,
//             ),
//             Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "${model['title']}",
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const Text(
//                   "April 10 2020",
//                   style: TextStyle(
//                     color: Colors.grey,
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//       onDismissed: (direction) {
//         AppCubit.git(context).DeleteFromDataBase(id: model['id']);
//       },
//     );

// Widget buildArticleItem(article,context) => InkWell(
//   onTap: () {
//     navigateTo(context, WebViewScreen(article['url']));
//   },
//   child:   Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Row(
//           children: [
//             Container(
//               width: 120,
//               height: 120,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 image: DecorationImage(
//                     image: NetworkImage("${article['urlToImage']}"),
//                     fit: BoxFit.cover),
//               ),
//             ),
//             SizedBox(
//               width: 20,
//             ),
//             Expanded(
//               child: Container(
//                 height: 120,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       "${article['title']}",
//                       style: Theme.of(context).textTheme.bodyText1,
//                       maxLines: 4,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     Text(
//                       "${article['publishedAt']}",
//                       style: TextStyle(
//                         color: Colors.grey,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
// );

Widget lineSpreate() => Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey,
      ),
    );


    void navigateTo(context,widget)=>Navigator.push(context, 
    MaterialPageRoute(builder: (context)=>widget),
    );



  //   Widget articleBuilder(list,{isSearch})=>ConditionalBuilder(
  //         condition: list.length > 0,
  //         builder: (context) => ListView.separated(
  //             itemBuilder: (context, index) {
  //               return buildArticleItem(list[index], context);
  //             },
  //             separatorBuilder: (context, index) {
  //               return lineSpreate();
  //             },
  //             itemCount: list.length),
  //         fallback: (context) => isSearch ? Container() : Center(child: CircularProgressIndicator()),
  //       );


  void navigateAndFinsh(context,widget)=>Navigator.pushAndRemoveUntil(context, 
    MaterialPageRoute(builder: (context)=>widget),
    (route){
      return false;
    }
    );


void showToast({@required String ?text,@required ToastStates ?state})=>Fluttertoast.showToast(
    msg: text!,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor:toastColor(state!),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates{success,error,Warrnaing}

Color ?color;
Color? toastColor(ToastStates state){
  switch(state){
    case ToastStates.success:
      color=Colors.green;
      break;
    case ToastStates.error:
      color=Colors.red;
      break;    
    case ToastStates.Warrnaing:
      color=Colors.amber;
      break;

  }
  return color;
}
