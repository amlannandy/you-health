import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserInfoProvider {
  static File currentImage;
  static String currentImageUrl = "";

  static void uploadUserInfo({BuildContext context, String name}) async {
    if (name.isEmpty) {
      Fluttertoast.showToast(msg: "Please add your name");
      return;
    }
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection('users').document(user.uid).setData({
      'name': name,
      'email': user.email,
      'imageUrl': currentImageUrl.isEmpty
          ? "https://firebasestorage.googleapis.com/v0/b/medigo-bbsr.appspot.com/o/stock_assets%2Fdefault_user.png?alt=media&token=10ca9493-9918-4e90-8422-c318150f6588"
          : currentImageUrl,
    });
    Navigator.of(context).pushReplacementNamed('/init');
  }

  static Future takePicture(
      BuildContext context, Function notifyChanges) async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) return;
    currentImage = imageFile;
    StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('userProfilePictures/${Path.basename(currentImage.path)}}');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(currentImage);
    await uploadTask.onComplete;
    firebaseStorageRef.getDownloadURL().then((fileUrl) {
      currentImageUrl = fileUrl;
      notifyChanges();
    });
  }

  static Future uploadPicture(
      BuildContext context, Function notifyChanges) async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (imageFile == null) return;
    currentImage = imageFile;
    StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('userProfilePictures/${Path.basename(currentImage.path)}}');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(currentImage);
    await uploadTask.onComplete;
    firebaseStorageRef.getDownloadURL().then((fileUrl) {
      currentImageUrl = fileUrl;
      notifyChanges();
    });
  }
}
