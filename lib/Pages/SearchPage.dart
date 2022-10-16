import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:untitled/Pages/SecondPage.dart';

import '../Controller/MyController.dart';
import 'SearchIn.dart';

class SearchPage extends GetView<MyController> {
  int num = 0;

  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            Obx(() => SliverAppBar(
                  backgroundColor: Color(controller.color.value),
                  floating: true,
                  pinned: true,
                  snap: false,
                  centerTitle: false,
                  title: Container(
                    child: DropdownButton<String>(
                      value: controller.dropdownValue.value,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      underline: Container(
                        height: 2,
                        color: Colors.white,
                      ),
                      onChanged: (data) {
                        controller.dropdownValue.value = data.toString();
                        // controller.changeDrop(data);
                        //controller.textcont.clear();
                      },
                      items: controller.spinnerItems
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(
                        Icons.delete_sweep,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        textEditingController.clear();
                        controller.clearSearch();
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.question_mark_sharp,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'طريقة البحث',
                                  textAlign: TextAlign.center,
                                ),
                                content: SingleChildScrollView(
                                  child: Html(
                                    data:
                                        "طريقة البحث اولا البحث في نص الكتاب وهذه الطريقة تقوم بالبحث في الكتب باكملها وترجع الكتاب والباب الذي ذكرة فية كلمة البحث وعدد وقوعها في البحث مثلا كلمة <mark>محمود  </mark>وقعت في باب من اسمه احمد - باب الالف  ووقعت عدد 3 مرات وعند الضعط ينقللك الي الكلمة في النص نفسة اما بالنسبة في البحث برقم الحديث  يظهر الحديث وعند الضغط ينقللك الي الحديث",
                                    style: {
                                      "body": Style(
                                          fontSize: FontSize(20),
                                          color: controller.colorFont == "اسود"
                                              ? Colors.black
                                              : Colors.grey,
                                          textAlign: TextAlign.center)
                                    },
                                  ),
                                ),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: const Text('ok'),
                                    onPressed: () {
                                      // controller.changeColor();
                                      Navigator.of(context).pop();
                                      //dismiss the color picker
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateColor.resolveWith(
                                                (states) =>
                                                    Colors.orangeAccent)),
                                  ),
                                ],
                              );
                            });
                      },
                    ),
                  ],
                  bottom: AppBar(
                    backgroundColor: Color(controller.color.value),
                    automaticallyImplyLeading: false,
                    title: Container(
                      width: double.infinity,
                      height: 40,
                      color: Colors.white,
                      child: Obx(() => Stack(
                            children: [
                              Visibility(
                                visible: controller.dropdownValue ==
                                    controller.spinnerItems[0],
                                child: Center(
                                  child: TextField(
                                    controller: textEditingController,
                                    onChanged: (text) {
                                      controller.textSearch.value = text;
                                      if (text.length > 3)
                                        controller.Search(text);
                                      else
                                        controller.clearSearch();
                                    },
                                    autofocus: true,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'ابحث هنا في نص الكتاب',
                                      prefixIcon: Icon(Icons.search),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: controller.dropdownValue ==
                                    controller.spinnerItems[1],
                                child: Center(
                                  child: TextField(
                                    controller: textEditingController,
                                    onChanged: (text) async {
                                      if (text.length > 0)
                                        controller.SearchByNum(text);
                                      else
                                        controller.clearSearch();
                                    },
                                    keyboardType: TextInputType.number,
                                    autofocus: true,
                                    decoration: InputDecoration(
                                      hintText: ' ابحث هنا برقم الحديث',
                                      prefixIcon: Icon(Icons.search),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                )),
            // Other Sliver Widgets
            Obx(() => controller.dropdownValue.value ==
                    controller.spinnerItems[0]
                ? SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Card(
                        margin: EdgeInsets.all(10),
                        elevation: 10,
                        child: ListTile(
                          onTap: () async {
                            Get.to(SearchIn(
                                title: controller.searches[index]["des_title"]
                                    .toString()
                                    .replaceAll("&lt;", "<"),
                                id: controller.searches[index]["id"],
                                query: controller.textSearch.value,
                                num: controller.bab_counts.value[index] - 1));
                          },
                          title: Text(
                            controller.searches[index]["des_title"]
                                .toString()
                                .split(":")[0],
                            style: TextStyle(color: Colors.grey, fontSize: 20),
                          ),
                          subtitle: Text(
                            "عدد النتائج:${controller.bab_counts.value[index] - 1}",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color(controller.color.value)),
                          ),
                        ),
                      );
                    }, childCount: controller.searches.length),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Obx(() => controller.OkSearchByNum.value.length > 0
                          ? InkWell(
                              onTap: () {
                                Get.to(SecondPage(
                                    int.parse(
                                        controller.OkSearchByNum.value[3]),
                                    controller.OkSearchByNum.value[0],
                                    int.parse(
                                        controller.OkSearchByNum.value[2])));
                              },
                              child: Card(
                                margin: EdgeInsets.all(10),
                                elevation: 10,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Html(
                                            data: controller
                                                .OkSearchByNum.value[1],
                                            style: {
                                              "body": Style(
                                                  fontSize: FontSize(20),
                                                  fontFamily: controller
                                                      .verticalGroupValue.value)
                                            },
                                          ),
                                          Divider(
                                            thickness: 2,
                                            height: 0,
                                          ),
                                          ListTile(
                                            title: Text(controller
                                                .OkSearchByNum.value[0]),
                                          )
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.keyboard_return_sharp,
                                          color: Colors.black,
                                        ))
                                  ],
                                ),
                              ),
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            ));
                    }, childCount: 1),
                  ))
          ],
        ),
      ),
    );
  }
}
