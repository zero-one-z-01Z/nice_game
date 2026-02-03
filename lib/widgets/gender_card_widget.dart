import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nice_game/providers/info_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class GenderCard extends StatelessWidget {
  const GenderCard({
    super.key,
    required this.image,
    required this.title,
    required this.isMale,
  });

  final String image;
  final String title;
  final bool isMale;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<InfoProvider>().goToInfoPage(isMale);
      },
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff681214),
              Color(0xffCE2428),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 5.h),
            Image.asset(image),
            SizedBox(
              height: 7.h,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
