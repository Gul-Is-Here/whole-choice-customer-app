import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whole_choice_customer/consts/consts.dart';
import 'package:whole_choice_customer/controller/product_controller.dart';
import 'package:whole_choice_customer/services/firestore_services.dart';
import 'package:whole_choice_customer/views/category_screen.dart/item_details.dart';
import 'package:whole_choice_customer/widget_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whole_choice_customer/widget_common/loading_indicator.dart';

class CategoriesDetail extends StatefulWidget {
  final String? title;
  const CategoriesDetail({super.key, required this.title});

  @override
  State<CategoriesDetail> createState() => _CategoriesDetailState();
}

class _CategoriesDetailState extends State<CategoriesDetail> {
  @override
  void initState() {
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (contoller.subcat.contains(title)) {
      productMethod = FirestoreServies.getProductSubCategory(title);
    } else {
      productMethod = FirestoreServies.getProducts(title);
    }
  }

  var contoller = Get.find<ProductController>();
  dynamic productMethod;
  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
            appBar: AppBar(
                elevation: 1,
                title: widget.title!.text.fontFamily(bold).white.make()),
            body: Column(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                        contoller.subcat.length,
                        (index) => "${contoller.subcat[index]}"
                                .text
                                .size(12)
                                .fontFamily(semibold)
                                .makeCentered()
                                .box
                                .color(yellowColor)
                                .rounded
                                .margin(const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 4))
                                .size(120, 60)
                                .make()
                                .onTap(() {
                              switchCategory("${contoller.subcat[index]}");
                              setState(() {});
                            })),
                  ),
                ),
                20.heightBox,
                StreamBuilder(
                  stream: productMethod,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(child: loadingIndicator());
                    } else if (snapshot.data!.docs.isEmpty) {
                      return Expanded(
                        child: Center(
                            child: "No Products Found!"
                                .text
                                .color(fontGrey)
                                .makeCentered()),
                      );
                    } else {
                      var data = snapshot.data!.docs;
                      return Expanded(
                          child: GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: data.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisExtent: 250,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        data[index]['p_imgs'][0],
                                        width: 160,
                                        fit: BoxFit.cover,
                                      ),
                                      10.heightBox,
                                      "${data[index]['p_name']}"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      10.heightBox,
                                      " ${data[index]['p_price']}"
                                          .numCurrencyWithLocale()
                                          .text
                                          .color(redColor)
                                          .fontFamily(bold)
                                          .make()
                                    ],
                                  )
                                      .box
                                      .rounded
                                      .white
                                      .padding(const EdgeInsets.all(8))
                                      .outerShadow
                                      .clip(Clip.antiAlias)
                                      .make()
                                      .onTap(() {
                                    contoller.checkIfFav(data[index]);
                                    Get.to(
                                      () => ItemsDetailScreen(
                                          title: "${data[index]['p_name']}",
                                          data: data[index]),
                                    );
                                  }),
                                );
                              }));
                    }
                  },
                ),
              ],
            )));
  }
}
