import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

InputDecoration inputDecoration(context,{bool obscureText = false,
  double? borderR,void Function()? onTap,
  int max = 1,bool translateOpen = true,Color? hintColor,
  bool title = false,String? titleText,Color? color,
  Widget? prefix,required String label,bool suffix = false,
  TextStyle? hintStyle,bool counter = false
}){
  return InputDecoration(
    counterText: counter?null:'',
    hintText: title?(titleText!=null?label:null):label,
    fillColor: color??Colors.white,
    filled: true,
    hintStyle: hintStyle??TextStyle(fontSize: 10.sp,color: hintColor??Colors.black,height: 1,),
    floatingLabelStyle: TextStyle(color: Colors.white,fontSize: 11.sp),
    floatingLabelBehavior: max==1?null:FloatingLabelBehavior.always,
    border: border(borderR: borderR),
    disabledBorder:border(borderR: borderR),
    focusedBorder: border(borderR: borderR),
    enabledBorder: border(borderR: borderR),
    errorBorder: border(color: Colors.red,borderR: borderR),
    focusedErrorBorder: border(color: Colors.red,borderR: borderR),
    hoverColor: Colors.grey,
    prefixIcon: prefix,
    contentPadding: max==1?EdgeInsets.symmetric(horizontal: 3.w):EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.h),
    suffixIcon: !suffix?null:IconButton(onPressed:onTap,
        icon: Icon(Icons.arrow_circle_right_sharp,
          size: 5.w,color: Colors.green,),
        splashColor: Colors.transparent,highlightColor: Colors.transparent),
  );
}
InputBorder border({Color? color,double? borderR}){
  return OutlineInputBorder(borderRadius: BorderRadius.circular(borderR??8),
      borderSide: BorderSide(color: color??Colors.white));
}
