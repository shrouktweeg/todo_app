import 'package:flutter/material.dart';

class ProviderModel extends ChangeNotifier{
  String currentLanguage='en';
  ThemeMode currentTheme=ThemeMode.light;

  changeLanguage(String newLanguage){
    if(currentLanguage==newLanguage) return;
    currentLanguage=newLanguage;
    notifyListeners();
  }
  changeTheme(ThemeMode newTheme){
    if(currentTheme==newTheme) return;
    currentTheme=newTheme;
    notifyListeners();
  }
  bool isDark()=>currentTheme==ThemeMode.dark;


}