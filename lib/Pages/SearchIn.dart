import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:untitled/Controller/MyController.dart';
import 'package:untitled/Pages/SecondPage.dart';

class SearchIn extends GetView<MyController> {
  SearchIn({
    Key? key,
    this.title,
    this.id,
    this.query,
    this.num,
  }) : super(key: key) {
    hadis = title.toString().split("<FONT COLOR=red>");
    controller.searchIn(hadis, query);
    controller.loadFav_hadis(id);
  }
  final title;
  final id;
  final query;
  final num;
  List<String>? hadis;
  List<Map> hasFav = [];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(controller.color.value),
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Get.off(SecondPage(
                    id,
                    title.toString().split(":")[0],
                    controller
                        .position.value[controller.inexdTextHight.value]));
              },
              icon: Icon(Icons.close)),
          title: Obx(() => Text("$num/${controller.m7moud}")),
          actions: [
            IconButton(
                onPressed: () {
                  controller.changeHightPlus();
                },
                icon: Icon(Icons.arrow_downward_sharp)),
            IconButton(
                onPressed: () {
                  controller.changeHightMins();
                },
                icon: Icon(Icons.arrow_upward)),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'تنقل بكلمة البحث',
                            textAlign: TextAlign.center,
                          ),
                          content: SingleChildScrollView(
                            child: Html(
                              data:
                                  "نوفر لكم هنا زراير تنقل حيث يمكنكم التنقل بين النصوص بكلمة البحث وهذا يساعد من سرعت البحث ",
                              style: {
                                "body": Style(
                                    fontSize: FontSize(20),
                                    textAlign: TextAlign.center,
                                    fontFamily:
                                        controller.verticalGroupValue.value)
                              },
                            ),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text('ok'),
                              onPressed: () {
                                //  controller.changeColor();
                                Navigator.of(context).pop();
                                //dismiss the color picker
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => Colors.orange)),
                            ),
                          ],
                        );
                      });
                },
                icon: Icon(Icons.question_mark_sharp)),
          ],
        ),
        body: GetBuilder<MyController>(
            builder: (_) => ScrollablePositionedList.separated(
                initialScrollIndex: controller.position.value[0],
                itemScrollController: controller.scrollController2,
                itemBuilder: (context, index) {
                  String data =
                      '<FONT COLOR="blue">${hadis![index].replaceAll("«", "[").replaceAll("»", "]")}';
                  if (index ==
                      controller
                          .position.value[controller.inexdTextHight.value]) {
                    try {
                      int pp = controller.curentHight.value;
                      int posi = 0;
                      String countinueT = "";
                      while (pp != 0) {
                        posi =
                            data.indexOf(query, posi) + query.toString().length;
                        countinueT = data.substring(0, posi);
                        pp--;
                      }
                      String firstData = data.substring(posi,
                          data.indexOf(query, posi) + query.toString().length);
                      String secondData = data.substring(
                          data.indexOf(query, posi) + query.toString().length);
                      firstData = firstData.replaceAll(query,
                          "<mark style='background-color:red'>$query</mark>");
                      secondData =
                          secondData.replaceAll(query, "<mark>$query</mark>");
                      countinueT =
                          countinueT.replaceAll(query, "<mark>$query</mark>");
                      data = countinueT + firstData + secondData;
                    } catch (e) {
                      data = data.replaceAll(query, "<mark>$query</mark>");
                    }
                  }

                  return index == 0
                      ? Text(
                          hadis![index],
                          style: TextStyle(fontSize: 20),
                        )
                      : Card(
                          elevation: 10,
                          margin: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Html(
                                    style: {
                                      "body": Style(
                                          color: controller.colorFont == "اسود"
                                              ? Colors.black
                                              : Colors.grey,
                                          fontSize: FontSize(15))
                                    },
                                    data: data,
                                  )),
                              Divider(
                                height: 2,
                                indent: 20,
                                endIndent: 20,
                              ),
                              Row(
                                children: [
                                  Obx(() => IconButton(
                                      onPressed: () {
                                        controller.fav_hadis(id, index);
                                        /*  if( controller.checkFav(number, index))
                          {
                            controller.removeHads(number, index);
                          }else controller.addHad(number, index,controller.ind);*/
                                      },
                                      icon: Icon(
                                        Icons.star_border_sharp,
                                        color: controller.indexFav.value
                                                .contains(index)
                                            ? Colors.red
                                            : Colors.black,
                                      ))),
                                  Expanded(child: Text("")),
                                  IconButton(
                                      onPressed: () {
                                        controller.share(
                                            hadis![0], hadis![index], "");
                                      },
                                      icon: Icon(Icons.share)),
                                  IconButton(
                                      onPressed: () {
                                        Clipboard.setData(
                                            ClipboardData(text: hadis![index]));
                                      },
                                      icon: Icon(Icons.copy)),
                                ],
                              )
                            ],
                          ),
                        );
                },
                separatorBuilder: (context, index) => SizedBox(
                      height: 20,
                    ),
                itemCount: hadis!.length)),
      ),
    );
  }
}
