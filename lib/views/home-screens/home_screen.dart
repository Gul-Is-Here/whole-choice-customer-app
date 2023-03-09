import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:whole_choice_customer/consts/iconList.dart';
import 'package:whole_choice_customer/controller/home_controller.dart';
import 'package:whole_choice_customer/controller/product_controller.dart';
import 'package:whole_choice_customer/services/firestore_services.dart';
import 'package:whole_choice_customer/views/category_screen.dart/item_details.dart';
import 'package:whole_choice_customer/views/home-screens/components/featured_button.dart';
import 'package:whole_choice_customer/views/home-screens/home.dart';
import 'package:whole_choice_customer/widget_common/home_buton.dart';
import 'package:whole_choice_customer/widget_common/loading_indicator.dart';

import '/consts/consts.dart';
import 'package:flutter/material.dart';

import 'components/search.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controllr = Get.put(ProductController());
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
      ),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 90,
          backgroundColor: Colors.white,
          elevation: 1,
          leading: Padding(
            padding: const EdgeInsets.only(
              top: 37,
              bottom: 5,
              left: 6,
            ),
            child: Image.asset(
              icApplogo1,
              fit: BoxFit.cover,
              height: 45,
              width: 45,
            ).box.roundedSM.clip(Clip.antiAlias).make().onTap(() {
              Get.offAll(() => Home());
              // Navigator.of(context)
              //     .pushReplacement(MaterialPageRoute(builder: (context) {
              //   return const HomeScreen();
              // }));
            }),
          ),
          title: ListTile(
            title: const Padding(
              padding: EdgeInsets.only(bottom: 5, right: 30),
              child: Center(
                  child: Text(
                'Wholee Choice',
                style: TextStyle(
                    fontFamily: bold,
                    color: yellowColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              )),
            ),
            subtitle: Container(
              width: context.screenWidth,
              height: 45,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                  child: TextFormField(
                cursorColor: yellowColor,
                showCursor: true,
                readOnly: true,
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const SearchPage();
                  }));
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black12,
                    suffixIcon: Container(
                      color: yellowColor,
                      child: IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: whiteColor,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const SearchPage();
                          }));
                        },
                      ),
                    ).box.roundedSM.clip(Clip.antiAlias).make(),
                    hintText: searchAnything,
                    border: InputBorder.none),
              ).box.roundedSM.clip(Clip.antiAlias).make()),
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(
            top: 0,
            left: 4,
            right: 4,
          ),
          color: whiteColor,
          width: context.screenWidth,
          height: context.screenHeight,
          child: SafeArea(
            child: Column(
              children: [
                // 20.heightBox,
                Expanded(
                  child: SingleChildScrollView(
                    // physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        VxSwiper.builder(
                            aspectRatio: 16 / 9,
                            autoPlay: true,
                            height: 140,
                            // enlargeCenterPage: true,
                            itemCount: sliderList.length,
                            itemBuilder: (context, index) {
                              return Image.asset(
                                sliderList[index],
                                fit: BoxFit.cover,
                                // width: double.infinity,
                              )
                                  .box
                                  .shadowSm
                                  .clip(Clip.antiAlias)
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 6))
                                  .make();
                            }),
                        20.heightBox,
                        // ----->  Deals Buttons   <------------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                              2,
                              (index) => homeButton(
                                    height: context.screenHeight * .15,
                                    width: context.screenWidth / 2.5,
                                    icon:
                                        index == 0 ? icTodaysDeal : icFlashDeal,
                                    title: index == 0 ? todayDeal : flashSale,
                                  )),
                        ),
                        20.heightBox,
                        //  ------>  2nd Slider <------
                        VxSwiper.builder(
                            aspectRatio: 16 / 9,
                            autoPlay: true,
                            height: 140,
                            enlargeCenterPage: true,
                            itemCount: secondSliderList.length,
                            itemBuilder: (context, index) {
                              return Image.asset(
                                secondSliderList[index],
                                fit: BoxFit.cover,
                              )
                                  .box
                                  .rounded
                                  .shadowMd
                                  .clip(Clip.antiAlias)
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 8))
                                  .make();
                            }),
                        20.heightBox,
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(
                                  3,
                                  (index) => homeButton(
                                      height: context.screenHeight * .14,
                                      width: context.screenWidth / 3.5,
                                      icon: index == 0
                                          ? icTopCategories
                                          : index == 1
                                              ? icBrands
                                              : icTopSeller,
                                      title: index == 0
                                          ? topCategories
                                          : index == 1
                                              ? brand
                                              : topSaller)),
                            )),

                        // ------> Feature Categories  <-----
                        20.heightBox,

                        Align(
                          alignment: Alignment.centerLeft,
                          child: featureCategories.text
                              .color(darkFontGrey)
                              .size(18)
                              .fontFamily(semibold)
                              .make(),
                        ),
                        20.heightBox,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                3,
                                (index) => Column(
                                      children: [
                                        featuredButton(
                                            icon: featuredImages1[index],
                                            title: featuredTitle1[index]),
                                        10.heightBox,
                                        featuredButton(
                                            icon: featuredImages2[index],
                                            title: featuredTitle2[index])
                                      ],
                                    )).toList(),
                          ),
                        ),
                        // ---> Featured Products <----

                        20.heightBox,
                        Container(
                          padding: const EdgeInsets.all(4),
                          width: double.infinity,
                          decoration: const BoxDecoration(color: yellowColor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              featureProduct.text.white
                                  .fontFamily(bold)
                                  .size(18)
                                  .make(),
                              10.heightBox,
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: StreamBuilder(
                                    stream:
                                        FirestoreServies.getFeaturedProduct(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData) {
                                        return loadingIndicator();
                                      } else if (snapshot.data!.docs.isEmpty) {
                                        return "No Featured Product"
                                            .text
                                            .makeCentered();
                                      } else {
                                        var featureData = snapshot.data!.docs;
                                        return Row(
                                          children: List.generate(
                                              featureData.length,
                                              (index) => Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Image.network(
                                                        featureData[index]
                                                            ['p_imgs'][0],
                                                        width: 130,
                                                        height: 130,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      10.heightBox,
                                                      "${featureData[index]['p_name']}"
                                                          .text
                                                          .fontFamily(semibold)
                                                          .color(darkFontGrey)
                                                          .make(),
                                                      10.heightBox,
                                                      "${featureData[index]['p_price']}"
                                                          .numCurrencyWithLocale()
                                                          .text
                                                          .color(redColor)
                                                          .fontFamily(bold)
                                                          .make()
                                                    ],
                                                  )
                                                      .box
                                                      .white
                                                      .margin(const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 4))
                                                      .topRounded(value: 10.0)
                                                      .padding(
                                                          const EdgeInsets.all(
                                                              4))
                                                      .clip(Clip.antiAlias)
                                                      .make()
                                                      .onTap(() {
                                                    Get.to(() => ItemsDetailScreen(
                                                        title:
                                                            "${featureData[index]['p_name']}",
                                                        data: featureData[
                                                            index]));
                                                  })),
                                        );
                                      }
                                    }),
                              ),
                            ],
                          ),
                        ),
                        20.heightBox,
                        //  ------>  2nd Slider <------
                        VxSwiper.builder(
                            aspectRatio: 16 / 9,
                            autoPlay: true,
                            height: 140,
                            enlargeCenterPage: true,
                            itemCount: secondSliderList.length,
                            itemBuilder: (context, index) {
                              return Image.asset(
                                secondSliderList[index],
                                fit: BoxFit.fill,
                              )
                                  .box
                                  .shadowMd
                                  .rounded
                                  .clip(Clip.antiAlias)
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 8))
                                  .make();
                            }),
                        20.heightBox,

                        // ----->  All Product <-----
                        StreamBuilder(
                          stream: FirestoreServies.allProducts(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return loadingIndicator();
                            } else {
                              var allProductsData = snapshot.data!.docs;
                              return GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: allProductsData.length,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 15,
                                          crossAxisSpacing: 12,
                                          mainAxisExtent: 250),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          allProductsData[index]['p_imgs'][0],
                                          width: double.infinity,
                                          height: 130,
                                          fit: BoxFit.cover,
                                        ),
                                        const Spacer(),
                                        "${allProductsData[index]['p_desc']}"
                                            .text
                                            .fontFamily(semibold)
                                            .color(darkFontGrey)
                                            .make(),
                                        10.heightBox,
                                        "${allProductsData[index]['p_price']}"
                                            .numCurrencyWithLocale()
                                            .text
                                            .color(redColor)
                                            .fontFamily(bold)
                                            .make(),
                                        5.heightBox
                                      ],
                                    )
                                        .box
                                        .white
                                        .outerShadow
                                        .topRounded(value: 5.0)
                                        .clip(Clip.antiAlias)
                                        .make()
                                        .onTap(() {
                                      Get.to(() => ItemsDetailScreen(
                                          title:
                                              "${allProductsData[index]['p_name']}",
                                          data: allProductsData[index]));
                                    });
                                  });
                            }
                          },
                        ),
                      ],
                    )
                        .box
                        .white
                        .margin(const EdgeInsets.symmetric(horizontal: 4))
                        .roundedSM
                        .shadowSm
                        .padding(const EdgeInsets.all(12))
                        .make(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
