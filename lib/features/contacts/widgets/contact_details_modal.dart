import 'package:business_card/core/components/main_card_preview.dart';
import 'package:business_card/data/models/card_model.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

void showContactDetailsModal(BuildContext context, CardModel contact) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => _ContactDetailsModalContent(contact: contact),
  );
}

class _ContactDetailsModalContent extends StatelessWidget {
  const _ContactDetailsModalContent({required this.contact});

  final CardModel contact;

  void _copyToClipboard(BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label copied to clipboard'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final name = contact.displayName.isEmpty ? 'Contact' : contact.displayName;
    final role = contact.jobTitle.isEmpty
        ? (contact.company ?? '')
        : contact.jobTitle;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7F5EF),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 32.h),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4D0C5),
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),
              Gap(16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: GoogleFonts.bricolageGrotesque(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF15171A),
                          ),
                        ),
                        if (role.isNotEmpty)
                          Text(
                            role,
                            style: GoogleFonts.dmSans(
                              fontSize: 14.sp,
                              color: const Color(0xFF757575),
                            ),
                          ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                    color: const Color(0xFF757575),
                  ),
                ],
              ),
              Gap(20.h),
              AspectRatio(
                aspectRatio: 342 / 196,
                child: MainCardPreview(card: contact, addSpacer: true),
              ),
              Gap(24.h),
              if (contact.phone.isNotEmpty) ...[
                Text(
                  'PHONE',
                  style: GoogleFonts.dmSans(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF757575),
                    letterSpacing: 1.1,
                  ),
                ),
                Gap(8.h),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Column(
                    children: [
                      for (int i = 0; i < contact.phone.length; i++) ...[
                        if (i > 0)
                          const Divider(height: 1, indent: 16, endIndent: 16),
                        ListTile(
                          dense: true,
                          leading: const Icon(
                            Iconsax.call,
                            color: Color(0xFF1E7A55),
                            size: 20,
                          ),
                          title: Text(
                            contact.phone[i],
                            style: GoogleFonts.dmSans(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Iconsax.copy, size: 18),
                            onPressed: () => _copyToClipboard(
                              context,
                              contact.phone[i],
                              'Phone number',
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Gap(16.h),
              ],
              if (contact.email.isNotEmpty) ...[
                Text(
                  'EMAIL',
                  style: GoogleFonts.dmSans(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF757575),
                    letterSpacing: 1.1,
                  ),
                ),
                Gap(8.h),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Column(
                    children: [
                      for (int i = 0; i < contact.email.length; i++) ...[
                        if (i > 0)
                          const Divider(height: 1, indent: 16, endIndent: 16),
                        ListTile(
                          dense: true,
                          leading: const Icon(
                            Iconsax.sms,
                            color: Color(0xFF2454DB),
                            size: 20,
                          ),
                          title: Text(
                            contact.email[i],
                            style: GoogleFonts.dmSans(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Iconsax.copy, size: 18),
                            onPressed: () => _copyToClipboard(
                              context,
                              contact.email[i],
                              'Email',
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Gap(16.h),
              ],
              if (contact.linkedIn.isNotEmpty ||
                  (contact.github != null && contact.github!.isNotEmpty) ||
                  (contact.portfolio != null && contact.portfolio!.isNotEmpty)) ...[
                Text(
                  'LINKS & SOCIAL',
                  style: GoogleFonts.dmSans(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF757575),
                    letterSpacing: 1.1,
                  ),
                ),
                Gap(8.h),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Column(
                    children: [
                      if (contact.linkedIn.isNotEmpty)
                        ListTile(
                          dense: true,
                          leading: const Icon(
                            Icons.link_rounded,
                            color: Color(0xFF0077B5),
                            size: 20,
                          ),
                          title: Text(
                            contact.linkedIn,
                            style: GoogleFonts.dmSans(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Iconsax.copy, size: 18),
                            onPressed: () => _copyToClipboard(
                              context,
                              contact.linkedIn,
                              'LinkedIn',
                            ),
                          ),
                        ),
                      if (contact.github != null &&
                          contact.github!.isNotEmpty) ...[
                        const Divider(height: 1, indent: 16, endIndent: 16),
                        ListTile(
                          dense: true,
                          leading: const Icon(
                            Icons.code_rounded,
                            color: Color(0xFF15171A),
                            size: 20,
                          ),
                          title: Text(
                            contact.github!,
                            style: GoogleFonts.dmSans(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Iconsax.copy, size: 18),
                            onPressed: () => _copyToClipboard(
                              context,
                              contact.github!,
                              'GitHub',
                            ),
                          ),
                        ),
                      ],
                      if (contact.portfolio != null &&
                          contact.portfolio!.isNotEmpty) ...[
                        const Divider(height: 1, indent: 16, endIndent: 16),
                        ListTile(
                          dense: true,
                          leading: const Icon(
                            Icons.language_rounded,
                            color: Color(0xFFD93A10),
                            size: 20,
                          ),
                          title: Text(
                            contact.portfolio!,
                            style: GoogleFonts.dmSans(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Iconsax.copy, size: 18),
                            onPressed: () => _copyToClipboard(
                              context,
                              contact.portfolio!,
                              'Portfolio',
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
