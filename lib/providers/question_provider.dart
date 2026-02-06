import 'package:flutter/material.dart';
import 'package:nice_game/pages/question_page.dart';
import 'package:nice_game/pages/home_page.dart';
import 'package:nice_game/core/navigation.dart';
import 'package:provider/provider.dart';
import '../core/constants.dart';
import 'info_provider.dart';

class QuestionProvider extends ChangeNotifier {
  int index = 0;
  bool finishedLastQuestion = false;

  // Questions
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Are you interested in TikTok LIVE?',
      'type': 'yes_no',
      'user_answer': null
    },
    {
      'question': 'Do you have valid commercial Registration?',
      'type': 'yes_no',
      'user_answer': null
    },
    {
      'question':
          'Are you into Social Media, Marketing, PR, Influencers Marketing?',
      'type': 'yes_no',
      'user_answer': null
    },
    {'question': 'What’s your Full Name?', 'type': 'fill', 'user_answer': null},
    {
      'question': 'What’s your Mobile Number?',
      'type': 'fill',
      'user_answer': null
    },
    {
      'question': 'What’s your Email Address?',
      'type': 'fill',
      'user_answer': null
    },
  ];

  bool get isLastQuestion => index == questions.length - 1;
  Map<String, dynamic> get question => questions[index];

  /// ---------------- FLOW ----------------
  void goToQuestionPage() {
    index = 0;
    finishedLastQuestion = false;
    for (var q in questions) q['user_answer'] = null;

    navP(const QuestionPage());
    notifyListeners();
  }

  void setAnswer(dynamic value) {
    question['user_answer'] = value;

    if (isLastQuestion) finishedLastQuestion = true;
    notifyListeners();
  }

  void next() {
    if (!isLastQuestion) {
      index++;
      notifyListeners();
    } else {
      // Save all answers into the single CSV
      final answers =
          questions.map((q) => q['user_answer']?.toString() ?? '').toList();
      final infoProvider = Constants.globalContext().read<InfoProvider>();
      infoProvider.saveAllAnswers(answers);
    }
  }

  void restartApp() {
    index = 0;
    finishedLastQuestion = false;
    for (var q in questions) q['user_answer'] = null;

    final infoProvider = Constants.globalContext().read<InfoProvider>();
    infoProvider.clear();

    notifyListeners();
    navP(const HomePage());
  }
}
