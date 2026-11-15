import 'package:business_card/core/components/card_patterns.dart';

class CardModel {
  const CardModel({
    required this.id,
    required this.cardColor,
    required this.pattern,
    required this.firstName,
    required this.lastName,
    required this.jobTitle,
    required this.linkedIn,
    required this.email,
    required this.phone,
    this.middleName,
    this.nickName,
    this.company,
    this.github,
    this.portfolio,
    this.instagram,
    this.facebook,
    this.x,
    this.tiktok,
    this.more,
    this.mine = true,
    this.createdAt,
  });

  final String id;

  final int cardColor;
  final CardPattern pattern;
  final String firstName;
  final String lastName;
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

  final String? middleName;
  final String? nickName;

  final bool mine;
  final int? createdAt;

  String get displayName =>
      [firstName, lastName].where((s) => s.trim().isNotEmpty).join(' ');

  String get fullName => [
    firstName,
    middleName,
    lastName,
  ].where((s) => s != null && s.trim().isNotEmpty).join(' ');

  Map<String, dynamic> toShareJson() =>
      {
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
      }..removeWhere(
        (_, v) =>
            v == null ||
            (v is String && v.trim().isEmpty) ||
            (v is List && v.isEmpty),
      );

  Map<String, dynamic> toJson() => {
    ...toShareJson(),
    'id': id,
    'my': mine,
    if (createdAt != null) 'ct': createdAt,
  };

  factory CardModel.fromJson(
    Map<String, dynamic> json, {
    String? id,
    bool? mine,
    int? createdAt,
  }) {
    List<String> strings(Object? v) =>
        v == null ? const [] : List<String>.from(v as List);

    return CardModel(
      id: id ?? json['id'] as String,
      cardColor: json['c'] as int,
      pattern:
          CardPattern.values.asNameMap()[json['p']] ?? CardPattern.values.first,
      firstName: json['fN'] as String? ?? '',
      lastName: json['lN'] as String? ?? '',
      middleName: json['mN'] as String?,
      nickName: json['nN'] as String?,
      jobTitle: json['j'] as String? ?? '',
      company: json['cp'] as String?,
      email: strings(json['e']),
      phone: strings(json['ph']),
      linkedIn: json['l'] as String? ?? '',
      github: json['g'] as String?,
      portfolio: json['pf'] as String?,
      instagram: json['i'] as String?,
      facebook: json['f'] as String?,
      x: json['x'] as String?,
      tiktok: json['t'] as String?,
      more: json['m'] == null ? null : strings(json['m']),
      mine: mine ?? (json['my'] as bool? ?? true),
      createdAt: createdAt ?? json['ct'] as int?,
    );
  }

  CardModel copyWith({
    int? cardColor,
    CardPattern? pattern,
    String? firstName,
    String? lastName,
    String? middleName,
    String? nickName,
    String? jobTitle,
    String? company,
    List<String>? email,
    List<String>? phone,
    String? linkedIn,
    String? github,
    String? portfolio,
    String? instagram,
    String? facebook,
    String? x,
    String? tiktok,
    List<String>? more,
    int? createdAt,
  }) {
    return CardModel(
      id: id,
      cardColor: cardColor ?? this.cardColor,
      pattern: pattern ?? this.pattern,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      middleName: middleName ?? this.middleName,
      nickName: nickName ?? this.nickName,
      jobTitle: jobTitle ?? this.jobTitle,
      company: company ?? this.company,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      linkedIn: linkedIn ?? this.linkedIn,
      github: github ?? this.github,
      portfolio: portfolio ?? this.portfolio,
      instagram: instagram ?? this.instagram,
      facebook: facebook ?? this.facebook,
      x: x ?? this.x,
      tiktok: tiktok ?? this.tiktok,
      more: more ?? this.more,
      mine: mine,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
