import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/Model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';


class FirebaseApi
{

  static Future<void> createUser(UserData userData) async
  {

    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('Users').doc(user?.uid).set(
      userData.toJson()
    );
  }

  static Future<UserData> readUser() async
  {
    final user = FirebaseAuth.instance.currentUser;
    var val=  await FirebaseFirestore.instance.collection('Users')
          .doc(user?.uid)
          .get();
    return UserData.fromJson(val.data());
  }

  static Future<void> updatePhoto() async
  {

    ImagePicker imagePicker = ImagePicker();
    XFile? file =  await imagePicker.pickImage(source: ImageSource.gallery);

    if(file==null) return ;
    String unique = DateTime.now().microsecondsSinceEpoch.toString();

    final user = FirebaseAuth.instance.currentUser;
    var val=  await FirebaseFirestore.instance.collection('Users')
        .doc(user?.uid)
        .get();

    String testUrl = UserData.fromJson(val.data()).PhotoUrl;
    print(testUrl);

    if(testUrl == '')
      {
        Reference referenceRoot = FirebaseStorage.instance.ref();
        Reference referenceDirImages = referenceRoot.child('images');

        Reference referenceImageToUpload = referenceDirImages.child(unique);

        try
        {
          await referenceImageToUpload.putFile(File(file.path));
          var url = await referenceImageToUpload.getDownloadURL();

          FirebaseFirestore.instance.collection('Users')
              .doc(user?.uid)
              .update({
            'PhotoUrl' : url
          });

        }catch(e)
        {
          showToast(e.toString());
        }
      }
    else
      {
        Reference referenceImageToUpload = FirebaseStorage.instance
            .refFromURL(testUrl);

        try
        {
          await referenceImageToUpload.putFile(File(file.path));
          var url = await referenceImageToUpload.getDownloadURL();

          FirebaseFirestore.instance.collection('Users')
              .doc(user?.uid)
              .update({
            'PhotoUrl' : url
          });
        }catch(e)
        {
          showToast(e.toString());
        }
      }
  }

  static Future<void> updateAddress(String newAdd) async
  {
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('Users')
        .doc(user?.uid)
        .update({
      'Address' : newAdd
    });
  }

  final _firebaseMessaging = FirebaseMessaging.instance;

  void handleMessage(RemoteMessage? message){
    if (message == null){
      return ;
    }
    else{

    }
  }

  Future initPushNotifications() async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> initNotifications() async {
    // For iOS request permission first.
    await _firebaseMessaging
        .requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    )
        .then((value) {
      print('User granted permission');
    }).catchError((onError) {
      print('User declined permission');
    });

    final fCMToken = await _firebaseMessaging.getToken();
    print('Token:$fCMToken');
    initPushNotifications();
    //FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
  print(message.data);
  print(message.notification!.title);
  print(message.notification!.body);
}


void showToast(String text) => Fluttertoast.showToast
  (
  msg: text,
  fontSize: 13.0,
  backgroundColor: HexColor("#fed701"),
  textColor: Colors.black,
  gravity: ToastGravity.BOTTOM,
);
