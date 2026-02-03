

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nice_game/pages/game_over_page.dart';
import 'package:nice_game/core/navigation.dart';
import 'package:nice_game/pages/question_page.dart';

class QuestionProvider extends ChangeNotifier{

  int answerIndex = -1,counter = 30;
  List<Map> questions = [];
  List<String> alpha = ['A','B','C','D'];
  int index = 0;
  bool answerFinish = false;
  Timer? timer,answerTimer;

  Future initQuestion()async{
    index = 0;
    counter = 30;
    answerIndex = -1;
    timer?.cancel();
    answerTimer?.cancel();
    answerFinish = false;
    questions.clear();
    String data = await rootBundle.loadString('assets/questions.txt');

    // Split the data into lines and remove any empty lines
    List<String> dataQuestions = data.split('\n').toList();

    for(var i in dataQuestions){
      if(i.endsWith('\n')||i.endsWith('\r')){
        i = i.substring(0,i.length-1);
      }
      print(i);
      Map question = {};
      List<String> parts = i.split(':');
      question['question'] = parts[0];
      List<String> parts2 = parts[1].split('->');
      question['answer'] = parts2[1];
      question['answers'] =  parts2[0].split(',').where((a) => a.isNotEmpty).toList();
      question['user_answer'] = null;
      questions.add(question);
    }
  }
  Map question(){
    return questions[index];
  }

  void setAnswerIndex(int i){
    if(!answerFinish){
      if(i==answerIndex){
        finishAnswer();
      }else{
        answerIndex = i;
      }
      notifyListeners();
    }
  }
  void finishAnswer(){
    answerFinish = true;
    timer?.cancel();
    notifyListeners();
    answerTimer = Timer.periodic(Duration(seconds: 3), (t){
      t.cancel();
      answerTimer?.cancel();
      goToNextQuestion();
    });
  }
  void goToNextQuestion(){
    if(answerIndex!=-1){
      question()['user_answer'] = question()['answers'][answerIndex];
    }
    if(index == questions.length-1){
      int score = 0;
      for(var i in questions){
        if(i['answer']==i['user_answer']){
          score++;
        }
      }
      print([score,(questions.length)/2,score>=((questions.length)/2)]);
      if(score>=((questions.length)/2)){
        navP(GameOverPage(path: 'c:\\win.mp4'));
      }else{
        navP(GameOverPage(path: 'c:\\game_over.mp4'));
      }
    }else{
      index++;
      answerIndex = -1;
      counter = 30;
      answerFinish = false;
      timer?.cancel();
      answerTimer?.cancel();
      startTimer();
    }
    notifyListeners();
  }

  bool correctAnswer(String answer){
    return question()['answer'] == answer && answerFinish;
  }
  bool wrongAnswer(int index,String answer){
    return index==answerIndex&&answerFinish&&question()['answer'] != answer;
  }

  Color? backgroundColor (){
    if(answerFinish){
      if(answerIndex==-1){
        return Colors.red;
      }
      bool check = correctAnswer(question()['answers'][answerIndex]);
      return check ?Colors.green:Colors.red;
    }
    return null;
  }
  String lottie(){
    if(answerIndex==-1){
      return 'assets/wrong.json';
    }
    bool check = correctAnswer(question()['answers'][answerIndex]);
    return check ?'assets/success.json':'assets/wrong.json';
  }

  void goToQuestionPage()async{
    await initQuestion();
    navP(QuestionPage(),then: (val){
      timer?.cancel();
      answerTimer?.cancel();
    });
    startTimer();
  }

  void startTimer(){
    timer = Timer.periodic(Duration(seconds: 1), (time){
      if(counter==0){
        time.cancel();
        timer?.cancel();
        finishAnswer();
      }
      if(counter>0){
        counter--;
      }
      notifyListeners();
    });
  }


}