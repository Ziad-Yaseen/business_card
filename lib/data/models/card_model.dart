import 'package:business_card/core/components/card_patterns.dart';

class CardModel {
  final int cardColor;
  final CardPattern pattern;
  final String firstName;
  final String lastName;
  final String? middleName;
  final String? nickName;
  final String jobTitle;
  final String? company;
  final List<String> email;
  final List<String> phone;
  final String linkedIn;
  final String? github;
  final String? portfolio;
  final String? instagram;
  final String? facebook;
  final String? x;
  final String? tiktok;
  final List<String>? more;
  final bool mine;

  const CardModel({
    required this.cardColor,
    required this.pattern,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.linkedIn,
    required this.jobTitle,
    this.middleName,
    this.nickName,
    this.company,
    this.github,
    this.portfolio,
    this.instagram,
    this.facebook,
    this.x,
    this.more,
    this.tiktok,
    this.mine = true,
  });

  Map<String, dynamic> toJson() => {
    'c': cardColor,
    'p': pattern.name,
    'fN': firstName,
    'lN': lastName,
    'mN': middleName,
    'nN': nickName,
    'j': jobTitle,
    'cp': company,
    'e': email,
    'ph': phone,
    'l': linkedIn,
    'g': github,
    'pf': portfolio,
    'i': instagram,
    'f': facebook,
    'x': x,
    't': tiktok,
    'm': more,
    'my': mine,
  };

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
    cardColor: json['c'] as int,
    pattern: CardPattern.values.firstWhere((e) => e.name == json['p']),
    firstName: json['fN'] as String,
    lastName: json['lN'] as String,
    middleName: json['mN'] as String?,
    nickName: json['nN'] as String?,
    jobTitle: json['j'] as String,
    company: json['cp'] as String?,
    email: List<String>.from(json['e'] ?? []),
    phone: List<String>.from(json['ph0'] ?? []),
    linkedIn: json['l'] as String,
    github: json['g'] as String?,
    portfolio: json['pf'] as String?,
    instagram: json['i'] as String?,
    facebook: json['f'] as String?,
    x: json['x'] as String?,
    tiktok: json['t'] as String?,
    more: json['m'] != null ? List<String>.from(json['m']) : null,
    mine: json['my'],
  );
}
