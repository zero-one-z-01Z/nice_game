import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:nice_game/providers/question_provider.dart';

class QuestionPage extends StatelessWidget {
  const QuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final q = context.watch<QuestionProvider>();

    return Scaffold(
      body: Container(
        width: 100.w,
        height: 100.h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/main_image.jpeg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              SizedBox(height: 5.h),

              // Progress
              Text(
                '${q.index + 1} / ${q.questions.length}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.h),

              // Question card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(3.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  q.question['question'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 6.h),

              // Answer section or Play Again
              Expanded(
                child: q.isLastQuestion && q.finishedLastQuestion
                    ? _PlayAgainButton()
                    : const _AnswerSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnswerSection extends StatelessWidget {
  const _AnswerSection();

  @override
  Widget build(BuildContext context) {
    final q = context.watch<QuestionProvider>();

    if (q.question['type'] == 'yes_no') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _AnswerButton(
            label: 'Yes',
            onTap: () {
              q.setAnswer('Yes');
              q.next();
            },
          ),
          _AnswerButton(
            label: 'No',
            onTap: () {
              q.setAnswer('No');
              q.next();
            },
          ),
        ],
      );
    }

    final controller = TextEditingController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: controller,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        SizedBox(height: 3.h),
        ElevatedButton(
          onPressed: () {
            q.setAnswer(controller.text);
            q.next();
          },
          child: const Text('Next'),
        ),
      ],
    );
  }
}

class _AnswerButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _AnswerButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: onTap,
      child: Text(label, style: const TextStyle(fontSize: 20)),
    );
  }
}

class _PlayAgainButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final q = context.read<QuestionProvider>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 3.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          ),
          onPressed: q.restartApp,
          child: const Text(
            'Play Again',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ],
    );
  }
}
