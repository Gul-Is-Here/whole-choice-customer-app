import 'package:whole_choice_customer/consts/consts.dart';
import 'package:whole_choice_customer/controller/home_controller.dart';
import 'package:whole_choice_customer/views/Profile_screen/profile_screen.dart';
import 'package:whole_choice_customer/views/cart_screen/cart_screen.dart';
import 'package:whole_choice_customer/views/category_screen.dart/category_screen.dart';
import 'package:whole_choice_customer/views/home-screens/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whole_choice_customer/widget_common/exit_dialog.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navBarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 25,
          ),
          label: home),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCategories,
            width: 25,
          ),
          label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCart,
            width: 25,
          ),
          label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 25,
          ),
          label: account),
    ];
    var navBody = [
      const HomeScreen(),
      const CategoryScreen(),
      CartScreen(),
      const ProfileScreen()
    ];
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(() => Expanded(
                  child: navBody.elementAt(controller.currentNavIndex.value),
                )),
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
              currentIndex: controller.currentNavIndex.value,
              selectedItemColor: yellowColor,
              selectedLabelStyle: const TextStyle(fontFamily: semibold),
              type: BottomNavigationBarType.fixed,
              backgroundColor: whiteColor,
              items: navBarItem,
              onTap: (value) => controller.currentNavIndex.value = value),
        ),
      ),
    );
  }
}
