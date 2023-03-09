import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whole_choice_customer/consts/consts.dart';
import 'package:whole_choice_customer/controller/home_controller.dart';
import 'package:whole_choice_customer/views/home-screens/components/search_detail.dart';

import '../../../controller/product_controller.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    var contoller = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          // The search area here
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextFormField(
                autofocus: true,
                cursorColor: yellowColor,
                controller: contoller.searchController,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 40,
                      color: yellowColor,
                    ).onTap(() {
                      if (contoller
                          .searchController.text.isNotEmptyAndNotNull) {
                        Get.to(() => SearchDetailPage(
                              title: contoller.searchController.text,
                            ));
                      }
                    }),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.black26,
                      ),
                      onPressed: () {
                        contoller.searchController.clear();
                      },
                    ),
                    hintText: 'Search...',
                    border: InputBorder.none),
              ),
            ),
          )),
    );
  }
}
