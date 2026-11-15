import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class ContactsSearchBar extends StatefulWidget {
  const ContactsSearchBar({
    super.key,
    required this.onChanged,
    this.initialValue = '',
  });

  final ValueChanged<String> onChanged;
  final String initialValue;

  @override
  State<ContactsSearchBar> createState() => _ContactsSearchBarState();
}

class _ContactsSearchBarState extends State<ContactsSearchBar> {
  late final TextEditingController _controller;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _hasText = widget.initialValue.isNotEmpty;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged(String value) {
    setState(() {
      _hasText = value.isNotEmpty;
    });
    widget.onChanged(value);
  }

  void _clear() {
    _controller.clear();
    _onTextChanged('');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: const Color(0xFFE2DFD7),
          width: 1,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Row(
        children: [
          Icon(
            Iconsax.search_normal_1,
            size: 18.sp,
            color: const Color(0xFF8E8E93),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: _onTextChanged,
              style: GoogleFonts.dmSans(
                fontSize: 14.5.sp,
                color: const Color(0xFF15171A),
                fontWeight: FontWeight.w500,
              ),
              cursorColor: const Color(0xFFD93A10),
              decoration: InputDecoration(
                hintText: 'Search by name or role',
                hintStyle: GoogleFonts.dmSans(
                  fontSize: 14.5.sp,
                  color: const Color(0xFF9E9E9E),
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (_hasText)
            GestureDetector(
              onTap: _clear,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.only(left: 6.w),
                child: Icon(
                  Icons.close_rounded,
                  size: 18.sp,
                  color: const Color(0xFF8E8E93),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
