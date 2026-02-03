import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:nice_game/pages/info_page.dart';
import 'package:nice_game/core/navigation.dart';
import 'package:nice_game/providers/question_provider.dart';
import 'package:nice_game/pages/select_gender_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../core/constants.dart';

class InfoProvider extends ChangeNotifier{
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController organization = TextEditingController();
  TextEditingController phone = TextEditingController();
  bool male = false;

  TextEditingController textEditingController(String key){
    if(key=='name'){
      return name;
    }else if(key=='organization'){
      return organization;
    }else if(key=='address'){
      return address;
    }
    return phone;
  }
  void rebuild(){
    notifyListeners();
  }

  void clear(){
    name.clear();
    address.clear();
    organization.clear();
    phone.clear();
  }

  void goToGenderPage(){
    clear();
    navP(SelectGenderPage());
  }

  void goToInfoPage(bool male) {
    this.male = male;
    navP(InfoPage(image: 'assets/image2.png', title: 'Enter Your Name', keyController: 'name'));
  }

  void goToNextInput(String keyController) {
    if(keyController=='name'){
      navP(InfoPage(image: 'assets/image3.png', title: 'Enter Your Address', keyController: 'address'));
    }else if(keyController=='address'){
      navP(InfoPage(image: 'assets/image4.png', title: 'Enter Your Organization', keyController: 'organization'));
    }else if(keyController=='organization'){
      navP(InfoPage(image: 'assets/image5.png', title: 'Enter Your Phone', keyController: 'phone'));
    }else{
      startGame();
    }
  }
  Future<List<List<dynamic>>?> readCsvFile() async {
    // Get the directory where the CSV file is saved


    // Read the file
    try{
      String filePath = await path();
      final file = File(filePath);
      bool check = await file.exists();
      if(check){
        print('asd');
        final csvData = await file.readAsString();

        // Parse the CSV data
        List<List<dynamic>> rows = const CsvToListConverter().convert(csvData);

        return rows;
      }else{
        print('asd2');
      }
    }catch(e){

    }

    return null;
  }
  Future<String> path()async{
    final directory = await getApplicationDocumentsDirectory();
    final path2 = '${directory.path}\\data.csv';
    print(path2);
    return path2;
  }
  void createCVS()async{
    List<List<dynamic>>? data = await readCsvFile();
    data??=[["Name",'Gender','Address','Phone','Organization']];
    String nameData = name.text;
    while(nameData.endsWith('\n')){
      nameData = nameData.substring(0,nameData.length - 1);
    }
    String addressData = address.text;
    while(addressData.endsWith('\n')){
      addressData = addressData.substring(0,addressData.length - 1);
    }
    String organizationData = organization.text;
    while(organizationData.endsWith('\n')){
      organizationData = organizationData.substring(0,organizationData.length - 1);
    }
    data.add([nameData,male?"Male":"Female",addressData,phone.text,organizationData]);
    String csvData = const ListToCsvConverter().convert(data);
    String filePath = await path();
    File(filePath).writeAsString(csvData);
  }

  void startGame(){
    createCVS();
    Provider.of<QuestionProvider>(Constants.globalContext(),listen: false).goToQuestionPage();
  }

}