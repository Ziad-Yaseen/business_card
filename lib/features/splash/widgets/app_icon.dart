import 'package:material_ui/material_ui.dart';
import 'package:google_fonts/google_fonts.dart';

class AppIconWidget extends StatelessWidget {
  const AppIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'card',
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontWeight: .w800,
            fontSize: 64,
            letterSpacing: -1.6,
          ),
        ),
        Text(
          '.',
          style: GoogleFonts.plusJakartaSans(
            color: const Color(0xFF1A1F26),
            fontSize: 64,
            fontWeight: .w800,
            letterSpacing: -1.6,
          ),
        ),
      ],
    );
  }
}
