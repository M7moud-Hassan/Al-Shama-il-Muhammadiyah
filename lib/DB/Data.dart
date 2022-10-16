import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Data {
  var db;

  Future<void> inti() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'data_shamail.db');

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data = await rootBundle.load(join("assets", "DB/data_shamail.db"));

      List<int> bytes =
          data.buffer.asInt8List(data.offsetInBytes, data.lengthInBytes);

      await new File(path).writeAsBytes(bytes);
    }
    db = await openDatabase(path);
  }

  Future<List<Map>> getTitles() async {
    return  await db.rawQuery('SELECT * from babs order by id');
  }
  Future<List<Map>> loadDes(id) async {
    return  await db.rawQuery('SELECT * from des where id=$id');
  }

  Future<void> add_bab(id) async {
    await db.rawInsert("INSERT INTO fav_bab('id') VALUES('$id')");
  }
  Future<void> add_hadis(id,index) async {
    await db.rawInsert("INSERT INTO fav_hadis('id','ind') VALUES('$id','$index')");
  }

  deleteFav_bab(id) async{
    await db.delete("fav_bab",where:"id='$id'");
  }
  deleteFav_hadis(id,index) async{
    await db.delete("fav_hadis",where:"id='$id' and ind=$index");
  }

  Future<bool> checkBab(id) async {
    return (await db.rawQuery('SELECT * from fav_bab where id=$id') as List).isNotEmpty;
  }

  Future<List<Map>> getFav_hadis(id) async {
    return  await db.rawQuery('SELECT ind from fav_hadis where id=$id');
  }
  Future<void> add_Note(id,note) async {
    await db.rawInsert("INSERT INTO Note('id','note') VALUES('$id','$note')");
  }
  deleteNote(id) async{
    await db.delete("note",where:"id='$id'");
  }

  updateNote(id,text) async{
    await db.rawUpdate("update note set note='$text' where id='$id'");
  }

  Future<List<Map>> checkNote(id) async {
    return  await db.rawQuery('SELECT * from note where id=$id');
  }

  Future<List<Map>> getAllNotes() async {
    return  await db.rawQuery('SELECT * from note');
  }

  Future<List<Map>> getFavHadisAll()async {
    return  await db.rawQuery('SELECT fav_hadis.id,fav_hadis.ind,des_title from fav_hadis,des where fav_hadis.id=des.id');
  }


  Future<List<Map>> getFavBabAll()async {
    return  await db.rawQuery('select fav_bab.id ,babs.title from fav_bab,babs where babs.id=fav_bab.id;');
  }
  updateResum(id,title) async{
    await db.rawUpdate("update resum set id='$id' ,  title='$title'");
  }
  Future<List<Map>> getRsum()async {
    return  await db.rawQuery('select * from resum');
  }

  Future<List<Map>> getSearch(query)async {
    return  await db.rawQuery('select * from des where des.des_title like "%$query%"');
  }

  Future<List<Map>> getSearchBuNum(query)async {
    return  await db.rawQuery(" SELECT * from des where des_title like '%«$query»%'");
  }
  deleteAllFav()async{
    await db.delete("fav_hadis",where:"id not null");
    await db.delete("fav_bab",where:"id not null");
    await db.delete("Note",where:"id not null");
  }



  /*

  Future<List<Map>> getTitles() async {
    return  await db.rawQuery('SELECT * from babs order by id');
  }
  Future<List<Map>> getItemTitles(id) async {
    return  await db.rawQuery("SELECT * from babs_ttl where id like 'k$id"+"b%'");
  }
  Future<List<Map>> getItemTitle(id) async {
    return  await db.rawQuery("SELECT title from babs_ttl where id ='$id'");
  }

  Future<List<Map>> getSearchByNumber(num)async{
    return  await db.rawQuery("SELECT reda.text_wot,reda.number,babs_ttl.title from reda,babs_ttl where reda.text_wot like '%«$num»%' and babs_ttl.id=reda.number");
  }
  Future<List<Map>> getItems(id) async {
    return  await db.rawQuery("SELECT * from reda where number ='$id'");
  }

  Future<List<Map>> getReda(query)async{
    return  await db.rawQuery("SELECT babs_ttl.title,reda.number,reda.text_wot from reda,babs_ttl where reda.number=babs_ttl.id and reda.text_wot like '%$query%'");
  }

  Future<List<Map>> getResum() async {
    return  await db.rawQuery("SELECT * from resum");
  }



  Future<void> add_bab(id,index) async {
    await db.rawInsert("INSERT INTO fav_bab('id','inde') VALUES('$id','$index')");
  }

  Future<void> add_Had(id,index,inde_bab) async {
    await db.rawInsert("INSERT INTO fav_hadis('id_bab','inde','inde_bab') VALUES('$id','$index','$inde_bab')");
  }


  Future<void> insertNote(id,text,index) async {
    await db.rawInsert("INSERT INTO note('number','note','inde') VALUES('$id','$text','$index')");
  }



  Future<List<Map<String,dynamic>>> getFav_bab() async{
    return await db.rawQuery("select * from fav_bab");
  }

  Future<List<Map>> getFav_hadis() async{
    return await db.rawQuery("select * from fav_hadis");
  }


  Future<List<Map>> getNote(id) async{
    return await db.rawQuery("select * from note where number='$id'");
  }

  deleteFav_bab(id) async{
    await db.delete("fav_bab",where:"id='$id'");
  }
  deleteFav_hadis(id,index) async{
    await db.delete("fav_hadis",where:"id_bab='$id' and inde=$index");
  }

  deleteAllFav() async{
    await db.delete("fav_hadis",where:"id_bab not null");
    await db.delete("fav_bab",where:"id not null");
  }

  deleteNote(id) async{
    await db.delete("note",where:"number='$id'");
  }

 Future<List<Map>> getAllNote()async{
    return await  db.rawQuery("SELECT * from babs_ttl ,note where babs_ttl.id=note.number");
  }

 upda teNote(id,text) async{
    await db.rawUpdate("update note set note='$text' where number='$id'");
  }
  updateResum(id,index) async{
    await db.rawUpdate("update resum set num='$id' and inde='$index'");
  }

  getAllBadbFav()async{
    return await  db.rawQuery("SELECT babs_ttl.id,babs_ttl.title,fav_bab.inde from fav_bab ,babs_ttl where fav_bab.id=babs_ttl.id");
  }
  getAllHadisbFav()async{
    return await  db.rawQuery("select reda.text_wot,reda.number,fav_hadis.inde,fav_hadis.inde_bab from reda,fav_hadis where reda.number=fav_hadis.id_bab");
  }



   */
}
