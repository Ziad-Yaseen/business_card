import 'package:business_card/core/constants/app_colors.dart';
import 'package:business_card/core/helpers/theme_extension.dart';
import 'package:business_card/data/models/card_model.dart';
import 'package:business_card/data/models/saved_contact.dart';
import 'package:business_card/features/contacts/cubit/contacts_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:material_ui/material_ui.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContactsCubit(),
      child: const _ContactsBody(),
    );
  }
}

class _ContactsBody extends StatelessWidget {
  const _ContactsBody();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 120.h),
        child: BlocBuilder<ContactsCubit, ContactsState>(
          builder: (context, state) {
            final count = state.all.length;
            final visible = state.visible;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contacts',
                  style: GoogleFonts.bricolageGrotesque(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.64,
                    color: AppAccent.primaryText(context),
                  ),
                ),
                Gap(4.h),
                Text(
                  '$count saved ${count == 1 ? 'card' : 'cards'} · read-only',
                  style: GoogleFonts.dmSans(
                    fontSize: 14.sp,
                    color: AppAccent.secoundaryText(context),
                  ),
                ),
                Gap(20.h),
                const _SearchField(),
                Gap(24.h),
                if (state.status == ContactsStatus.loading)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: const Center(child: CircularProgressIndicator()),
                  )
                else if (state.status == ContactsStatus.failure)
                  const _Message('Could not load your contacts')
                else ...[
                  if (visible.isNotEmpty) ...[
                    Text(
                      'RECENTLY SAVED',
                      style: GoogleFonts.dmSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                        color: AppAccent.secoundaryText(context),
                      ),
                    ),
                    Gap(10.h),
                    _ContactsGroup(items: visible),
                  ] else if (count > 0)
                    const _Message('No matches')
                  else
                    const SizedBox.shrink(),
                  Gap(16.h),
                  const _ScanHint(),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.dmSans(
            fontSize: 14.sp,
            color: AppAccent.secoundaryText(context),
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(28.r);
    final noBorder = OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide.none,
    );

    return TextField(
      onChanged: context.read<ContactsCubit>().search,
      textInputAction: TextInputAction.search,
      style: GoogleFonts.dmSans(
        fontSize: 15.sp,
        color: AppAccent.primaryText(context),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppAccent.cardBg(context),
        hintText: 'Search by name or role',
        hintStyle: GoogleFonts.dmSans(
          fontSize: 15.sp,
          color: AppAccent.secoundaryText(context),
        ),
        prefixIcon: Icon(
          Iconsax.search_normal_1,
          size: 20.sp,
          color: AppAccent.secoundaryText(context),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16.h),
        border: noBorder,
        enabledBorder: noBorder,
        focusedBorder: noBorder,
      ),
    );
  }
}

class _ContactsGroup extends StatelessWidget {
  const _ContactsGroup({required this.items});
  final List<SavedContact> items;

  @override
  Widget build(BuildContext context) {
    final border = AppAccent.border(context).withValues(alpha: 0.5);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppAccent.cardBg(context),
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(21.r),
        child: Column(
          children: [
            for (var i = 0; i < items.length; i++) ...[
              if (i != 0) Divider(height: 1, thickness: 1, color: border),
              _ContactTile(contact: items[i]),
            ],
          ],
        ),
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({required this.contact});
  final SavedContact contact;

  @override
  Widget build(BuildContext context) {
    final card = contact.card;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: null,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          child: Row(
            children: [
              _Avatar(card: card),
              Gap(14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      card.displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.dmSans(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppAccent.primaryText(context),
                      ),
                    ),
                    Gap(2.h),
                    Text(
                      card.jobTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.dmSans(
                        fontSize: 13.sp,
                        color: AppAccent.secoundaryText(context),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(8.w),
              Text(
                _ago(contact.savedAt),
                style: GoogleFonts.dmSans(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppAccent.secoundaryText(context),
                ),
              ),
              Gap(6.w),
              Icon(
                Icons.chevron_right_rounded,
                size: 22.sp,
                color: AppAccent.primaryText(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _ago(DateTime date) {
    final now = DateTime.now();
    final days = DateTime(
      now.year,
      now.month,
      now.day,
    ).difference(DateTime(date.year, date.month, date.day)).inDays;
    if (days <= 0) return 'Today';
    if (days < 7) return '${days}d';
    if (days < 30) return '${days ~/ 7}w';
    if (days < 365) return '${days ~/ 30}mo';
    return '${days ~/ 365}y';
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.card});
  final CardModel card;

  @override
  Widget build(BuildContext context) {
    final index = card.cardColor.clamp(0, AppAccent.presets.length - 1);
    final color = AppAccent.presets[index].light;
    final first = card.firstName.trim();
    final last = card.lastName.trim();
    final initials =
        '${first.isEmpty ? '' : String.fromCharCode(first.runes.first)}'
                '${last.isEmpty ? '' : String.fromCharCode(last.runes.first)}'
            .toUpperCase();

    return Container(
      width: 48.w,
      height: 48.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Text(
        initials.isEmpty ? '?' : initials,
        style: GoogleFonts.bricolageGrotesque(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _ScanHint extends StatelessWidget {
  const _ScanHint();

  @override
  Widget build(BuildContext context) {
    final radius = 18.r;

    return CustomPaint(
      foregroundPainter: _DashedBorderPainter(
        color: AppAccent.secoundaryText(context).withValues(alpha: 0.6),
        radius: radius,
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppAccent.cardBg3(context),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 1.h),
              child: Icon(
                Iconsax.scan_barcode,
                size: 20.sp,
                color: AppAccent.secoundaryText(context),
              ),
            ),
            Gap(12.w),
            Expanded(
              child: Text(
                'Scan someone’s QR code to keep their card here. '
                'Call, email or open their links in one tap.',
                style: GoogleFonts.dmSans(
                  fontSize: 13.sp,
                  height: 1.45,
                  color: AppAccent.secoundaryText(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({required this.color, required this.radius});

  final Color color;
  final double radius;

  static const _dash = 5.0;
  static const _gap = 4.0;
  static const _stroke = 1.2;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(_stroke / 2);
    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = _stroke;

    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(metric.extractPath(distance, distance + _dash), paint);
        distance += _dash + _gap;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter old) =>
      old.color != color || old.radius != radius;
}
