
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/provider_model.dart';


import '../../core/pages_routes_name.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}
class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2),
        (){
      Navigator.pushReplacementNamed(context,PageRouteName.login);
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<ProviderModel>(context);
    return Container(
      decoration:  BoxDecoration(
        image: DecorationImage(image:provider.isDark()?const AssetImage('assets/images/splash – 1.png'): const AssetImage('assets/images/splash_background.png'),fit: BoxFit.cover)
      ),
    ) ;
  }
}
