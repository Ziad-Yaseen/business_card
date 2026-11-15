import 'package:business_card/features/contacts/cubit/contacts_cubit.dart';
import 'package:business_card/features/contacts/cubit/contacts_state.dart';
import 'package:business_card/features/contacts/widgets/contact_details_modal.dart';
import 'package:business_card/features/contacts/widgets/contact_tile.dart';
import 'package:business_card/features/contacts/widgets/contacts_search_bar.dart';
import 'package:business_card/features/contacts/widgets/scan_banner_widget.dart';
import 'package:business_card/features/main_layout/cubit/main_layout_nav_cubit.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsCubit, ContactsState>(
      builder: (context, state) {
        if (state is ContactsLoading) {
          return const Scaffold(
            backgroundColor: Color(0xFFF7F5EF),
            body: Center(
              child: CircularProgressIndicator(
                color: Color(0xFFD93A10),
              ),
            ),
          );
        }

        if (state is ContactsError) {
          return Scaffold(
            backgroundColor: const Color(0xFFF7F5EF),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Failed to load contacts',
                    style: GoogleFonts.dmSans(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gap(8.h),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<ContactsCubit>().loadContacts(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        final loaded = state as ContactsLoaded;
        final contacts = loaded.filteredContacts;
        final totalCount = loaded.allContacts.length;

        return Scaffold(
          backgroundColor: const Color(0xFFF7F5EF),
          body: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 120.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Row: Title & Subtitle + Scan Button
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Contacts',
                              style: GoogleFonts.bricolageGrotesque(
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF15171A),
                                letterSpacing: -0.5,
                              ),
                            ),
                            Gap(4.h),
                            Text(
                              '$totalCount saved cards · read-only',
                              style: GoogleFonts.dmSans(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF757575),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Scan Pill Button
                      GestureDetector(
                        onTap: () {
                          context.read<MainLayoutNavCubit>().select(1);
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          height: 38.h,
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE24317),
                            borderRadius: BorderRadius.circular(999),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFE24317).withValues(alpha: 0.28),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.crop_free_rounded,
                                size: 16.sp,
                                color: Colors.white,
                              ),
                              Gap(6.w),
                              Text(
                                'Scan',
                                style: GoogleFonts.dmSans(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  Gap(18.h),

                  // Search Bar
                  ContactsSearchBar(
                    initialValue: loaded.searchQuery,
                    onChanged: (query) {
                      context.read<ContactsCubit>().search(query);
                    },
                  ),

                  Gap(24.h),

                  // Section Title
                  Text(
                    'RECENTLY SAVED',
                    style: GoogleFonts.dmSans(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF757575),
                      letterSpacing: 1.1,
                    ),
                  ),

                  Gap(10.h),

                  // Contacts List Card Container
                  if (contacts.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 36.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 40.sp,
                            color: const Color(0xFFB0B0B0),
                          ),
                          Gap(10.h),
                          Text(
                            loaded.searchQuery.isEmpty
                                ? 'No saved cards yet'
                                : 'No contacts match "${loaded.searchQuery}"',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.dmSans(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF757575),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: Column(
                          children: [
                            for (int i = 0; i < contacts.length; i++) ...[
                              if (i > 0)
                                Divider(
                                  height: 1,
                                  thickness: 1,
                                  indent: 72.w,
                                  color: const Color(0xFFF2F0EB),
                                ),
                              ContactTile(
                                contact: contacts[i],
                                index: i,
                                onTap: () {
                                  showContactDetailsModal(
                                    context,
                                    contacts[i],
                                  );
                                },
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),

                  Gap(20.h),

                  // Bottom Dashed QR Info Banner
                  ScanBannerWidget(
                    onTap: () {
                      context.read<MainLayoutNavCubit>().select(1);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
