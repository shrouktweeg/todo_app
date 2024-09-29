
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo/core/firebase_utils.dart';
import 'package:todo/core/pages_routes_name.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var formKey=GlobalKey<FormState>();
  TextEditingController textController=TextEditingController();
  TextEditingController passController=TextEditingController();
  bool isNotVisible=true;
  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    var media=MediaQuery.of(context);
    AppLocalizations lag=AppLocalizations.of(context)!;


    return  Container(
      decoration: const BoxDecoration(
        color: Color(0XFFDFECDB),
        image: DecorationImage(image: AssetImage('assets/images/background.png'),fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
            title:  Text(lag.login),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: media.size.height*0.2,),
                  Text(lag.welcomeback,style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.black
                  ),),
                  const SizedBox(height: 20,),
                  TextFormField(
                    cursorColor: theme.primaryColor,
                   style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                    validator: (val){
                      if(val==null || val.trim().isEmpty){
                        return 'Please , Enter email';
                      }
                   else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val)) {
                      return 'invalid email';
                    }
                     return null;
                    },
                    decoration: InputDecoration(

                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: theme.primaryColor,
                        width: 2, ),
                      ),
                      hintText: 'Enter your Email',
                      label:Text(lag.email,style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),),
                      suffixIcon: const Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    obscureText: isNotVisible,
                    cursorColor: theme.primaryColor,
                    style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: theme.primaryColor,
                          width: 2, ),
                      ),
                      hintText: 'Enter your Password',
                      label:Text(lag.password,style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),),
                      suffixIcon:  IconButton(onPressed: (){
                        setState(() {
                          isNotVisible=!isNotVisible;
                        });
                      }, icon: isNotVisible?const Icon(Icons.visibility_off):const Icon(Icons.visibility)
                      ),
                    ),
                  ),
                 const SizedBox(height: 2,),
                 TextButton(onPressed: (){}, child: Text(lag.forgotpassword,style: theme.textTheme.displaySmall?.copyWith(decoration: TextDecoration.underline,fontWeight: FontWeight.w700),),
                 ),
                 const  SizedBox(height: 22,),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 12),
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      )
                    ),
                      onPressed: () {

                        if (formKey.currentState!.validate()) {
                          FirebaseUtils.signIn(textController.text,
                              passController.text)
                              .then((value) {
                            Navigator.pushReplacementNamed(
                                context, PageRouteName.layout);
                          });
                        }
                      }, child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text(lag.login,style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white,fontSize: 19),),
                    const Icon(Icons.arrow_forward)
                  ],),),
                  const SizedBox(height: 20,),
                  TextButton(onPressed: (){
                    Navigator.pushNamed(context, PageRouteName.registration);
                  }, child: Text(lag.orcreatemyaccount,style: theme.textTheme.displaySmall?.copyWith(decoration: TextDecoration.underline,fontWeight: FontWeight.w700,),),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
