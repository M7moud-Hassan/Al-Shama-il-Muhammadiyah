import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Pages/SecondPage.dart';
import '../DB/Data.dart';

class MyController extends GetxController with SingleGetTickerProviderMixin {
  RxBool isDrawerOpen = false.obs;
  RxBool isSearch = false.obs;
  AnimationController? animationController;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  RxBool visvibleSec = false.obs;
  RxInt pMenu = 0.obs;
  Data? db;
  RxList<Map> titles = [{}].obs;
  List<Map> titlesFilter = [];
  List<Map> des = [];
  RxList<String>? dse_bab = <String>[].obs;
  RxBool isFav = false.obs;
  RxInt id = 0.obs;
  RxList<int> indexFav = <int>[].obs;
  List<int> listFav_ha = [];
  List<Map> fav = [];
  RxBool shoFad = true.obs;
  RxInt currentIndex = 0.obs;
  RxString title = "".obs;
  RxList<Map> hasNote = <Map>[].obs;
  RxString lenghtText = "".obs;
  RxList<Map> notes = <Map>[].obs;
  RxList<RxBool> wrap = <RxBool>[].obs;
  RxList<Map> allFav_hadis = <Map>[].obs;
  RxList<Map> allFav_bab = <Map>[].obs;
  RxList<RxBool> show_hadis = <RxBool>[].obs;
  List<AnimationController> animations = [];
  List<Animation<double>> TrotationAnimations = [];
  RxString dropdownValue = "نص الكتاب".obs;
  List<String> spinnerItems = ["نص الكتاب", "رقم حديث"];
  RxList<Map> searches = <Map>[].obs;
  RxList<int> bab_counts = <int>[].obs;
  List<String> splits = [];
  RxString textSearch = "".obs;
  List<Map> searchByNum = [];
  RxList<String> OkSearchByNum = <String>[].obs;
  RxInt curentHight = 0.obs;
  RxInt inexdTextHight = 0.obs;
  RxInt m7moud = 1.obs;
  RxList<int> position = <int>[].obs;
  List<int> counIntpoSition = [];
  int p = 0;
  int m = 0;
  int countT = 0;
  ItemScrollController scrollController2 = ItemScrollController();
  int indexH = 0;
  SharedPreferences? sharedPreferences;
  RxDouble fontSize = 20.0.obs;
  RxInt color = 0xfff57f17.obs;
  RxString verticalGroupValue = "normal".obs;
  RxString colorFont = "اسود".obs;
  RxString showBtns = "اظهار / واخفاء".obs;

  setDefault() {
    fontSize.value = 20.0;
    color.value = 0xfff57f17;
    verticalGroupValue.value = "normal";
    colorFont.value = "اسود";
    showBtns.value = "اظهار / واخفاء";
    // loadSettings();
  }

  deleteAllFav() async {
    await db!.deleteAllFav();
  }

  loadSettings() async {
    fontSize.value = sharedPreferences!.containsKey("fontSize")
        ? sharedPreferences!.getDouble("fontSize")!
        : fontSize.value;
    color.value = sharedPreferences!.containsKey("color")
        ? sharedPreferences!.getInt("color")!
        : color.value;
    verticalGroupValue.value = sharedPreferences!.containsKey("font")
        ? sharedPreferences!.getString("font")!
        : verticalGroupValue.value;
    colorFont.value = sharedPreferences!.containsKey("colorFont")
        ? sharedPreferences!.getString("colorFont")!
        : colorFont.value;
    showBtns.value = sharedPreferences!.containsKey("showBtns")
        ? sharedPreferences!.getString("showBtns")!
        : showBtns.value;
  }

  SearchByNum(query) async {
    OkSearchByNum.value = [];
    List<String> querys = [];
    indexH = 0;
    searchByNum = await db!.getSearchBuNum(query);
    if (searchByNum.length > 0) {
      querys.add(searchByNum[0]["des_title"].toString().split(":")[0]);
      searchByNum[0]["des_title"]
          .toString()
          .replaceAll("&lt;", "<")
          .split("<FONT COLOR=red>")
          .forEach((element) {
        if (element.contains("«")) if (int.parse(element.substring(
                element.indexOf("«") + 1, element.indexOf("»"))) ==
            int.parse(query)) {
          querys.add("<FONT COLOR=red>$element");
          querys.add(indexH.toString());
        }
        indexH++;
      });
      querys.add(searchByNum[0]["id"].toString());
    }
    OkSearchByNum.value = querys;
  }

  changeHightPlus() async {
    if (inexdTextHight.value < position.length - 1) {
      m7moud++;
      curentHight++;
      if (curentHight.value >= counIntpoSition[inexdTextHight.value]) {
        inexdTextHight++;
        await scrollTo2(position.value[inexdTextHight.value]);
        curentHight.value = 0;
      }
    }
    update();
  }

  changeHightMins() async {
    if (m7moud.value > 1) m7moud--;
    if (inexdTextHight.value > -1) {
      if (curentHight.value == 0 && inexdTextHight.value != 0) {
        inexdTextHight--;
        await scrollTo2(position.value[inexdTextHight.value]);
        curentHight.value = counIntpoSition[inexdTextHight.value] - 1;
      } else {
        curentHight--;
        if (curentHight.value == -1 && inexdTextHight.value != 0) {
          inexdTextHight--;
          await scrollTo2(position.value[inexdTextHight.value]);
          curentHight.value = counIntpoSition[inexdTextHight.value];
        }
      }
      if (inexdTextHight.value == 0 && curentHight.value == -1)
        curentHight.value = 0;
    }
    update();
  }

  scrollTo2(index) async {
    //await Future.delayed(Duration(milliseconds: 100));
    await scrollController2.scrollTo(
        index: index, duration: Duration(microseconds: 1));
  }

  searchIn(splits, query) {
    List<int> positionss = [];
    curentHight = 0.obs;
    inexdTextHight = 0.obs;
    m7moud = 1.obs;
    counIntpoSition = [];
    p = 0;
    splits.forEach((element) {
      if (element.contains(query)) {
        positionss.add(p);
        m = 0;
        countT = 0;
        while (m != -1) {
          m = element.indexOf(query, m + 1);
          if (m != -1) countT++;
        }
        counIntpoSition.add(countT);
      }
      p++;
    });
    position = positionss.obs;
    print(positionss);
    // update();
  }

  Search(query) async {
    List<int> listNum = [];
    searches.value = await db!.getSearch(query);
    searches.value.forEach((element) {
      splits = element["des_title"].toString().split("<FONT COLOR=blue>");
      splits.forEach((element) {
        int m = 0;
        int count = 0;
        while (m != -1) {
          m = element.indexOf(query, m + 1);
          count++;
        }
        listNum.add(count);
      });
    });
    bab_counts.value = listNum;
  }

  clearSearch() {
    OkSearchByNum = <String>[].obs;
    searches.value = [];
    bab_counts.value = [];
  }

  goRsum() async {
    List r = await db!.getRsum();
    Get.off(SecondPage(r[0]["id"], r[0]["title"], 0));
  }

  goRsumR() async {
    List r = await db!.getRsum();
    Get.to(SecondPage(r[0]["id"], r[0]["title"], 0));
  }

  getAllFavBab() async {
    allFav_bab.value = await db!.getFavBabAll();
  }

  getAllFavHadis() async {
    allFav_hadis.value = await db!.getFavHadisAll();
    animations = List.generate(
        allFav_hadis.length,
        (index) => AnimationController(
              duration: const Duration(milliseconds: 300),
              vsync: this,
            ));
    TrotationAnimations = List.generate(
        allFav_hadis.length,
        (index) =>
            Tween<double>(begin: 0, end: 0.5).animate(animations[index]));
    show_hadis.value =
        List<RxBool>.generate(allFav_hadis.length, (index) => false.obs);
  }

  ShowHadis(index) {
    show_hadis.value[index].value = !show_hadis.value[index].value;
    show_hadis.value[index].value
        ? animations[index].forward()
        : animations[index].reverse();
  }

  wrapChange(index) {
    wrap.value[index].value = !wrap.value[index].value;
  }

  getAllNote() async {
    notes.value = await db!.getAllNotes();
    wrap.value =
        List<RxBool>.generate(notes.value.length, (index) => false.obs);
  }

  //here goes the function
  String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  Future<void> share(title, text, String s) async {
    await FlutterShare.share(
        title: title,
        text: parseHtmlString(text),
        linkUrl: s,
        chooserTitle: 'Example Chooser Title');
  }

  void loadDes(id) async {
    this.id.value = id;
    loadFav_hadis(id);
    des = await db!.loadDes(id);
    dse_bab!.value = des[0]["des_title"]
        .toString()
        .replaceAll("&lt;", "<")
        .replaceAll("«", "[")
        .replaceAll("»", "]")
        .split("<FONT COLOR=red>");
    isFav.value = await db!.checkBab(id);
    hasNote.value = await db!.checkNote(id);
    title.value = dse_bab!.first;
    db!.updateResum(id, title);
  }

  deleteNote(index) async {
    await db!.deleteNote(notes[index]["id"]);
    getAllNote();
  }

  checknote() async {
    hasNote.value = await db!.checkNote(id);
  }

  addnote(id, note) async {
    if (hasNote.isNotEmpty)
      await db!.updateNote(id, note);
    else
      await db!.add_Note(id, note);
    hasNote.value = await db!.checkNote(id);
  }

  removeNote(id) async {
    await db!.deleteNote(id);
    hasNote.value = await db!.checkNote(id);
  }

  fav_bab(id) async {
    if (isFav.value)
      db!.deleteFav_bab(id);
    else
      db!.add_bab(id);
    isFav.value = !isFav.value;
    getAllFavHadis();
    getAllFavBab();
  }

  loadFav_hadis(id) async {
    listFav_ha = [];
    fav = await db!.getFav_hadis(id);
    fav.forEach((element) {
      listFav_ha.add(element["ind"]);
    });
    indexFav.value = listFav_ha;
  }

  fav_hadis(id, index) {
    if (indexFav.value.contains(index))
      db!.deleteFav_hadis(id, index);
    else
      db!.add_hadis(id, index);
    loadFav_hadis(id);
    getAllFavHadis();
    getAllFavBab();
  }

  late final AnimationController Tcontroller;
  late final Animation<double> TrotationAnimation;
  void Filter(query) {
    List<Map> titlesF = [];
    titlesFilter.forEach((element) {
      if (element["title"].toString().contains(query)) titlesF.add(element);
    });
    titles.value = titlesF;
  }

  void AnimateIcon() {
    if (isSearch.isTrue) {
      if (titles.length != titlesFilter.length) titles.value = titlesFilter;
      isSearch.value = false;
      animationController!.reverse();
    } else {
      isDrawerOpen.value = !isDrawerOpen.value;
      /* isDrawerOpen.isTrue
          ? animationController!.forward()
          : animationController!.reverse();*/
      if (isDrawerOpen.isTrue) {
        animationController!.forward();
        scaffoldKey.currentState!.openDrawer();
      } else {
        animationController!.reverse();
        scaffoldKey.currentState!.closeDrawer();
      }
    }
  }

  openSerach() {
    isSearch.value = !isSearch.value;
    isSearch.isTrue ? animationController!.forward() : null;
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    Tcontroller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // The icon is animated from 0 degrees to a
    // half turn = 180 degrees
    TrotationAnimation = Tween<double>(begin: 0, end: 0.5).animate(Tcontroller);
    db = Data();
    await db!.inti();
    titles.value = await db!.getTitles();
    titlesFilter = titles.value;
    sharedPreferences = await SharedPreferences.getInstance();
    loadSettings();
  }
}
