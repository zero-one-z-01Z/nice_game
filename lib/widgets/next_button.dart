import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.onPressed,
    this.label = "Next",
    this.width,
    this.height,
  });

  final VoidCallback onPressed;
  final String label;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: width ?? 40.w,
        height: height ?? 6.h,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xff681214), Color(0xffCE2428)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:0.4),
              offset: const Offset(0, 4),
              blurRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
