import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:untitled/Controller/MyController.dart';
import 'package:untitled/Pages/SecondPage.dart';

import 'AboutApp.dart';
import 'Settings.dart';

class Note extends GetView<MyController> {
  Note({Key? key}) : super(key: key) {
    controller.getAllNote();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Obx(() => Scaffold(
            appBar: AppBar(
              backgroundColor: Color(controller.color.value),
              title: Text("ملاحظاتي"),
              actions: [
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
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    }
                  },
                )
              ],
            ),
            body: Obx(() => ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      controller.wrapChange(index);
                    },
                    child: Card(
                      elevation: 10,
                      margin: EdgeInsets.all(10),
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  controller.titlesFilter[int.parse(controller
                                      .notes[index]["id"]
                                      .toString())]["title"],
                                  style: TextStyle(fontSize: 20),
                                ),
                                Divider(
                                  height: 0,
                                  thickness: 3,
                                  color: Colors.black54,
                                ),
                                Obx(() {
                                  return Container(
                                    height: controller.wrap.value[index].value
                                        ? null
                                        : 100,
                                    child: Text(
                                      controller.notes[index]["note"],
                                      maxLines:
                                          controller.wrap.value[index].value
                                              ? null
                                              : 3,
                                      overflow:
                                          controller.wrap.value[index].value
                                              ? null
                                              : TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 20),
                                    ),
                                  );
                                }),
                              ],
                            )),
                            Column(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Get.to(SecondPage(
                                          controller.notes[index]["id"] + 1,
                                          controller.titles[int.parse(controller
                                              .notes[index]["id"]
                                              .toString())]["title"],
                                          0));
                                    },
                                    icon: Icon(
                                      Icons.settings_backup_restore,
                                      color: Color(controller.color.value),
                                    )),
                                IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          TextEditingController myController =
                                              TextEditingController()
                                                ..text = controller
                                                    .notes.value[index]["note"];
                                          return Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Form(
                                              child: AnimatedPadding(
                                                padding: MediaQuery.of(context)
                                                    .viewInsets,
                                                duration: const Duration(
                                                    milliseconds: 100),
                                                curve: Curves.decelerate,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      4.5,
                                                  child: Obx(() => Column(
                                                        children: <Widget>[
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child:
                                                                TextFormField(
                                                              maxLines: 2,
                                                              minLines: 2,
                                                              autofocus: true,
                                                              controller:
                                                                  myController,
                                                              onChanged:
                                                                  (text) {
                                                                controller
                                                                    .lenghtText
                                                                    .value = text;
                                                              },
                                                              decoration: InputDecoration(
                                                                  hintText:
                                                                      "اضف ملحوظة",
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              IconButton(
                                                                  onPressed:
                                                                      controller.lenghtText.value.length >
                                                                              0
                                                                          ? () {
                                                                              controller.db!.updateNote(controller.notes[index]["id"], controller.lenghtText.value);
                                                                              controller.getAllNote();
                                                                              // controller.addnote(controller.id.value, controller.lenghtText.value);
                                                                              Navigator.of(context).pop();
                                                                            }
                                                                          : null,
                                                                  icon: Icon(
                                                                    Icons.save,
                                                                    color: controller.lenghtText.value.length >
                                                                            0
                                                                        ? Colors
                                                                            .orangeAccent
                                                                        : Colors
                                                                            .grey,
                                                                  )),
                                                            ],
                                                          )
                                                        ],
                                                      )),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ).whenComplete(() =>
                                          controller.lenghtText.value = "");
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Color(controller.color.value),
                                    )),
                                IconButton(
                                    onPressed: () {
                                      controller.deleteNote(index);
                                      // controller.getAllNote();
                                      controller.checknote();
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Color(controller.color.value),
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: controller.notes.length)),
          )),
    );
  }
}
