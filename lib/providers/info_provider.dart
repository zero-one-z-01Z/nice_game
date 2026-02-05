import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:nice_game/pages/info_page.dart';
import 'package:nice_game/pages/select_gender_page.dart';
import 'package:nice_game/providers/question_provider.dart';
import 'package:nice_game/core/navigation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../core/constants.dart';

class InfoProvider extends ChangeNotifier {
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController organization = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();

  bool male = false;

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

  void goToGenderPage() {
    clear();
    navP(const SelectGenderPage());
  }

  void goToInfoPage(bool male) {
    this.male = male;
    navP(const InfoPage(
      image: 'assets/image2.png',
      title: 'Enter Your Name',
      keyController: 'name',
    ));
  }

  void goToNextInput(String keyController) {
    if (keyController == 'name') {
      navP(const InfoPage(
        image: 'assets/image3.png',
        title: 'Enter Your Address',
        keyController: 'address',
      ));
    } else if (keyController == 'address') {
      navP(const InfoPage(
        image: 'assets/image4.png',
        title: 'Enter Your Organization',
        keyController: 'organization',
      ));
    } else if (keyController == 'organization') {
      navP(const InfoPage(
        image: 'assets/image5.png',
        title: 'Enter Your Phone',
        keyController: 'phone',
      ));
    } else if (keyController == 'phone') {
      navP(const InfoPage(
        image: 'assets/image5.png',
        title: 'Enter Your Email',
        keyController: 'email',
      ));
    } else {
      startGame();
    }
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
          "Name",
          "Gender",
          "Address",
          "Phone",
          "Email",
          "Organization",
          "Q1",
          "Q2",
          "Q3"
        ] // Add as many Q columns as you have questions
      ];
    }

    final csvData = await file.readAsString();
    return const CsvToListConverter().convert(csvData);
  }

  Future<void> startGame() async {
    // Save info + go to QuestionPage
    final csvData = await _readCsv();

    // Append empty answers for now
    final row = [
      name.text.trim(),
      male ? "Male" : "Female",
      address.text.trim(),
      phone.text.trim(),
      email.text.trim(),
      organization.text.trim(),
      '', // Q1
      '', // Q2
      '', // Q3
    ];

    csvData.add(row);
    await File(await _csvPath())
        .writeAsString(const ListToCsvConverter().convert(csvData));

    Provider.of<QuestionProvider>(
      Constants.globalContext(),
      listen: false,
    ).goToQuestionPage();
  }

  /// Update the last row with question answers
  Future<void> updateCsvAnswers(List<String> answers) async {
    final csvData = await _readCsv();
    if (csvData.length < 2) return; // nothing to update

    // last row is the current user
    for (int i = 0; i < answers.length; i++) {
      csvData.last[6 + i] = answers[i]; // Q1 starts at index 6
    }

    await File(await _csvPath())
        .writeAsString(const ListToCsvConverter().convert(csvData));
  }
}
