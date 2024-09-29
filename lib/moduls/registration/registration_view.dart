import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/core/firebase_utils.dart';
import 'package:todo/core/services/snack_bar_service.dart';



class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
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
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          title:  Text(lag.createaccount),
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
                  TextFormField(
                    cursorColor: theme.primaryColor,
                    style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                      decoration: InputDecoration(

                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: theme.primaryColor,
                            width: 2, ),
                        ),
                        hintText: 'Enter your Full Name',
                        label:Text(lag.fullname,style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),),
                        suffixIcon: const Icon(Icons.person),
                      )
                  ),
                  const SizedBox(height: 10,),
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
                  const  SizedBox(height: 40,),
                  FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 12),
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        )
                    ),
                      onPressed: () {
                        // print(emailController.text);
                        if (formKey.currentState!.validate()) {
                          FirebaseUtils.createAccount(textController.text,
                              passController.text)
                              .then((value) {
                            SnackBarService.showSuccessMessage(
                                "Account successfully Created");
                            Navigator.pop(context);
                          });
                        }
                      }
                   , child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(lag.createaccount,style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white,fontSize: 19),),
                      const Icon(Icons.arrow_forward)
                    ],),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

