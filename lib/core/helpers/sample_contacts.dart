import 'package:business_card/core/components/card_patterns.dart';
import 'package:business_card/data/models/card_model.dart';

List<CardModel> getInitialSampleContacts() {
  final now = DateTime.now().millisecondsSinceEpoch;
  const day = 24 * 60 * 60 * 1000;

  return [
    CardModel(
      id: 'sample_sara_ahmed',
      cardColor: 1, // Ocean blue
      pattern: CardPattern.rings,
      firstName: 'Sara',
      lastName: 'Ahmed',
      jobTitle: 'Product Designer',
      company: 'Studio Craft',
      email: const ['sara.ahmed@example.com'],
      phone: const ['+20 100 123 4567'],
      linkedIn: 'sara-ahmed',
      portfolio: 'https://behance.net/saraahmed',
      mine: false,
      createdAt: now, // Today
    ),
    CardModel(
      id: 'sample_omar_khaled',
      cardColor: 2, // Forest green
      pattern: CardPattern.stripes,
      firstName: 'Omar',
      lastName: 'Khaled',
      jobTitle: 'Backend Engineer',
      company: 'Tech Solutions',
      email: const ['omar.khaled@example.com'],
      phone: const ['+20 111 234 5678'],
      linkedIn: 'omar-khaled',
      github: 'https://github.com/omarkhaled',
      mine: false,
      createdAt: now - (2 * day), // 2d ago
    ),
    CardModel(
      id: 'sample_mariam_hassan',
      cardColor: 0, // Persimmon / terracotta
      pattern: CardPattern.none,
      firstName: 'Mariam',
      lastName: 'Hassan',
      jobTitle: 'Data Scientist',
      company: 'AI Dynamics',
      email: const ['mariam.hassan@example.com'],
      phone: const ['+20 122 345 6789'],
      linkedIn: 'mariam-hassan',
      mine: false,
      createdAt: now - (7 * day), // 1w ago
    ),
    CardModel(
      id: 'sample_youssef_adel',
      cardColor: 3, // Plum / purple
      pattern: CardPattern.rings,
      firstName: 'Youssef',
      lastName: 'Adel',
      jobTitle: 'UI Designer',
      company: 'Pixel Studio',
      email: const ['youssef.adel@example.com'],
      phone: const ['+20 106 789 0123'],
      linkedIn: 'youssef-adel',
      portfolio: 'https://dribbble.com/youssefadel',
      mine: false,
      createdAt: now - (14 * day), // 2w ago
    ),
    CardModel(
      id: 'sample_nour_samir',
      cardColor: 5, // Ink / dark
      pattern: CardPattern.stripes,
      firstName: 'Nour',
      lastName: 'Samir',
      jobTitle: 'DevOps Engineer',
      company: 'Cloud Ops',
      email: const ['nour.samir@example.com'],
      phone: const ['+20 115 678 9012'],
      linkedIn: 'nour-samir',
      github: 'https://github.com/noursamir',
      mine: false,
      createdAt: now - (30 * day), // 1mo ago
    ),
  ];
}
