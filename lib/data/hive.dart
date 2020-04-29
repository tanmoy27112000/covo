import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Box box;

initHive() async {
  Directory appDir = await getApplicationDocumentsDirectory();
  Hive.init(appDir.path);
  box = await Hive.openBox("testbox");
  print("box created");
  try {
    var temp = box.get("totalCases");
    print("total cases=$temp");
    if (temp == null) {
      box.put("totalCases", 0);
      print("total case created");
    }
  } catch (e) {
    box.put("totalCases", 0);
    print("total case created");
  }
}
