
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'core/application_theme_manager.dart';
import 'core/pages_routes_name.dart';
import 'core/routes_generator.dart';
import 'core/services/loading_service.dart';
import 'firebase_options.dart';
import 'models/provider_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

main()async{
  // to make sure every await task is done
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context)=>ProviderModel(),
      child:const MyApp()
    )
      );
  configLoading(); // to create singleton easy loading
}
class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<ProviderModel>(context);
    return MaterialApp(
      locale: Locale(provider.currentLanguage),
      darkTheme: ApplicationThemeManager.darkThemeMode,
      themeMode: provider.currentTheme,
      localizationsDelegates:AppLocalizations.localizationsDelegates,
      supportedLocales:AppLocalizations.supportedLocales,
      title: 'To Do ',
      theme: ApplicationThemeManager.lightThemeMode,
      debugShowCheckedModeBanner: false,
      initialRoute: PageRouteName.initialRoute,
      onGenerateRoute:RoutesGenerator.onGenerateRoute,
      builder: EasyLoading.init(
        builder: BotToastInit(),
      ),
    );
  }
}
