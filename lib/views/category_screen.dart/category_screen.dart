import 'package:whole_choice_customer/consts/consts.dart';
import 'package:whole_choice_customer/consts/iconList.dart';
import 'package:whole_choice_customer/controller/product_controller.dart';
import 'package:whole_choice_customer/views/category_screen.dart/category_detail.dart';
import 'package:whole_choice_customer/widget_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var contoller = Get.put(ProductController());
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 1,
        title: categories.text.fontFamily(bold).white.make(),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              mainAxisExtent: 200,
              crossAxisSpacing: 8.0,
            ),
            itemBuilder: (context, index) => Column(
                  children: [
                    Image.asset(
                      categoriesImages[index],
                      height: 120,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    10.heightBox,
                    categoriesList[index]
                        .text
                        .color(darkFontGrey)
                        .align(TextAlign.center)
                        .make()
                  ],
                )
                    .box
                    .rounded
                    .white
                    .outerShadow
                    .clip(Clip.antiAlias)
                    .make()
                    .onTap(() {
                  contoller.getSubCategories(categoriesList[index]);
                  Get.to(() => CategoriesDetail(title: categoriesList[index]));
                })),
      ),
    ));
  }
}
