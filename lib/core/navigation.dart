import 'package:flutter/material.dart';
import 'constants.dart';

void navP(className, {void Function(dynamic val)? then}){
  // PageTransitionType type = PageTransitionType.fade,
  Navigator.push(Constants.globalContext(), MaterialPageRoute(builder: (context)=>className)).then((value) {
    if(then!=null){
      then(value);
    }
  });
}

bool canPop(){
  return Navigator.canPop(Constants.globalContext());
}
void navPR(className){
  Navigator.pushReplacement(Constants.globalContext(), MaterialPageRoute(builder: (context)=>className));
}
void navPARU(className){
  Navigator.pushAndRemoveUntil(Constants.globalContext(), MaterialPageRoute(builder: (context)=>className), (route) => false);
}
void navPop([dynamic val]){
  Navigator.pop(Constants.globalContext(),val);
}
void navPU(){
  Navigator.popUntil(Constants.globalContext(), (route) => route.isFirst);
}