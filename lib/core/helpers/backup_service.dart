import 'dart:convert';
import 'dart:io';

import 'package:business_card/core/repositories/card_repositories.dart';
import 'package:business_card/data/models/card_model.dart';
import 'package:business_card/data/models/saved_contact.dart';
import 'package:permission_handler/permission_handler.dart';

enum BackupStatus { ok, noPermission, notFound, invalid, failed }

class BackupResult {
  const BackupResult(this.status, [this.count = 0]);

  final BackupStatus status;

  final int count;
}

class BackupService {
  BackupService(this._repository);

  final CardsRepository _repository;

  static const fileName = 'card_backup.json';
  static final File _file = File('/storage/emulated/0/Download/$fileName');

  Future<bool> _ensurePermission() async {
    if (!Platform.isAndroid) return false;
    var status = await Permission.manageExternalStorage.request();
    if (status.isGranted) return true;
    status = await Permission.storage.request();
    return status.isGranted;
  }

  Future<BackupResult> backup() async {
    if (!await _ensurePermission()) {
      return const BackupResult(BackupStatus.noPermission);
    }
    try {
      final items = await _repository.getAllForBackup();
      final data = {
        'app': 'card',
        'version': 1,
        'createdAt': DateTime.now().toIso8601String(),
        'cards': [
          for (final i in items)
            {...i.card.toJson(), 'savedAt': i.savedAt.millisecondsSinceEpoch},
        ],
      };
      if (await _file.exists()) await _file.delete();
      await _file.writeAsString(jsonEncode(data), flush: true);
      return BackupResult(BackupStatus.ok, items.length);
    } catch (_) {
      return const BackupResult(BackupStatus.failed);
    }
  }

  Future<BackupResult> restore() async {
    if (!await _ensurePermission()) {
      return const BackupResult(BackupStatus.noPermission);
    }
    try {
      if (!await _file.exists()) {
        return const BackupResult(BackupStatus.notFound);
      }

      final raw = jsonDecode(await _file.readAsString());
      if (raw is! Map || raw['app'] != 'card' || raw['cards'] is! List) {
        return const BackupResult(BackupStatus.invalid);
      }

      final list = raw['cards'] as List;
      final items = <SavedContact>[];
      for (final e in list) {
        try {
          final map = Map<String, dynamic>.from(e as Map);
          final card = CardModel.fromJson(map);
          final millis =
              map['savedAt'] as int? ?? DateTime.now().millisecondsSinceEpoch;
          items.add(
            SavedContact(
              card: card,
              savedAt: DateTime.fromMillisecondsSinceEpoch(millis),
            ),
          );
        } catch (_) {}
      }
      if (items.isEmpty && list.isNotEmpty) {
        return const BackupResult(BackupStatus.invalid);
      }

      await _repository.restoreAll(items);
      return BackupResult(BackupStatus.ok, items.length);
    } on FormatException {
      return const BackupResult(BackupStatus.invalid);
    } catch (_) {
      return const BackupResult(BackupStatus.failed);
    }
  }
}
