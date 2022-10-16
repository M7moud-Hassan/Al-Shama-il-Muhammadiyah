import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:untitled/Controller/MyController.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:untitled/Pages/AboutApp.dart';
import 'package:untitled/Pages/Favorite.dart';
import 'package:untitled/Pages/SecondPage.dart';
import 'package:untitled/Pages/Settings.dart';

import 'SearchPage.dart';

class Home extends GetView<MyController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Obx(() => Scaffold(
              appBar: AppBar(
                backgroundColor: Color(controller.color.value),
                leading: IconButton(
                  onPressed: () {
                    controller.AnimateIcon();
                  },
                  icon: controller.animationController != null
                      ? AnimatedIcon(
                          icon: AnimatedIcons.menu_arrow,
                          progress: controller.animationController!,
                        )
                      : Icon(Icons.add),
                ),
                title: Obx(() => controller.isSearch.isTrue
                    ? Container(
                        child: TextField(
                          onChanged: (text) {
                            controller.Filter(text);
                          },
                          autofocus: true,
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    : controller.isDrawerOpen.isTrue
                        ? Text("الشمائل المحمدية")
                        : controller.pMenu == 0
                            ? Text("الابواب")
                            : controller.pMenu == 1
                                ? Text("عن الكتاب")
                                : controller.pMenu == 2
                                    ? Text("نبذة مختصرة عن الامام الترميذي")
                                    : Text("ترجمة الامام الترميذي")),
                actions: [
                  Obx(() => controller.isSearch.isFalse &&
                          controller.isDrawerOpen.isFalse
                      ? IconButton(
                          onPressed: () {
                            controller.openSerach();
                          },
                          icon: Icon(Icons.search))
                      : Container())
                ],
              ),
              body: Scaffold(
                key: controller.scaffoldKey,
                onDrawerChanged: (isOpen) {
                  if (controller.titles.length !=
                      controller.titlesFilter.length)
                    controller.titles.value = controller.titlesFilter;
                  controller.isDrawerOpen.value = isOpen;
                  isOpen && controller.isSearch.value
                      ? controller.openSerach()
                      : null;
                  isOpen
                      ? controller.animationController!.forward()
                      : controller.animationController!.reverse();
                },
                drawer: Drawer(
                  backgroundColor: Colors.grey.shade900,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          highlightColor:
                              Color(controller.color.value).withOpacity(0.5),
                          splashColor:
                              Color(controller.color.value).withOpacity(0.5),
                          onTap: () {
                            controller.visvibleSec.value =
                                !controller.visvibleSec.value;
                            controller.visvibleSec.isTrue
                                ? controller.Tcontroller.forward()
                                : controller.Tcontroller.reverse();
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.menu_book,
                              color: Colors.white,
                            ),
                            title: Text(
                              "عن الكتاب والامام",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            trailing: RotationTransition(
                              turns: controller.TrotationAnimation,
                              child: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Obx(() => Visibility(
                            visible: controller.visvibleSec.value,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: double.infinity,
                                  color: controller.pMenu == 1
                                      ? Colors.grey.shade700
                                      : null,
                                  child: InkWell(
                                    highlightColor:
                                        Color(controller.color.value)
                                            .withOpacity(0.5),
                                    splashColor: Color(controller.color.value)
                                        .withOpacity(0.5),
                                    onTap: () {
                                      controller.pMenu.value = 1;
                                      Navigator.of(context).pop();
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(right: 30, top: 10),
                                      child: Text(
                                        "• عن الكتاب",
                                        style: TextStyle(
                                            color: controller.pMenu == 1
                                                ? Color(controller.color.value)
                                                    .withOpacity(0.5)
                                                : Colors.grey,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: controller.pMenu == 2
                                      ? Colors.grey.shade700
                                      : null,
                                  width: double.infinity,
                                  child: InkWell(
                                    highlightColor:
                                        Color(controller.color.value)
                                            .withOpacity(0.5),
                                    splashColor: Color(controller.color.value)
                                        .withOpacity(0.5),
                                    onTap: () {
                                      controller.pMenu.value = 2;
                                      Navigator.of(context).pop();
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(right: 20, top: 10),
                                      child: Text("• نبذة عن الإمام الترمذي",
                                          style: TextStyle(
                                              color: controller.pMenu == 2
                                                  ? Color(controller
                                                          .color.value)
                                                      .withOpacity(0.5)
                                                  : Colors.grey,
                                              fontSize: 20)),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: controller.pMenu == 3
                                      ? Colors.grey.shade700
                                      : null,
                                  width: double.infinity,
                                  child: InkWell(
                                    highlightColor:
                                        Color(controller.color.value)
                                            .withOpacity(0.5),
                                    splashColor: Color(controller.color.value)
                                        .withOpacity(0.5),
                                    onTap: () {
                                      controller.pMenu.value = 3;
                                      Navigator.of(context).pop();
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(right: 20, top: 10),
                                      child: Text("• ترجمة الإمام الترمذي",
                                          style: TextStyle(
                                              color: controller.pMenu == 3
                                                  ? Color(controller
                                                          .color.value)
                                                      .withOpacity(0.5)
                                                  : Colors.grey,
                                              fontSize: 20)),
                                    ),
                                  ),
                                ),
                              ],
                            ))),
                        Obx(
                          () => InkWell(
                            highlightColor:
                                Color(controller.color.value).withOpacity(0.5),
                            splashColor:
                                Color(controller.color.value).withOpacity(0.5),
                            onTap: () {
                              controller.pMenu.value = 0;
                              Navigator.of(context).pop();
                            },
                            child: ListTile(
                              selected: controller.pMenu.value == 0,
                              selectedTileColor: Colors.grey.shade700,
                              leading: Icon(
                                Icons.my_library_books,
                                color: controller.pMenu == 0
                                    ? Color(controller.color.value)
                                        .withOpacity(0.5)
                                    : Colors.white,
                              ),
                              title: Text(
                                "الابواب",
                                style: TextStyle(
                                    color: controller.pMenu == 0
                                        ? Color(controller.color.value)
                                            .withOpacity(0.5)
                                        : Colors.white,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.grey,
                        ),
                        InkWell(
                          highlightColor:
                              Color(controller.color.value).withOpacity(0.5),
                          splashColor:
                              Color(controller.color.value).withOpacity(0.5),
                          onTap: () {
                            Get.to(SearchPage());
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            title: Text(
                              "البحث",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        InkWell(
                          highlightColor:
                              Color(controller.color.value).withOpacity(0.5),
                          splashColor:
                              Color(controller.color.value).withOpacity(0.5),
                          onTap: () {
                            Get.to(Favorite());
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.favorite,
                              color: Colors.white,
                            ),
                            title: Text(
                              "المفضلة",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        InkWell(
                          highlightColor:
                              Color(controller.color.value).withOpacity(0.5),
                          splashColor:
                              Color(controller.color.value).withOpacity(0.5),
                          onTap: () {
                            controller.goRsumR();
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.bookmark,
                              color: Colors.white,
                            ),
                            title: Text(
                              "استكمال القراءة",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.grey,
                        ),
                        InkWell(
                          highlightColor:
                              Color(controller.color.value).withOpacity(0.5),
                          splashColor:
                              Color(controller.color.value).withOpacity(0.5),
                          onTap: () {
                            Get.to(Settings());
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.settings,
                              color: Colors.grey,
                            ),
                            title: Text(
                              "الاعدادات",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20),
                            ),
                          ),
                        ),
                        InkWell(
                          highlightColor:
                              Color(controller.color.value).withOpacity(0.5),
                          splashColor:
                              Color(controller.color.value).withOpacity(0.5),
                          onTap: () {
                            Get.to(AboutApp());
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.info,
                              color: Colors.grey,
                            ),
                            title: Text(
                              "عن التطبيق",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20),
                            ),
                          ),
                        ),
                        InkWell(
                          highlightColor:
                              Color(controller.color.value).withOpacity(0.5),
                          splashColor:
                              Color(controller.color.value).withOpacity(0.5),
                          onTap: () {
                            SystemChannels.platform
                                .invokeMethod('SystemNavigator.pop');
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.exit_to_app,
                              color: Colors.grey,
                            ),
                            title: Text(
                              "خروج",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                body: Obx(() => controller.titles.length > 0
                    ? controller.titles[0]["title"] != null
                        ? Padding(
                            padding: EdgeInsets.all(15),
                            child: controller.pMenu == 0
                                ? ListView.separated(
                                    itemBuilder: (context, index) => InkWell(
                                          onTap: () {
                                            Get.to(SecondPage(
                                                controller.titles.value[index]
                                                    ["id"],
                                                controller.titles.value[index]
                                                    ["title"],
                                                0));
                                          },
                                          splashColor:
                                              Color(controller.color.value)
                                                  .withOpacity(0.5),
                                          highlightColor:
                                              Color(controller.color.value)
                                                  .withOpacity(0.5),
                                          child: Text(
                                            controller.titles.value[index]
                                                        ["title"] ==
                                                    null
                                                ? ""
                                                : controller.titles.value[index]
                                                    ["title"],
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                          thickness: 1,
                                        ),
                                    itemCount: controller.titles.length)
                                : controller.pMenu == 1
                                    ? Card(
                                        margin: EdgeInsets.all(10),
                                        elevation: 10,
                                        child: SingleChildScrollView(
                                          child: Html(
                                            data: "<h5><a href="
                                                ">عن الكتاب</a></h5> هذا الكتاب يعد مصدرًا مهمًّا من المصادر الكثيرة التي احتفظت لنا بشمائل النبي صلى الله عليه وسلم، وقد قسَّم المصنف الكتاب إلى (56) بابًا، وجعل لكل باب عنوانًا يتضمن إشارة مختصرة إلى ما تشتمل عليه أحاديث الباب، وقد عقَّب على بعض النصوص التي أوردها بالشرح والبيان والإيضاح تارة، وبالكلام على الأسانيد تارة أخرى؛ تصحيحًا وتضعيفًا، وترجيحًا لوجه على وجه، أو بيانًا لاسم راو ورد في السند مبهمًا ونحو ذلك، وتارة ثالثة يجمع بين الشرح والكلام على الأسانيد، وقد اشتمل الكتاب على (415) نصًّا مسندًا، وهي تتنوع بين أحاديث مرفوعة قولية وفعلية، وآثار موقوفة على الصحابة والتابعين.",
                                            style: {
                                              "body": Style(
                                                  fontSize: FontSize(20),
                                                  alignment: Alignment.center,
                                                  textAlign: TextAlign.center),
                                              "h5":
                                                  Style(fontSize: FontSize(25))
                                            },
                                          ),
                                        ),
                                      )
                                    : controller.pMenu == 2
                                        ? Card(
                                            margin: EdgeInsets.all(10),
                                            elevation: 10,
                                            child: SingleChildScrollView(
                                              child: Html(
                                                data:
                                                    "<h5><a href=>نبذة مختصرة عن الإمام الترمذي</a></h5> محمد بن عيسى بن سورة بن موسى السلمي البوغي الترمذي، أبو عيسى من أئمة علماء الحديث وحفاظه، من أهل ترمذ (على نهر جيحون) ولد سنة (209هـ) تتلمذ للبخاري، وشاركه في بعض شيوخه. وقام برحلة إلى خراسان والعراق والحجاز، وعمي في آخر عمره. وكان يضرب به المثل في الحفظ. مات بترمذ سنة (279هـ).",
                                                style: {
                                                  "body": Style(
                                                      fontSize: FontSize(20),
                                                      fontFamily: controller
                                                          .verticalGroupValue
                                                          .value,
                                                      alignment:
                                                          Alignment.center,
                                                      textAlign:
                                                          TextAlign.center),
                                                  "h5": Style(
                                                      fontSize: FontSize(25))
                                                },
                                              ),
                                            ),
                                          )
                                        : Card(
                                            margin: EdgeInsets.all(10),
                                            elevation: 10,
                                            child: SingleChildScrollView(
                                              child: Html(
                                                data:
                                                    "<h4><a href=>اسمه ونسبه ومولده:</a></h4> هو الإمام الحافظ، العلم، الإمام، البارع أبو عيسى محمد بن عيسى بن سَوْرة بن موسى السُّلمي الترمذي<br> <br> والترمذي: نسبة إلى تِرْمِذ • بكسر التاء • مدينة مشهورة.<br> <br> ولد رحمه الله سنة 209 هـ.<br> <h4><a href=>طلبه للعلم وشيوخه وتلامذته:</a></h4> بدأ رحمه الله طلب العلم في سن مبكرة؛ فمن أقدم شيوخه: أبو جعفر محمد بن جعفر السِّمناني (توفي قبل220هـ) فيكون عمر الترمذي آنذاك أقل من عشر سنين، ثم إنه بعد أن تلقى العلم عن أهل بلده رحل وطوّف في البلاد؛ قال الذهبي في السير: ارتحل فسمع بخراسان والعراق والحرمين، ولم يرحل إلى مصر والشام<br> <br> ويرجح الدكتور أكرم ضياء العمري في بحثه تراث الترمذي العلمي أن الترمذي دخل بغداد ولكن كان ذلك بعد وفاة الإمام أحمد بن حنبل - إذ إن الترمذي لم يسمع من الإمام أحمد<br> <br> <a href=>ومن أشهر الشيوخ الذين تلقى الترمذي عنهم وسمع الحديث منهم:</a> <br> • قتيبة بن سعيد الثقفي البغلاني (ت240هـ) وهو أحد شيوخ أصحاب الكتب الستة.<br> • علي بن حُجر المروزي (ت244هـ)<br> • محمد بن إسماعيل البخاري (ت256هـ) وهو من أهم شيوخه.<br> • محمد بن بشار البصري الملقب بندار (252هـ)<br> • محمد بن المثنى البصري العنزي الملقب بـ (الزمِن) (ت252هـ)<br> • أحمد بن منيع البغوي الحافظ (ت244هـ)<br> • محمود بن غيلان المروزي (239هـ)<br> • عبد الله بن عبد الرحمن الدارمي الحافظ (255هـ)<br> • إسحاق بن راهويه (238هـ)<br> <br> <a href=>وقد تلقى العلم عن الإمام الترمذي خلق كثير، من أشهرهم:</a> <br> • أبو العباس محمد بن أحمد المحبوبي المروزي.<br> • أبو سعيد الهيثم بن كُليب الشاشي.<br> • أبو ذر محمد بن إبراهيم الترمذي.<br> • أبو محمد الحسن بن إبراهيم القطان.<br> • أبو حامد أحمد بن عبد الله المروزي التاجر.<br> <h4><a href=>منزلته عند العلماء:</a></h4> قال الترمذي قال لي محمد بن إسماعيل : ما انتفعت بك أكثر مما انتفعت بي.<br> <br> قال المزي: أحد الأئمة الحفاظ المبرزين، ومن نفع الله به المسلمين.<br> <br> وقال الذهبي في السير: الحافظ العلم الإمام البارع، وقال أيضا: جامعه قاضٍ له بإمامته وحفظه وفقهه.<br> <br> وقال ابن كثير: هو أحد أئمة هذا الشأن في زمانه وله المصنفات المشهورة..<br> <br> وأما عن وصف ابن حزم له بأنه مجهول، فقد رد الأئمة عليه وخطؤوه في ذلك، قال الذهبي في ميزان الاعتدال: ثقة مُجمعٌ عليه، ولا التفات إلى قول أبي محمد بن حزم فيه ..فإنه ما عرفه ولا درى بوجود الجامع، ولا العلل اللذَين له. <br> <br> وذكر في السير في ترجمة ابن حزم أن جامع الترمذي وسنن ابن ماجه لم يدخلا الأندلس إلا بعد موته.<br> <br> وكذا ردّ عليه ابن كثير في البداية والنهاية، وكذا ردّ عليه ابن حجر.<br> <h4><a href=>صفاته:</a></h4> -كان عالماً عاملاً ورعاً زاهداً، قال الحافظ عمر بن أحمد بن علَّك المروزي: مات البخاري فلم يخلف بخراسان مثل أبي عيسى في العلم والزهد؛ بكى حتى عمِيَ.<br> <br> • وكان من أبرز صفاته التي عُرف بها: قوة الحفظ، فقد كان حافظاً بارعاً.<br> <br> • يُقال: أنه وُلد أعمى والصواب أنه أضرَّ في آخر عمره، ذكره الذهبي وابن كثير.<br> <h4><a href=>بعض مؤلفاته:</a></h4> • الجامع، وهو أشهر مؤلفاته.<br> <br> • العلل الصغير، وقد اختلف فيه هل هو من كتب الجامع أو هو كتاب مستقل، والأشهر أنه من الجامع، وأنه كتبه كالخاتمة لكتاب الجامع.<br> <br> • كتاب العلل الكبير<br> <br> • الشمائل المحمدية.<br> <br> • تسمية أصحاب رسول الله صلى الله عليه وسلم.<br> <br> • كتاب الزهد.<br> <br> • كتاب الأسماء والكنى.<br> <br> • كتاب التفسير.<br> <br> • كتاب التاريخ.<br> <h4><a href=>وفاته:</a></h4> توفي في ترمذ، في 13/ رجب/ 279هـ<br> <h4><a href=>مصادر الترجمة:</a></h4> الثقات لابن حبان، الأنساب للسمعاني، وفيات الأعيان لابن خلكان، سير أعلام النبلاء للذهبي(13/273)، تذكرة الحفاظ للذهبي، تهذيب الكمال للمزي، تهذيب التهذيب (9/389)، البداية والنهاية، مقدمة تحفة الأحوذي، تراث الترمذي العلمي لأكرم ضياء العمري.",
                                                style: {
                                                  "body": Style(
                                                      fontSize: FontSize(20),
                                                      fontFamily: controller
                                                          .verticalGroupValue
                                                          .value,
                                                      alignment:
                                                          Alignment.center,
                                                      textAlign:
                                                          TextAlign.center),
                                                  "h4": Style(
                                                      fontSize: FontSize(25))
                                                },
                                              ),
                                            ),
                                          ))
                        : Center(
                            child: CircularProgressIndicator(),
                          )
                    : Container()),
              ),
            )));
  }
}
