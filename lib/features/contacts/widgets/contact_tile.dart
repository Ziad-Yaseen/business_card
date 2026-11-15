import 'package:business_card/core/constants/app_colors.dart';
import 'package:business_card/data/models/card_model.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactTile extends StatelessWidget {
  const ContactTile({
    super.key,
    required this.contact,
    required this.index,
    required this.onTap,
  });

  final CardModel contact;
  final int index;
  final VoidCallback onTap;

  static const List<Color> _palette = [
    Color(0xFF2454DB), // Blue (like Sara Ahmed)
    Color(0xFF1E7A55), // Forest Green (like Omar Khaled)
    Color(0xFFC3381B), // Rust Red (like Mariam Hassan)
    Color(0xFF6B38C2), // Purple (like Youssef Adel)
    Color(0xFF1F242B), // Charcoal / Black (like Nour Samir)
  ];

  Color _getAvatarColor() {
    if (contact.cardColor >= 0 && contact.cardColor < AppAccent.presets.length) {
      return AppAccent.presets[contact.cardColor].light;
    }
    return _palette[index % _palette.length];
  }

  String _getInitials() {
    final f = contact.firstName.trim();
    final l = contact.lastName.trim();
    if (f.isNotEmpty && l.isNotEmpty) {
      return '${f[0]}${l[0]}'.toUpperCase();
    } else if (f.isNotEmpty) {
      return f.length > 1 ? f.substring(0, 2).toUpperCase() : f.toUpperCase();
    } else if (l.isNotEmpty) {
      return l.length > 1 ? l.substring(0, 2).toUpperCase() : l.toUpperCase();
    }
    return '?';
  }

  String _formatTimeAgo(int? timestamp) {
    if (timestamp == null) return 'Today';
    final now = DateTime.now();
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final diff = now.difference(date);

    if (diff.inDays <= 0) {
      return 'Today';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}d';
    } else if (diff.inDays < 30) {
      final weeks = (diff.inDays / 7).floor();
      return '${weeks}w';
    } else if (diff.inDays < 365) {
      final months = (diff.inDays / 30).floor();
      return '${months}mo';
    } else {
      final years = (diff.inDays / 365).floor();
      return '${years}y';
    }
  }

  @override
  Widget build(BuildContext context) {
    final initials = _getInitials();
    final avatarColor = _getAvatarColor();
    final timeAgo = _formatTimeAgo(contact.createdAt);
    final name = contact.displayName.isEmpty ? 'Unnamed' : contact.displayName;
    final role = contact.jobTitle.isEmpty
        ? (contact.company ?? 'Contact')
        : contact.jobTitle;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Container(
              width: 44.r,
              height: 44.r,
              decoration: BoxDecoration(
                color: avatarColor,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                initials,
                style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.5.sp,
                ),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.dmSans(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF15171A),
                      letterSpacing: -0.2,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    role,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.dmSans(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF757575),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  timeAgo,
                  style: GoogleFonts.dmSans(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF8E8E93),
                  ),
                ),
                SizedBox(width: 2.w),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 18.sp,
                  color: const Color(0xFFB0B0B0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
