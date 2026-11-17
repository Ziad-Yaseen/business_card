import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class StoragePaths {
  StoragePaths._();

  static const root = '/storage/emulated/0/cards';
  static const myCards = '$root/my cards';
  static const backup = '$root/backup';

  static Future<bool> ensurePermission() async {
    if (!Platform.isAndroid) return false;
    var status = await Permission.manageExternalStorage.request();
    if (status.isGranted) return true;
    status = await Permission.storage.request();
    return status.isGranted;
  }

  static Future<Directory> dir(String path) async {
    final d = Directory(path);
    if (!await d.exists()) await d.create(recursive: true);
    return d;
  }
}
