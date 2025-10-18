// ignore_for_file: constant_identifier_names

import 'package:flutter/widgets.dart';

enum LanguageType{
  ENGLISH,
ARABIC }

const String ARABIC="ar";
const String ENGLISH="en";
const String ASSET_PATH_LOCALISATION="assets/lang";

const Locale ARABIC_LOCALE=Locale("ar");
const Locale ENGLISH_LOCALE=Locale("en");
extension LanguageTypeExtension on LanguageType{
  String getValue(){
switch(this) {
  case LanguageType.ENGLISH:
  return ENGLISH;
  case LanguageType.ARABIC:
    return ARABIC;
}
}
}

String convertArabicNumberToEnglish(String input) {
  const arabicNumbers = ['٠','١','٢','٣','٤','٥','٦','٧','٨','٩'];
  const englishNumbers = ['0','1','2','3','4','5','6','7','8','9'];

  for (int i = 0; i < arabicNumbers.length; i++) {
    input = input.replaceAll(arabicNumbers[i], englishNumbers[i]);
  }
  return input;
}

void main() {
  String value = "٢";
  int number = int.parse(convertArabicNumberToEnglish(value));
  print(number); // 2
}
