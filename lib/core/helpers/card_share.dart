import 'dart:convert';
import 'dart:io';

import 'package:business_card/core/constants/share_config.dart';
import 'package:business_card/data/models/card_model.dart';

extension CardShare on CardModel {
  String toShareLink() {
    final jsonText = jsonEncode(toShareJson());
    final bytes = gzip.encode(utf8.encode(jsonText));
    final data = base64Url.encode(bytes).replaceAll('=', '');
    return '$shareBaseUrl#$data';
  }
}
