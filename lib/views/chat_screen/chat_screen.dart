import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/Material.dart';
import 'package:get/get.dart';

import 'package:whole_choice_customer/consts/consts.dart';
import 'package:whole_choice_customer/controller/chat_controller.dart';
import 'package:whole_choice_customer/services/firestore_services.dart';
import 'package:whole_choice_customer/views/chat_screen/components/sender_bubble.dart';
import 'package:whole_choice_customer/widget_common/loading_indicator.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var contoller = Get.put(ChatsController());
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: "${contoller.friendName}"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
              () => contoller.isLoading.value
                  ? Center(child: loadingIndicator())
                  : Expanded(
                      child: StreamBuilder(
                        stream: FirestoreServies.getChatMessages(
                            contoller.chatDocId.toString()),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: loadingIndicator());
                          } else if (snapshot.data!.docs.isEmpty) {
                            return Center(
                                child: "Send a message.. "
                                    .text
                                    .color(darkFontGrey)
                                    .make());
                          } else {
                            return ListView(
                              children: snapshot.data!.docs
                                  .mapIndexed((currentValue, index) {
                                var data = snapshot.data!.docs[index];
                                return Align(
                                    alignment: data['uid'] == currentUser!.uid
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: senderBubble(data));
                              }).toList(),
                            );
                          }
                        },
                      ),
                    ),
            ),
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: contoller.msgController,
                  cursorColor: yellowColor,
                  decoration: const InputDecoration(
                    hintText: "Type a message",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: textfieldGrey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: textfieldGrey)),
                  ),
                )),
                IconButton(
                    onPressed: () {
                      contoller.sendMsg(contoller.msgController.text);
                      contoller.msgController.clear();
                    },
                    icon: const Icon(
                      Icons.send,
                      color: yellowColor,
                    ))
              ],
            )
                .box
                .height(70)
                .padding(const EdgeInsets.all(12))
                .margin(const EdgeInsets.only(bottom: 8))
                .make()
          ],
        ),
      ),
    );
  }
}
