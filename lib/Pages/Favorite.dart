import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:get/get.dart';
import 'package:untitled/Controller/MyController.dart';
import 'package:untitled/Pages/SecondPage.dart';

import 'AboutApp.dart';
import 'Settings.dart';

class Favorite extends GetView<MyController> {
  Favorite({Key? key}) : super(key: key) {
    controller.getAllFavHadis();
    controller.getAllFavBab();
  }

  SliverAppBar showSliverAppBar(String screenTitle) {
    return SliverAppBar(
      backgroundColor: Color(controller.color.value),
      floating: true,
      pinned: true,
      snap: false,
      title: Text(screenTitle),
      actions: [
        IconButton(
            onPressed: () {
              controller.goRsum();
            },
            icon: Icon(
              Icons.bookmark,
              color: Colors.white,
            )),
        PopupMenuButton<int>(
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              // row has two child icon and text.
              child: Row(
                children: [
                  Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                  SizedBox(
                    // sized box with width 10
                    width: 10,
                  ),
                  Expanded(
                      child: Text(
                    "الاعدادات",
                    textAlign: TextAlign.right,
                  ))
                ],
              ),
            ),
            // popupmenu item 1
            PopupMenuItem(
              value: 2,
              // row has two child icon and text.
              child: Row(
                children: [
                  Icon(
                    Icons.info,
                    color: Colors.black,
                  ),
                  SizedBox(
                    // sized box with width 10
                    width: 10,
                  ),
                  Expanded(
                      child: Text(
                    "عن التطبيق",
                    textAlign: TextAlign.right,
                  ))
                ],
              ),
            ),
            // popupmenu item 2
            PopupMenuItem(
              value: 3,
              // row has two child icon and text.
              child: Row(
                children: [
                  Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                  SizedBox(
                    // sized box with width 10
                    width: 10,
                  ),
                  Expanded(
                      child: Text(
                    "خروج",
                    textAlign: TextAlign.right,
                  ))
                ],
              ),
            ),
          ],
          onSelected: (i) {
            if (i == 1) {
              Get.to(Settings());
            } else if (i == 2) {
              Get.to(AboutApp());
            } else {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            }
          },
        ),
      ],
      bottom: const TabBar(
        tabs: [
          Tab(
            text: 'الاحاديث',
          ),
          Tab(
            text: 'الابواب',
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: DefaultTabController(
        length: 2,
        child: TabBarView(children: [
          // This CustomScrollView display the Home tab content
          Obx(() => CustomScrollView(
                slivers: [
                  showSliverAppBar('المفضلة'),
                  // Anther sliver widget: SliverList
                  Obx(
                    () => SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int indxe) {
                          String Hadis = controller.allFav_hadis[indxe]
                                      ["des_title"]
                                  .toString()
                                  .replaceAll("&lt;", "<")
                                  .split("<FONT COLOR=red>")[
                              controller.allFav_hadis[indxe]["ind"].toInt()];
                          return InkWell(
                            onTap: () {
                              Get.off(SecondPage(
                                controller.allFav_hadis[indxe]["id"],
                                controller.allFav_hadis[indxe]["des_title"]
                                    .toString()
                                    .replaceAll("&lt;", "<")
                                    .split("<FONT COLOR=red>")[0],
                                controller.allFav_hadis[indxe]["ind"],
                              ));
                            },
                            child: Card(
                              elevation: 10,
                              margin: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  IntrinsicHeight(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                            child: Html(
                                          data:
                                              " رقم الحديث <font color='red'>[${Hadis.substring(1, Hadis.indexOf("»"))}]</font>",
                                          style: {
                                            "body": Style(
                                                textAlign: TextAlign.center)
                                          },
                                        )),
                                        VerticalDivider(
                                          color: Colors.black26,
                                          thickness: 2,
                                        ),
                                        Expanded(
                                            child: Html(
                                          data:
                                              " رقم الباب <font color='red'>[${controller.allFav_hadis[indxe]["id"]}]</font>",
                                          style: {
                                            "body": Style(
                                                textAlign: TextAlign.center)
                                          },
                                        ))
                                        //  Text(controller.Titles[int.parse(controller.list_hadis[indxe]["number"].toString().split("b")[0].substring(1))]["title"])
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 0,
                                    thickness: 2,
                                  ),
                                  IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Text(controller
                                                .allFav_hadis[indxe]
                                                    ["des_title"]
                                                .toString()
                                                .replaceAll("&lt;", "<")
                                                .split("<FONT COLOR=red>")[0])),
                                        VerticalDivider(
                                          color: Colors.black26,
                                          thickness: 2,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              controller.ShowHadis(indxe);
                                            },
                                            icon: RotationTransition(
                                                turns: controller
                                                    .TrotationAnimations[indxe],
                                                child: Icon(Icons
                                                    .keyboard_arrow_down)) /*RotationTransition( turns: controller.TrotationAnimationList[indxe],child: const Icon(Icons.keyboard_arrow_down))*/),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 0,
                                    thickness: 2,
                                  ),
                                  Obx(() => Visibility(
                                        visible: controller
                                            .show_hadis.value[indxe].value,
                                        child: Html(
                                          data: "<FONT COLOR=red>${Hadis}",
                                          style: {
                                            "body": Style(
                                                color: controller.colorFont ==
                                                        "اسود"
                                                    ? Colors.black
                                                    : Colors.grey,
                                                fontSize: FontSize(
                                                    controller.fontSize.value),
                                                fontFamily: controller
                                                    .verticalGroupValue.value)
                                          },
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          );
                        },
                        childCount: controller.allFav_hadis.length,
                      ),
                    ),
                  )
                ],
              )),

          // This shows the Settings tab content
          CustomScrollView(
            slivers: [
              showSliverAppBar('المفضلة'),

              // Show other sliver stuff
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(controller.allFav_bab[index]["title"]),
                        onTap: () {
                          Get.off(SecondPage(controller.allFav_bab[index]["id"],
                              controller.allFav_bab[index]["title"], 0));
                        },
                      ),
                      Divider(
                        height: 0,
                        thickness: 2,
                      )
                    ],
                  );
                }, childCount: controller.allFav_bab.length),
              ),
            ],
          )
        ]),
      )),
    );
  }
}
