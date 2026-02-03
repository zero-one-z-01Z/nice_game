import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nice_game/core/navigation.dart';
import 'package:nice_game/providers/question_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../providers/question_video_provider.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuestionVideoProvider>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = context.watch<QuestionProvider>();
    final video = context.watch<QuestionVideoProvider>();

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
        child: Stack(
          children: [
            //  Background video
            SizedBox(
              width: 100.w,
              height: 100.h,
              child: video.isInitialized
                  ? VideoPlayer(video.controller)
                  : const SizedBox(),
            ),

            //  Overlay color
            if (question.backgroundColor() != null)
              Container(
                width: 100.w,
                height: 100.h,
                color: question.backgroundColor()!.withOpacity(0.3),
              ),

            //  UI
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Column(
                children: [
                  SizedBox(height: 3.w),

                  _TopBar(question),

                  ShaderMask(
                    shaderCallback: (v) => const LinearGradient(
                      colors: [Color(0xff681214), Color(0xffCE2428)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(v),
                    child: const Text(
                      "Choose the correct \nanswer for the question",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        height: 1,
                      ),
                    ),
                  ),

                  SizedBox(height: 5.h),

                  _QuestionCard(question),

                  SizedBox(height: 5.h),

                  _AnswersGrid(question),

                  SizedBox(height: 5.h),

                  _Timer(question),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _TopBar(QuestionProvider q) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      InkWell(
        onTap: navPop,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 5.w,
          child: Icon(Icons.close, color: Colors.red, size: 5.w),
        ),
      ),
      CircleAvatar(
        backgroundColor: Colors.white,
        radius: 5.w,
        child: Text(
          '${q.index + 1}/${q.questions.length}',
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}

Widget _QuestionCard(QuestionProvider q) {
  return Container(
    width: 90.w,
    padding: EdgeInsets.symmetric(vertical: 3.h),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Text(
      q.question()['question'],
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );
}

Widget _AnswersGrid(QuestionProvider q) {
  return Wrap(
    spacing: 5.w,
    runSpacing: 3.h,
    children: List.generate(
      q.question()['answers'].length,
      (index) {
        final answer = q.question()['answers'][index];
        final correct = q.correctAnswer(answer);
        final wrong = q.wrongAnswer(index, answer);

        return InkWell(
          onTap: () => q.setAnswerIndex(index),
          child: Container(
            width: 43.w,
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: (correct || wrong)
                  ? null
                  : const LinearGradient(
                      colors: [Color(0xff681214), Color(0xffCE2428)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
              color: correct
                  ? Colors.green
                  : wrong
                      ? Colors.red
                      : null,
              border: q.answerIndex == index
                  ? Border.all(color: Colors.green, width: 6)
                  : null,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(q.alpha[index]),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Text(
                    answer,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

Widget _Timer(QuestionProvider q) {
  return Container(
    width: 30.w,
    height: 30.w,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.red, width: 4),
    ),
    child: Center(
      child: q.answerFinish
          ? Lottie.asset(q.lottie())
          : Text(
              q.counter.toString(),
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
    ),
  );
}
