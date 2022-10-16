import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:untitled/Pages/Favorite.dart';
import 'package:untitled/Pages/SecondPage.dart';
import 'package:untitled/Pages/Settings.dart';

import 'Controller/MyBinding.dart';
import 'Pages/Home.dart';
import 'Pages/Note.dart';
import 'Pages/SearchIn.dart';
import 'Pages/SearchPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/home', page: () => (Home()), binding: MyBinding()),
        GetPage(
            name: '/secondPage',
            page: () => (SecondPage(0, "", 0)),
            binding: MyBinding()),
        GetPage(name: '/note', page: () => (Note()), binding: MyBinding()),
        GetPage(
            name: '/favorite', page: () => (Favorite()), binding: MyBinding()),
        GetPage(
            name: '/Searchpage',
            page: () => (SearchPage()),
            binding: MyBinding()),
        GetPage(
            name: '/SearchIn', page: () => (SearchIn()), binding: MyBinding()),
        GetPage(
            name: '/settings', page: () => (Settings()), binding: MyBinding()),
      ],
      initialRoute: '/home',
      defaultTransition: Transition.native,
      title: 'الشمائل المحمدية',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      )));
}
