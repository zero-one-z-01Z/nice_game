import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../widgets/back_button_widget.dart';
import '../widgets/gender_card_widget.dart';

class SelectGenderPage extends StatelessWidget {
  const SelectGenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 100.w,
        height: 100.h,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/main_image.jpeg'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 6.h),
              const _Header(),
              SizedBox(height: 2.h),
              const Text(
                'Select Your Gender',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.h),
              const _GenderRow(),
            ],
          ),
        ),
      ),
    );
  }
}


class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 2.w),
        const BackButtonWidget(),
        const Spacer(),
        Image.asset(
          'assets/image1.png',
          width: 30.w,
          fit: BoxFit.fitWidth,
        ),
        const Spacer(),
        SizedBox(width: 2.w),
      ],
    );
  }
}


class _GenderRow extends StatelessWidget {
  const _GenderRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        GenderCard(
          image: 'assets/male.png',
          title: 'MALE',
          isMale: true,
        ),
        GenderCard(
          image: 'assets/female.png',
          title: 'FEMALE',
          isMale: false,
        ),
      ],
    );
  }
}
