import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:my_chat_app/models/chat_model.dart';
import 'package:my_chat_app/models/user_model.dart';
import 'package:my_chat_app/service/auth_service.dart';

class FireStoreService {
  FireStoreService._();

  static final FireStoreService instance = FireStoreService._();

  String collectionPath = "Todo";
  String userCollection = "allUsers";

  // Initialize
  FirebaseFirestore db = FirebaseFirestore.instance;
  // 1] ADD USER
  Future<void> addUser({required User user}) async {
    Map<String, dynamic> data = {
      "uid": user.uid,
      "email": user.email ?? "Undefined",
      "displayName": user.displayName ?? "Guest",
      "photoURL": user.photoURL ??
          "https://e7.pngegg.com/pngimages/81/570/png-clipart-profile-logo-computer-icons-user-user-blue-heroes-thumbnail.png",
      "phoneNumber": user.phoneNumber ?? "Undefined",
    };
    await db.collection(userCollection).doc(user.uid).set(
          data,
        );
    await db.collection(userCollection).doc(user.uid).get();
  }

//  2] ADD ALL USER

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return db.collection(userCollection).snapshots();
  }

//   3] Add Friend
  Future<void> addFriend({required UserModel userModel}) async {
    await db
        .collection(userCollection)
        .doc(AuthService.instnce.auth.currentUser!.uid)
        .collection("friends")
        .doc(userModel.uid)
        .set(userModel.toJson)
        .then((val) => Logger().i("Your friend is added successfully !!!"))
        .onError(
          (error, stackTrace) => Logger().e("ERROR : $error"),
        );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getFriendsStream() {
    return db
        .collection(userCollection)
        .doc(AuthService.instnce.auth.currentUser!.uid)
        .collection('friends')
        .snapshots();
  }

  // 4] Delete Friend
  Future<void> deleteFriend({required UserModel userModel}) async {
    await db
        .collection(userCollection)
        .doc(AuthService.instnce.auth.currentUser!.uid)
        .collection("friends")
        .doc(userModel.uid)
        .delete()
        .then((val) => Logger().i("Your friend is Deleted successfully !!!"))
        .onError(
          (error, stackTrace) => Logger().e("ERROR : $error"),
        );
  }
  //   5] chate With Friend

  Future<void> chateWithFriend(
      {required UserModel userModel, required Chat chat}) async {
    await db
        .collection(userCollection)
        .doc(AuthService.instnce.auth.currentUser!.uid)
        .collection("friends")
        .doc(userModel.uid)
        .collection("chats")
        .doc(chat.time.millisecondsSinceEpoch.toString())
        .set(chat.toJson)
        .then((val) =>
            Logger().i("Your friend With chat is added  Successfully!!!"))
        .onError(
          (error, stackTrace) => Logger().e("ERROR : $error"),
        );
    Map<String, dynamic> data = chat.toJson;
    data['type'] = 'receive';

    await db
        .collection(userCollection)
        .doc(userModel.uid)
        .collection('friends')
        .doc(AuthService.instnce.auth.currentUser!.uid)
        .collection('chats')
        .doc(chat.time.microsecondsSinceEpoch.toString())
        .set(data);
  }
//   6] get chat

  Stream<QuerySnapshot<Map<String, dynamic>>> getChats(
      {required UserModel userModel}) {
    return db
        .collection(userCollection)
        .doc(AuthService.instnce.auth.currentUser!.uid)
        .collection('friends')
        .doc(userModel.uid)
        .collection('chats')
        .snapshots();
  }

// 7] Seen Msg
  Future<void> seenMsg({required UserModel user, required Chat chat}) async {
    await db
        .collection(userCollection)
        .doc(AuthService.instnce.auth.currentUser!.uid.toString())
        .collection('friends')
        .doc(user.uid.toString())
        .collection('chats')
        .doc(chat.time.millisecondsSinceEpoch.toString())
        .update(
      {'status': "seen"},
    );

    await db
        .collection(userCollection)
        .doc(user.uid.toString())
        .collection('friends')
        .doc(AuthService.instnce.auth.currentUser!.uid.toString())
        .collection('chats')
        .doc(chat.time.millisecondsSinceEpoch.toString())
        .update(
      {'status': "seen"},
    );
  }
  // 8] chat delete

  Future<void> deleteChat(
      {required UserModel userModel, required Chat chat}) async {
    await db
        .collection(userCollection)
        .doc(AuthService.instnce.auth.currentUser!.uid.toString())
        .collection('friends')
        .doc(userModel.uid)
        .collection('chats')
        .doc(chat.time.millisecondsSinceEpoch.toString())
        .delete();
    await db
        .collection(userCollection)
        .doc(userModel.uid)
        .collection('friends')
        .doc(AuthService.instnce.auth.currentUser!.uid.toString())
        .collection('chats')
        .doc(chat.time.millisecondsSinceEpoch.toString())
        .delete()
        .then((val) =>
            Logger().i("Your friend With chat is delete Successfully!!!"))
        .onError(
          (error, stackTrace) => Logger().e("ERROR : $error"),
        );
  }
}
