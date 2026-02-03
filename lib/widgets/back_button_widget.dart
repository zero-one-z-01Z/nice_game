import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../core/navigation.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        navPop();
      },
      child: Container(
        width: 60,
        height:60,
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(2.w),
        child: const Icon(Icons.close,color: Colors.white,size: 30,),
      ),
    );
  }
}
