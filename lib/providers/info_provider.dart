import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:nice_game/providers/question_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../core/constants.dart';
import '../core/navigation.dart';
import '../pages/info_page.dart';

class InfoProvider extends ChangeNotifier {
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController organization = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();

  bool male = false;

  void goToInfoPage(bool isMale) {
    male = isMale;
    navP(InfoPage(
      image: 'assets/image1.png',
      title: 'Enter your Full Name',
      keyController: 'name',
    ));
    notifyListeners();
  }

  void goToNextInput(String currentKey) {
    if (currentKey == 'name') {
      navP(InfoPage(
        image: 'assets/image1.png',
        title: 'Enter your Mobile Number',
        keyController: 'phone',
      ));
    } else if (currentKey == 'phone') {
      navP(InfoPage(
        image: 'assets/image1.png',
        title: 'Enter your Email Address',
        keyController: 'email',
      ));
    } else if (currentKey == 'email') {
      goToFirstQuestion();
    }
  }

  TextEditingController textEditingController(String key) {
    switch (key) {
      case 'name':
        return name;
      case 'address':
        return address;
      case 'organization':
        return organization;
      case 'phone':
        return phone;
      case 'email':
      default:
        return email;
    }
  }

  void clear() {
    name.clear();
    address.clear();
    organization.clear();
    phone.clear();
    email.clear();
  }

  void goToFirstQuestion() {
    clear();
    Provider.of<QuestionProvider>(
      Constants.globalContext(),
      listen: false,
    ).goToQuestionPage();
  }

  /// ---------------- CSV ----------------
  Future<String> _csvPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/user_data.csv';
  }

  Future<List<List<dynamic>>> _readCsv() async {
    final file = File(await _csvPath());
    if (!await file.exists()) {
      return [
        [
          "TikTok LIVE",
          "Commercial Registration",
          "Marketing/PR",
          "Full Name",
          "Mobile Number",
          "Email Address"
        ]
      ];
    }

    final csvData = await file.readAsString();
    return const CsvToListConverter().convert(csvData);
  }

  /// Save all answers at once
  Future<void> saveAllAnswers(List<String> answers) async {
    final csvData = await _readCsv();
    csvData.add(answers);
    await File(await _csvPath())
        .writeAsString(const ListToCsvConverter().convert(csvData));
  }
}
