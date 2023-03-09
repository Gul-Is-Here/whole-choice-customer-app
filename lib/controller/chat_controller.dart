import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'package:whole_choice_customer/consts/consts.dart';
import 'package:whole_choice_customer/controller/home_controller.dart';

class ChatsController extends GetxController {
  @override
  void onInit() {
    getChatId();
    super.onInit();
  }

  var chats = firestore.collection(chatsCollection);
  var friendName = Get.arguments[0];
  var frinedId = Get.arguments[1];
  var senderName = Get.find<HomeController>().username;
  var currentId = currentUser!.uid;
  var msgController = TextEditingController();
  dynamic chatDocId;
  var isLoading = false.obs;
  getChatId() async {
    isLoading(true);
    await chats
        .where('users', isEqualTo: {frinedId: null, currentId: null})
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            chatDocId = snapshot.docs.single.id;
          } else {
            chats.add({
              'created_on': null,
              'last_msg': '',
              'users': {frinedId: null, currentId: null},
              'toId': '',
              'fromId': '',
              'friend_name': friendName,
              'sender_name': senderName,
            }).then((value) {
              chatDocId = value.id;
            });
          }
        });
    isLoading(false);
  }

  sendMsg(String msg) async {
    if (msg.trim().isNotEmpty) {
      chats.doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toId': frinedId,
        'fromId': currentId,
      });
      chats.doc(chatDocId).collection(messagesCollection).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentId,
      });
    }
  }
}
