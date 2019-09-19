import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:lwp/Model/WordModel.dart';


Future<String> _loadAsset() async {
  return await rootBundle.loadString('data/words.json');
}

// Future loadStudent() async {
//   String jsonString = await _loadAStudentAsset();
//   final jsonResponse = json.decode(jsonString);
//   WordModel word = new WordModel.fromMap(jsonResponse);
//   print(word.latter);
// }


Future<List<WordModel>> loadWordModel() async {
  List<WordModel> list;
String jsonString = await _loadAsset();
  final jsonResponse = json.decode(jsonString);

        var rest = jsonResponse as List;
        // print(rest);
        list = rest.map<WordModel>((json) => WordModel.fromMap(json)).toList();
//        print(list);
        return list;
}
