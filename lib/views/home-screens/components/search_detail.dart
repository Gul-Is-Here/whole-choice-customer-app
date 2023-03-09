import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'package:whole_choice_customer/consts/consts.dart';
import 'package:whole_choice_customer/controller/product_controller.dart';
import 'package:whole_choice_customer/controller/profile_controller.dart';
import 'package:whole_choice_customer/services/firestore_services.dart';
import 'package:whole_choice_customer/widget_common/loading_indicator.dart';

import '../../category_screen.dart/item_details.dart';

class SearchDetailPage extends StatelessWidget {
  final String? title;
  const SearchDetailPage({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 3, left: 6),
            child: TextFormField(
              enabled: false,
              decoration: InputDecoration(
                  hintText: title,
                  hintStyle: TextStyle(
                    fontFamily: semibold,
                  ),
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: FirestoreServies.getSearchProducts(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else if (snapshot.data!.docs.isEmpty) {
            return "No Product found!".text.color(darkFontGrey).makeCentered();
          } else {
            var data = snapshot.data!.docs;
            var filtered = data
                .where((element) => element['p_name']
                    .toString()
                    .toLowerCase()
                    .contains(title!.toLowerCase()))
                .toList();

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 12,
                      mainAxisExtent: 250),
                  children: filtered
                      .mapIndexed((currentValue, index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                filtered[index]['p_imgs'][0],
                                width: double.infinity,
                                height: 130,
                                fit: BoxFit.cover,
                              ),
                              const Spacer(),
                              "${filtered[index]['p_name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              5.heightBox,
                              "${filtered[index]['p_desc']}".text.make(),
                              5.heightBox,
                              "${filtered[index]['p_price']}"
                                  .numCurrencyWithLocale()
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .make(),
                            ],
                          )
                              .box
                              .white
                              .padding(const EdgeInsets.all(4))
                              .outerShadow
                              .roundedSM
                              .clip(Clip.antiAlias)
                              .make()
                              .onTap(() {
                            Get.to(() => ItemsDetailScreen(
                                title: "${filtered[index]['p_name']}",
                                data: filtered[index]));
                          }))
                      .toList()),
            );
          }
        },
      ),
    );
  }
}
