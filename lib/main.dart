import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'showphotos.dart';
import 'signin_page.dart';

final _mybox=Hive.box('signin_user');

void main() async{
  await Hive.initFlutter();
  await Hive.openBox('signin_user');

  runApp(_mybox.get('signin_user')==null?signinpage():showphoto_scaffold());
}

