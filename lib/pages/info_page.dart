import 'package:flutter/material.dart';
import 'package:nice_game/providers/info_provider.dart';
import 'package:nice_game/widgets/back_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

import '../core/input_decoration.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({
    super.key,
    required this.image,
    required this.title,
    required this.keyController,
  });

  final String image;
  final String title;
  final String keyController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 100.w,
        height: 100.h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/main_image.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 6.h),
            _Header(image: image),
            SizedBox(height: 2.h),
            Text(
              title,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.h),
            _InfoInputField(keyController: keyController),
            SizedBox(height: 5.h),
            _VirtualKeyboardSection(keyController: keyController),
          ],
        ),
      ),
    );
  }
}
class _Header extends StatelessWidget {
  const _Header({required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 2.w),
        const BackButtonWidget(),
        const Spacer(),
        Image.asset(image, width: 30.w),
        const Spacer(),
        SizedBox(width: 2.w),
      ],
    );
  }
}



class _InfoInputField extends StatelessWidget {
  const _InfoInputField({required this.keyController});
  final String keyController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Consumer<InfoProvider>(
        builder: (_, provider, __) {
          final controller = provider.textEditingController(keyController);

          return TextFormField(
            controller: controller,
            autofocus: true,
            cursorHeight: 25,
            cursorColor: Colors.black,
            style: const TextStyle(fontSize: 20),
            decoration: inputDecoration(
              context,
              label: '',
              suffix: keyController == 'phone' && controller.text.isNotEmpty,
              onTap: () => provider.goToNextInput(keyController),
            ),
          );
        },
      ),
    );
  }
}

class _VirtualKeyboardSection extends StatelessWidget {
  const _VirtualKeyboardSection({required this.keyController});
  final String keyController;

  @override
  Widget build(BuildContext context) {
    return Consumer<InfoProvider>(
      builder: (_, provider, __) {
        return Container(
          margin: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: VirtualKeyboard(
              height: 20.h,
              width: 90.w,
              textColor: Colors.white,
              fontSize: 20,
              textController:
                  provider.textEditingController(keyController),
              type: keyController == 'phone'
                  ? VirtualKeyboardType.Numeric
                  : VirtualKeyboardType.Alphanumeric,
              defaultLayouts: keyController == 'phone'
                  ? [VirtualKeyboardDefaultLayouts.English]
                  : [
                      VirtualKeyboardDefaultLayouts.English,
                      VirtualKeyboardDefaultLayouts.Arabic,
                    ],
              postKeyPress: (val) {
                if (val.action == VirtualKeyboardKeyAction.Return) {
                  provider.goToNextInput(keyController);
                }
                if (keyController == 'phone') {
                  provider.rebuild();
                }
              },
            ),
          ),
        );
      },
    );
  }
}




