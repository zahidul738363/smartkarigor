import 'package:flutter/material.dart';

class AppDataProvider with ChangeNotifier {
  // Study Section Data
  List<String> _studyItems = [
    'Vocational 9',
    'Vocational 10',
    'Vocational 11',
    'Vocational 12',
  ];

  // Extra Section Data
  List<String> _extraItems = [
    'IELTS',
    'Language Practice',
  ];

  // Exam Section Data
  List<String> _examItems = [
    'SAE MCQ Exam',
    'AE MCQ Exam',
  ];

  // Getters
  List<String> get studyItems => _studyItems;
  List<String> get extraItems => _extraItems;
  List<String> get examItems => _examItems;

  // Setters
  void updateStudyItems(List<String> newItems) {
    _studyItems = newItems;
    notifyListeners();
  }

  void updateExtraItems(List<String> newItems) {
    _extraItems = newItems;
    notifyListeners();
  }

  void updateExamItems(List<String> newItems) {
    _examItems = newItems;
    notifyListeners();
  }

  void addStudyItem(String item) {
    _studyItems.add(item);
    notifyListeners();
  }

  void addExtraItem(String item) {
    _extraItems.add(item);
    notifyListeners();
  }

  void addExamItem(String item) {
    _examItems.add(item);
    notifyListeners();
  }

  void removeStudyItem(int index) {
    _studyItems.removeAt(index);
    notifyListeners();
  }

  void removeExtraItem(int index) {
    _extraItems.removeAt(index);
    notifyListeners();
  }

  void removeExamItem(int index) {
    _examItems.removeAt(index);
    notifyListeners();
  }
}