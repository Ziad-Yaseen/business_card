import 'package:business_card/core/components/card_patterns.dart';
import 'package:business_card/data/models/card_model.dart';
import 'package:business_card/features/create_card/cubit/profile_cubit.dart';

enum CreateStatus { editing, invalid, saving, saved, failure }

class CreateCardState {
  const CreateCardState({
    required this.id,
    this.colorIndex = 0,
    this.pattern = CardPattern.rings,
    this.firstName = '',
    this.lastName = '',
    this.middleName = '',
    this.nickName = '',
    this.jobTitle = '',
    this.company = '',
    this.emails = const [],
    this.phones = const [],
    this.linkedIn = '',
    this.github = '',
    this.portfolio = '',
    this.profiles = const {},
    this.more = const [],
    this.status = CreateStatus.editing,
  });

  factory CreateCardState.fromCard(CardModel c) {
    final profiles = <ProfileType, String>{
      if ((c.instagram ?? '').trim().isNotEmpty)
        ProfileType.instagram: c.instagram!,
      if ((c.facebook ?? '').trim().isNotEmpty)
        ProfileType.facebook: c.facebook!,
      if ((c.tiktok ?? '').trim().isNotEmpty) ProfileType.tiktok: c.tiktok!,
      if ((c.x ?? '').trim().isNotEmpty) ProfileType.x: c.x!,
    };

    return CreateCardState(
      id: c.id,
      colorIndex: c.cardColor,
      pattern: c.pattern,
      firstName: c.firstName,
      lastName: c.lastName,
      middleName: c.middleName ?? '',
      nickName: c.nickName ?? '',
      jobTitle: c.jobTitle,
      company: c.company ?? '',
      emails: c.email,
      phones: c.phone,
      linkedIn: c.linkedIn,
      github: c.github ?? '',
      portfolio: c.portfolio ?? '',
      profiles: profiles,
      more: c.more ?? const [],
    );
  }

  final String id;
  final int colorIndex;
  final CardPattern pattern;
  final String firstName;
  final String lastName;
  final String middleName;
  final String nickName;
  final String jobTitle;
  final String company;
  final List<String> emails;
  final List<String> phones;
  final String linkedIn;
  final String github;
  final String portfolio;
  final Map<ProfileType, String> profiles;
  final List<String> more;
  final CreateStatus status;

  bool get isValid =>
      firstName.trim().isNotEmpty &&
      lastName.trim().isNotEmpty &&
      jobTitle.trim().isNotEmpty &&
      linkedIn.trim().isNotEmpty;

  CreateCardState copyWith({
    int? colorIndex,
    CardPattern? pattern,
    String? firstName,
    String? lastName,
    String? middleName,
    String? nickName,
    String? jobTitle,
    String? company,
    List<String>? emails,
    List<String>? phones,
    String? linkedIn,
    String? github,
    String? portfolio,
    Map<ProfileType, String>? profiles,
    List<String>? more,
    CreateStatus status = CreateStatus.editing,
  }) {
    return CreateCardState(
      id: id,
      colorIndex: colorIndex ?? this.colorIndex,
      pattern: pattern ?? this.pattern,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      middleName: middleName ?? this.middleName,
      nickName: nickName ?? this.nickName,
      jobTitle: jobTitle ?? this.jobTitle,
      company: company ?? this.company,
      emails: emails ?? this.emails,
      phones: phones ?? this.phones,
      linkedIn: linkedIn ?? this.linkedIn,
      github: github ?? this.github,
      portfolio: portfolio ?? this.portfolio,
      profiles: profiles ?? this.profiles,
      more: more ?? this.more,
      status: status,
    );
  }

  CardModel toCard() {
    return CardModel(
      id: id,
      cardColor: colorIndex,
      pattern: pattern,
      firstName: firstName.trim(),
      lastName: lastName.trim(),
      middleName: middleName.trim(),
      nickName: nickName.trim(),
      jobTitle: jobTitle.trim(),
      company: company.trim(),
      email: emails,
      phone: phones,
      linkedIn: linkedIn.trim(),
      github: github.trim(),
      portfolio: portfolio.trim(),
      instagram: profiles[ProfileType.instagram],
      facebook: profiles[ProfileType.facebook],
      tiktok: profiles[ProfileType.tiktok],
      x: profiles[ProfileType.x],
      more: more,
    );
  }
}