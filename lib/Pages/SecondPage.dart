import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:untitled/Controller/MyController.dart';
import 'package:untitled/Pages/AboutApp.dart';
import 'package:untitled/Pages/Favorite.dart';
import 'package:untitled/Pages/Note.dart';
import 'package:untitled/Pages/Settings.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SecondPage extends GetView<MyController> {
  SecondPage(this.id, this.title, this.scroll_toIndxe, {Key? key})
      : super(key: key) {
    controller.title.value = title;
    controller.loadDes(id);
  }
  //final controller=Get.put(MyController());
  ItemScrollController itemScrollController = ItemScrollController();
  final id;
  final title;
  int scroll = 0;
  bool skip = false;
  final scroll_toIndxe;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Obx(() => Scaffold(
            floatingActionButton: controller.showBtns != "اخفاء دائما"
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Obx(
                        () => AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child: controller.shoFad.isTrue
                              ? FloatingActionButton(
                                  backgroundColor:
                                      Color(controller.color.value),
                                  heroTag: "down",
                                  onPressed: () {
                                    if (controller.currentIndex.value <
                                        controller.dse_bab!.length - 1) {
                                      controller.currentIndex.value++;
                                      skip = true;
                                      itemScrollController.scrollTo(
                                          index:
                                              controller.currentIndex.value++,
                                          duration:
                                              Duration(milliseconds: 100));
                                    }
                                  },
                                  child: Icon(Icons.arrow_drop_down),
                                )
                              : null,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Obx(
                        () => AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child: controller.shoFad.isTrue
                              ? FloatingActionButton(
                                  backgroundColor:
                                      Color(controller.color.value),
                                  heroTag: "up",
                                  onPressed: () {
                                    if (controller.currentIndex.value > 1) {
                                      controller.currentIndex.value--;
                                      skip = true;
                                      itemScrollController.scrollTo(
                                          index: controller.currentIndex.value >
                                                  0
                                              ? controller.currentIndex.value--
                                              : 0,
                                          duration:
                                              Duration(milliseconds: 100));
                                    }
                                  },
                                  child: Icon(Icons.arrow_drop_up),
                                )
                              : null,
                        ),
                      ),
                    ],
                  )
                : null,
            appBar: AppBar(
              backgroundColor: Color(controller.color.value),
              title: Obx(() => Text(controller.title.value)),
              actions: [
                Obx(() => IconButton(
                    onPressed: () {
                      controller.fav_bab(controller.id);
                    },
                    icon: Icon(
                      Icons.favorite,
                      color:
                          controller.isFav.isTrue ? Colors.red : Colors.white,
                    ))),
                PopupMenuButton<int>(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      // row has two child icon and text.
                      child: Row(
                        children: [
                          Icon(
                            Icons.share,
                            color: Colors.black,
                          ),
                          SizedBox(
                            // sized box with width 10
                            width: 10,
                          ),
                          Expanded(
                              child: Text(
                            "مشاركة",
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
                            Icons.copy,
                            color: Colors.black,
                          ),
                          SizedBox(
                            // sized box with width 10
                            width: 10,
                          ),
                          Expanded(
                              child: Text(
                            "نسخ",
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
                            Icons.note,
                            color: Colors.black,
                          ),
                          SizedBox(
                            // sized box with width 10
                            width: 10,
                          ),
                          Expanded(
                              child: Text(
                            "ملاحظاتي",
                            textAlign: TextAlign.right,
                          ))
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 4,
                      // row has two child icon and text.
                      child: Row(
                        children: [
                          Icon(
                            Icons.note_alt_sharp,
                            color: Colors.black,
                          ),
                          SizedBox(
                            // sized box with width 10
                            width: 10,
                          ),
                          Expanded(
                              child: Text(
                            controller.hasNote.isEmpty
                                ? "اضافة ملاحظة"
                                : "تعديل الملاحظة",
                            textAlign: TextAlign.right,
                          ))
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 5,
                      // row has two child icon and text.
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: Colors.black,
                          ),
                          SizedBox(
                            // sized box with width 10
                            width: 10,
                          ),
                          Expanded(
                              child: Text(
                            "المفضلة",
                            textAlign: TextAlign.right,
                          ))
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 6,
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
                    PopupMenuItem(
                      value: 7,
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
                    PopupMenuItem(
                      value: 8,
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
                    switch (i) {
                      case 1:
                        controller.share(controller.title.value,
                            controller.dse_bab!.join(" "), "");
                        break;
                      case 2:
                        Clipboard.setData(ClipboardData(
                            text: controller.parseHtmlString(
                                controller.dse_bab!.join(""))));
                        break;
                      case 3:
                        {
                          Get.to(Note());
                        }
                        break;
                      case 4:
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            TextEditingController myController =
                                TextEditingController()
                                  ..text = controller.hasNote.value.length > 0
                                      ? controller.hasNote.value[0]["note"]
                                      : "";
                            return Directionality(
                              textDirection: TextDirection.rtl,
                              child: Form(
                                child: AnimatedPadding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  duration: const Duration(milliseconds: 100),
                                  curve: Curves.decelerate,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    height: MediaQuery.of(context).size.height /
                                        4.5,
                                    child: Obx(() => Column(
                                          children: <Widget>[
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              child: TextFormField(
                                                maxLines: 2,
                                                minLines: 2,
                                                autofocus: true,
                                                controller: myController,
                                                onChanged: (text) {
                                                  controller.lenghtText.value =
                                                      text;
                                                },
                                                decoration: InputDecoration(
                                                    hintText: "اضف ملحوظة",
                                                    border: InputBorder.none),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: controller
                                                                .lenghtText
                                                                .value
                                                                .length >
                                                            0
                                                        ? () {
                                                            controller.addnote(
                                                                controller
                                                                    .id.value,
                                                                controller
                                                                    .lenghtText
                                                                    .value);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          }
                                                        : null,
                                                    icon: Icon(
                                                      Icons.save,
                                                      color: controller
                                                                  .lenghtText
                                                                  .value
                                                                  .length >
                                                              0
                                                          ? Colors.orangeAccent
                                                          : Colors.grey,
                                                    )),
                                                IconButton(
                                                  onPressed: controller
                                                          .hasNote.isNotEmpty
                                                      ? () {
                                                          controller.removeNote(
                                                              controller.id);
                                                          Navigator.of(context)
                                                              .pop();
                                                        }
                                                      : null,
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: controller
                                                            .hasNote.isNotEmpty
                                                        ? Colors.orangeAccent
                                                        : null,
                                                  ),
                                                  disabledColor: Colors.grey,
                                                )
                                              ],
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                              ),
                            );
                          },
                        ).whenComplete(() => controller.lenghtText.value = "");
                        break;
                      case 5:
                        Get.to(Favorite());
                        break;
                      case 6:
                        Get.to(Settings());
                        break;
                      case 7:
                        Get.to(AboutApp());
                        break;
                      case 8:
                        SystemChannels.platform
                            .invokeMethod('SystemNavigator.pop');
                        break;
                    }
                  },
                )
              ],
            ),
            body: PageView.builder(
              controller: PageController(
                  initialPage: id - 1, viewportFraction: 1, keepPage: true),
              onPageChanged: (index) {
                controller.loadDes(index + 1);
              },
              itemBuilder: (context, indexP) => Obx(
                () => NotificationListener(
                  onNotification: (t) {
                    if (t is ScrollEndNotification) {
                      if (controller.showBtns.value ==
                          "اظهار / واخفاء".toString()) if (!skip) {
                        t.metrics.pixels > scroll
                            ? controller.shoFad.value = false
                            : controller.shoFad.value = true;
                        scroll = t.metrics.pixels.toInt();
                        skip = false;
                      } else
                        skip = false;
                    }
                    return true;
                  },
                  child: ScrollablePositionedList.separated(
                    initialScrollIndex: scroll_toIndxe,
                    itemScrollController: itemScrollController,
                    itemCount: controller.dse_bab!.length,
                    itemBuilder: (context, index) => index == 0
                        ? Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              controller.dse_bab!.first,
                              style: TextStyle(fontSize: 20),
                            ))
                        : VisibilityDetector(
                            key: Key(index.toString()),
                            onVisibilityChanged: (VisibilityInfo info) {
                              if (info.visibleFraction == 1)
                                controller.currentIndex.value = index;
                            },
                            child: Card(
                              margin: EdgeInsets.all(10),
                              elevation: 10,
                              child: Column(
                                children: [
                                  Obx(
                                    () => Html(
                                      data:
                                          "<FONT COLOR=blue>${controller.dse_bab![index]}",
                                      style: {
                                        "body": Style(
                                            fontSize: FontSize(
                                                controller.fontSize.value),
                                            color:
                                                controller.colorFont == "اسود"
                                                    ? Colors.black
                                                    : Colors.grey,
                                            fontFamily: controller
                                                .verticalGroupValue.value)
                                      },
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1,
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Clipboard.setData(ClipboardData(
                                                text: controller
                                                    .parseHtmlString(controller
                                                        .dse_bab![index])));
                                          },
                                          icon: Icon(Icons.copy)),
                                      IconButton(
                                          onPressed: () {
                                            controller.share(
                                                controller.dse_bab!.first,
                                                controller.dse_bab![index],
                                                "");
                                          },
                                          icon: Icon(Icons.share_sharp)),
                                      Expanded(child: Text("")),
                                      Obx(() => IconButton(
                                          onPressed: () {
                                            controller.fav_hadis(
                                                controller.id, index);
                                          },
                                          icon: Icon(Icons.star_border_sharp,
                                              color: controller.indexFav.value
                                                      .contains(index)
                                                  ? Colors.red
                                                  : Colors.black)))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                    separatorBuilder: (context, index) => Container(),
                  ),
                ),
              ),
              itemCount: 55,
            ),
          )),
    );
  }
}
