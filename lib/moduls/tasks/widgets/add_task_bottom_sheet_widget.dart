import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/core/firebase_utils.dart';
import 'package:todo/core/services/snack_bar_service.dart';
import 'package:todo/models/provider_model.dart';
import 'package:todo/models/task_model.dart';

class AddTaskBottomSheetWidget extends StatefulWidget {
  const AddTaskBottomSheetWidget({super.key});

  @override
  State<AddTaskBottomSheetWidget> createState() => _AddTaskBottomSheetWidgetState();
}

class _AddTaskBottomSheetWidgetState extends State<AddTaskBottomSheetWidget> {
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  DateTime selectedDate=DateTime.now();
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppLocalizations lag=AppLocalizations.of(context)!;
    var theme=Theme.of(context);
    var provider=Provider.of<ProviderModel>(context);
    return Container(
      padding: const EdgeInsets.only(top: 20,bottom: 20,left: 30,right: 30),
      decoration: BoxDecoration(
        color:provider.isDark()?Color(0XFF141922): Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(lag.addnewtask,textAlign: TextAlign.center,style: theme.textTheme.bodyLarge?.copyWith(fontSize: 18,fontWeight: FontWeight.w600,color:provider.isDark()?Colors.white: Colors.black),),
            const SizedBox(height: 30,),
            TextFormField(
              controller:titleController ,
              decoration:  InputDecoration(
                hintStyle: TextStyle(color: provider.isDark()?Color(0XFFC3C3C3):Colors.grey),
                hintText: lag.entertasktitle,
              ),
              validator: (value){
                if(value==null || value.trim().isEmpty){
                  return ' Please , Enter task title ';
                }
                  return null;
              },
            ),
            const SizedBox(height: 15,),
            TextFormField(
              controller: descriptionController,
              maxLines: 3,
              decoration:  InputDecoration(
                hintText: lag.entertaskdescription,
                hintStyle: TextStyle(color: provider.isDark()?Color(0XFFC3C3C3):Colors.grey),
              ),
              validator: (value){
                if(value==null || value.trim().isEmpty){
                  return ' Please , Enter task description ';
                }
                return null;
              },
            ),
           const SizedBox(height: 10,),
           Text(lag.selectdate,style: theme.textTheme.bodyLarge?.copyWith(color:provider.isDark()?Color(0XFFC3C3C3):Colors.black,fontWeight: FontWeight.w500),),
           const SizedBox(height: 10,),
           InkWell(onTap: (){
             getCalenderDate();
           },child: Text(DateFormat('dd MMM yy').format(selectedDate),textAlign:TextAlign.center,style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500,color:provider.isDark()?Colors.white: Colors.black,),)),
            const Spacer(),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: theme.primaryColor,shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),),
                onPressed: (){
                if(formKey.currentState!.validate()) {
                  var taskModel = TaskModel(title: titleController.text,
                      description: descriptionController.text,
                      selectedDate: selectedDate);

                  EasyLoading.show();
                  FirebaseUtils.addTaskForFireStore(taskModel).then((value) {
                    Navigator.pop(context);
                    EasyLoading.dismiss();
                    SnackBarService.showSuccessMessage(
                        'Task Successfully added!');
                  }
                  );
                }
                },
                 child: Text(lag.save,style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),))
          ],
        ),
      ),

    );
  }
  getCalenderDate()async{
   var currentDate=await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365,)
     ,)
     ,);
   if(currentDate!=null){
     setState(() {
       selectedDate=currentDate;
     });

   }
  }

}
