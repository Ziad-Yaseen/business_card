import 'package:business_card/core/components/card_preview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PreviewView extends StatelessWidget {
  const PreviewView({super.key});
  @override
  Widget build(BuildContext context) {
    List <Map<String, dynamic>> Info = [
      {
        "leading" : Icons.email_outlined,
        "title" : "Email",
        "subtitle" : "ziad@example.com",
      },
      {
        "leading" : Icons.phone_outlined,
        "title" : "Phone",
        "subtitle" : "+20 100 000 0000",
      },
      {
        "leading" : Icons.email_outlined,
        "title" : "LinkedIn",
        "subtitle" : "linkedin.com/in/your-name",
      },
      {
        "leading" : Icons.email_outlined,
        "title" : "GitHub",
        "subtitle" : "github.com/your-name",
      }
    ];
    return Scaffold(
      backgroundColor: Color(0xFFF4F1EA),
      body: Column(
        children: [
           ListTile(
            leading: Container(
              height: 44,
              width: 44,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFFFFFF),
              ),
              child: Icon(Icons.arrow_back_ios_new, size: 22),
            ),
            title: Container(
              color: Color(0xFFFFFFFF),
              width: 174,
              height: 46,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Work", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,height: 1.1)),
                  Text("Default card", style: TextStyle(color: Color(0xFF5F636A),
                      fontSize: 14, height: 1.1)
                  ),

                ],
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children:[
                Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFFFFFFF),
                  ),
                  child: const Icon(Icons.edit_outlined, size: 22),
                ),
                Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFFFFFFF),
                  ),
                  child: const Icon(Icons.more_vert, size: 22),
                ),
              ]
            )
          ),
          Gap(10.h),
          Container(
            height: 198,
            width: 342,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF2A2D34),
                  Color(0xFF0F1013),
                ]
              )
            ),
            child:  Stack(
              children: [
                const Positioned(
                  top: 21,
                  left: 22,
                    child: Text("Ziad Yaseen",style: TextStyle(
                      color: Color(0xFFFFFFFF),fontSize: 26,
                        fontWeight: FontWeight.bold),
                    ),
                ),
                const Positioned(
                  top: 55,
                  left: 22,
                  child: Text("Flutter Developer",style: TextStyle(
                      color: Color(0xFFFFFFFF),fontSize: 14,),
                  ),
                ),
                const Positioned(
                  bottom: 24,
                  left: 22,
                  child: Text("Mobile apps with Flutter",style: TextStyle(
                    color: Color(0xFFFFFFFF),fontSize: 13,),
                  ),
                ),
                Positioned(
                  top: 22,
                  right: 22,
                  child: Container(
                    width: 56,
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const  Color(0x29FFFFFF),
                    ),
                      child: const Center(
                        child: Text("WORK",style: TextStyle(
                          color: Colors.white,fontWeight: FontWeight.bold ,fontSize: 11),
                        ),
                      ),
                  ),
                ),
                Positioned(
                  bottom: 22,
                  right: 22,
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                        color: const  Color(0x24FFFFFF),
                      border: Border.all(color: Color(0x59FFFFFF),
                        width: 2,
                      )
                    ),
                    child: const Center(
                      child: Text("ZY",style: TextStyle(
                          color: Colors.white,fontWeight: FontWeight.bold ,fontSize: 19),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 24,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Color(0x45FFFFFF),
                          width: 1.5,
                        )
                    ),
                  ),
                ),
                Positioned(
                  bottom: -20,
                  right: -4,
                  child: Container(
                    width: 116,
                    height: 116,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Color(0x45FFFFFF),
                          width: 1.5,
                        )
                    ),
                  ),
                ),
                Positioned(
                  bottom: -45,
                  right: -30,
                  child: Container(
                    width: 172,
                    height: 172,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Color(0x45FFFFFF),
                          width: 1.5,
                        )
                    ),
                  ),
                ),
              ],
            )
          ),
          Gap(10.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: 22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28)
              ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("lib/features/preview/screens/qrcode.png"),
                    Gap(14.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Color(0xFFF4F1EA),
                      ),
                      child: Row(
                        children: [

                             const Expanded(
                               child: Text(
                                 maxLines: 2,
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                    'ziad.github.io/card/#v1.H4sIAAAAAAAA',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                   ),


                         ),
                          Spacer(),
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Center(
                              child: Icon(Icons.copy,size: 18,
                              color:Colors.black),
                            )
                          ),
                        ],
                      ),
                    ),
                    Gap(15.h),
                    const Text("Scan to open this card, no app needed",
                    style: TextStyle(fontSize: 13),)
                  ],
                ),
            ),
          ),
          Gap(10.h),
          Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 24),
          child: Row(
            children: [
              Expanded(child: TextButton.icon(
                style: TextButton.styleFrom(
                  minimumSize: Size(0, 52.h),
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 16.5, vertical: 15),
                ),
                onPressed: (){},
                  label: Text("Share",
                  style: GoogleFonts.dmSans(
                    fontSize: 15.sp,
                    fontWeight: .w600,
                    color: Colors.white,
                  ),
                  ),
                icon: Icon(Icons.share),
              ),
              ),
              Gap(10.w),
              Expanded(child: TextButton.icon(
                style: TextButton.styleFrom(
                    minimumSize: Size(0, 52.h),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 16.5, vertical: 15),

                ),
                onPressed: (){},
                label: Text("Save QR",
                  style: GoogleFonts.dmSans(
                    fontSize: 15.sp,
                    fontWeight: .w600,
                  ),
                ),
                icon: Icon(Icons.vertical_align_bottom,color: Colors.black),
              ),
              ),
              Gap(10.w),
              Expanded(child: TextButton.icon(
                style: TextButton.styleFrom(
                  minimumSize: Size(0, 52.h),
                  padding: EdgeInsets.symmetric(horizontal: 16.5, vertical: 15),

                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,

                ),
                onPressed: (){},
                label: Text("Copy",
                  style: GoogleFonts.dmSans(
                    fontSize: 15.sp,
                    fontWeight: .w600,
                    color: Colors.black,
                  ),),
                icon: Icon(Icons.link,color: Colors.black),),
              ),
            ]
          )
          ),
          Gap(24.h),
          Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: 24),
          child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("IN THIS CARD",
              style: GoogleFonts.dmSans(
                fontSize: 13.sp,
                fontWeight: .w600,
                color: Color(0xFF5F636A),
              )
              ),
              Text("ALL included in the link",
                  style: GoogleFonts.dmSans(
                    fontSize: 13.sp,
                    fontWeight: .w600,
                    color: Color(0xFF5F636A),
                  )
              )
            ]
          ),
          ),
          Gap(10.h),
          ListView.builder(
              itemBuilder:
          )
        ],
      )
    );
  }
}


class _PreviewAppBar extends StatelessWidget {
  const _PreviewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Gap(12.w),
        CardPreview(
        ),
      ],
    );
  }
}
