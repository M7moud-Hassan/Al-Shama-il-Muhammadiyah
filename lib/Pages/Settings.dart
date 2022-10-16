import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:get/get.dart';
import 'package:group_radio_button/group_radio_button.dart';
import '../Controller/MyController.dart';
class Settings extends GetView<MyController> {
  const Settings({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child:Obx(
        ()=> Scaffold(
          appBar: AppBar(
            backgroundColor: Color(controller.color.value),
            title: Text("الاعدادت"),
          ),
          body:Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.text_fields),
                        Expanded(
                          child: Column(
                            children: [
                              Text("حجم الخط",style: TextStyle(fontSize: 25),),
                              Text("تغير حجم خط الاحادبث والنصوص",style: TextStyle(fontSize: 15),),
                            Obx(() =>   Row(
                              children: [
                                Expanded(child: Slider(
                                  activeColor: Color(controller.color.value),
                                    max: 40,
                                    min: 10,
                                    value:controller.fontSize.toDouble() , onChanged: (value){
                                  controller.fontSize.value=value.toDouble();
                                  controller.sharedPreferences!.setDouble("fontSize", value.toDouble());
                                  // controller.changeFont(value);
                                }),),
                                Text("${controller.fontSize.value.toInt()}",textAlign: TextAlign.right,),
                              ],
                            ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 0,thickness: 2,),
                  InkWell(
                    onTap: (){

                      showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: Text('اختر لون التطبيق'),
                              content: SingleChildScrollView(
                                child:  MaterialColorPicker(
                                  onColorChange: (Color color) {
                                    controller.color.value=color.value;
                                    controller.sharedPreferences!.setInt("color", color.value);
                                  },
                                 // selectedColor: controller.color,
                                  colors: [
                                    Colors.red,
                                    Colors.blue,
                                    Colors.yellow,
                                    Colors.lightGreen
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: const Text('حفظ'),
                                  onPressed: () {
                                   // controller.changeColor();
                                    Navigator.of(context).pop();
                                    //dismiss the color picker
                                  },
                                ),
                              ],
                            );
                          }
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          Icon(Icons.style),
                          Expanded(
                            child:Column(
                              children: [
                                Text("الثبم",style: TextStyle(fontSize: 25),),
                                Text("تغير لون التطبيق والشريط العلوي",style: TextStyle(fontSize: 15),)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 0,thickness: 2,),
                  InkWell(
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              content: SingleChildScrollView(
                                child:  RadioGroup<String>.builder(
                                  groupValue: controller.verticalGroupValue.value,
                                  onChanged: (value) {
                                    controller.verticalGroupValue.value=value.toString();
                                    controller.sharedPreferences!.setString("font", value.toString());
                                    Navigator.of(context).pop();
                                   // controller.changeFormat(value);
                                  },
                                  items: ["normal","DECOTYPE","DroidKufi","DroidNaskh","GS45","LOTUS","materiald"],
                                  itemBuilder: (item) => RadioButtonBuilder(
                                    item,
                                  ),
                                ),
                              ),
                            );
                          }
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          Icon(Icons.font_download),
                          Expanded(
                            child:Column(
                              children: [
                                Text("نوع الخظ",style: TextStyle(fontSize: 25),),
                                Text("تغير نوع الخط المستخدم في الاحاديث والنصوص",style: TextStyle(fontSize: 15),)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 0,thickness: 2,),

                  InkWell(
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              content: SingleChildScrollView(
                                child:  RadioGroup<String>.builder(
                                  groupValue: controller.colorFont.value,
                                  onChanged: (value) {
                                    Navigator.of(context).pop();
                                    //controller.changeColorFont(value);
                                    controller.colorFont.value=value.toString();
                                    controller.sharedPreferences!.setString("colorFont", value.toString());
                                    },
                                  items: ["اسود","رماضي"],
                                  itemBuilder: (item) => RadioButtonBuilder(
                                    item,
                                  ),
                                ),
                              ),
                            );
                          }
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          Icon(Icons.font_download_outlined),
                          Expanded(
                            child:Column(
                              children: [
                                Text("لون الخط",style: TextStyle(fontSize: 25),),
                                Text("تغير لون الخط الاساسي (اسود / رماضي)",style: TextStyle(fontSize: 15),)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 0,thickness: 2,),
                  InkWell(
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              content: SingleChildScrollView(
                                child:  RadioGroup<String>.builder(
                                  groupValue: controller.showBtns.value,
                                  onChanged: (value) {
                                    Navigator.of(context).pop();
                                    //controller.changeColorFont(value);
                                    controller.showBtns.value=value.toString();
                                    controller.sharedPreferences!.setString("showBtns", value.toString());
                                  },
                                  items: ["اظهار دائما","اظهار / واخفاء","اخفاء دائما"],
                                  itemBuilder: (item) => RadioButtonBuilder(
                                    item,
                                  ),
                                ),
                              ),
                            );
                          }
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          Icon(Icons.font_download_outlined),
                          Expanded(
                            child:Column(
                              children: [
                                Text("زراير التنقل",style: TextStyle(fontSize: 25),),
                                Text("اخفاء / اظهار زراير التنقل ",style: TextStyle(fontSize: 15),)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 0,thickness: 2,),


                  InkWell(
                    onTap: (){
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        headerAnimationLoop: false,
                        animType: AnimType.bottomSlide,
                        title: 'مسح جميع الاعدادت ؟',
                        desc: 'سيتم ايضا مسح والمفضلة ',
                        buttonsTextStyle: const TextStyle(color: Colors.black),
                        showCloseIcon: true,
                        btnOkText: "نعم",
                        btnCancelText: "لا",
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {

                          //delete favorite
                          controller.deleteAllFav();
                           controller.setDefault();
                          controller.sharedPreferences!.clear();
                        },
                      ).show();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          Icon(Icons.delete_forever_sharp),
                          Expanded(
                            child:Column(
                              children: [
                                Text("اعدادات التطبيق لوضعه الاساسي ",style: TextStyle(fontSize: 20),),
                                Text("مسح جميع الاعدادت وكذالك مسح المفضلة",style: TextStyle(fontSize: 15),)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 0,thickness: 2,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
