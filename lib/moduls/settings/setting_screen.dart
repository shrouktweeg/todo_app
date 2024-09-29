import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/provider_model.dart';


class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});
  final List<String> _languages = const [
    'English',
    'عربى',
  ];
  final List<String> _mode = const [
    'Light',
    'Dark',
  ];

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<ProviderModel>(context);
    var mediaQuery=MediaQuery.of(context);
    var theme=Theme.of(context);
    AppLocalizations lang=AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: mediaQuery.size.height*0.22,
          width: double.infinity,
          decoration: BoxDecoration(
            color: theme.primaryColor
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 48),
            child: Text(lang.settings,style: theme.textTheme.titleLarge?.copyWith(color:provider.isDark()? Color(0XFF060E1E): Colors.white)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27,vertical: 25),
          child: Text(lang.language,style: theme.textTheme.displaySmall!.copyWith(
            fontWeight: FontWeight.w700,color:provider.isDark()?Colors.white: Color(0xff303030),fontSize: 18,
          ),),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 18.0,left: 10,right: 10),
          child: CustomDropdown(
              decoration:CustomDropdownDecoration(
            closedFillColor: provider.isDark()?Color(0XFF060E1E): Colors.white,
            closedSuffixIcon: Icon(Icons.arrow_drop_down_outlined,color: theme.primaryColor,),
            expandedSuffixIcon: Icon(Icons.arrow_drop_up_outlined,color: theme.primaryColor,),
            expandedFillColor:provider.isDark()?Color(0XFF060E1E): Colors.white,
          ) ,
              initialItem: provider.currentLanguage=='en'?_languages[0]:_languages[1],
              items: _languages, onChanged: (value){
            if(value=='English') {
              provider.changeLanguage('en');
            }
            if(value=='عربى') {
              provider.changeLanguage('ar');
            }
              }
              ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27,vertical: 25),
          child: Text(lang.mode,style: theme.textTheme.displaySmall!.copyWith(
            fontWeight: FontWeight.w700,color:provider.isDark()?Colors.white: Color(0xff303030),fontSize: 18,
          ),),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 18.0,left: 10,right: 10),
          child: CustomDropdown(decoration:CustomDropdownDecoration(
              closedFillColor: provider.isDark()?Color(0XFF060E1E): Colors.white,
              closedSuffixIcon: Icon(Icons.arrow_drop_down_outlined,color: theme.primaryColor,),
              expandedSuffixIcon: Icon(Icons.arrow_drop_up_outlined,color: theme.primaryColor,),
              expandedFillColor:provider.isDark()?Color(0XFF060E1E): Colors.white,
          ) ,
              initialItem:provider.isDark()?_mode[1]: _mode[0],
              items: _mode, onChanged: (value){
                if(value=="Dark") {
                  provider.changeTheme(ThemeMode.dark);
                }
                if(value=="Light") {
                  provider.changeTheme(ThemeMode.light);
                }

              }),
        )
      ],
    );
  }
}
