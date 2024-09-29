import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/firebase_utils.dart';
import 'package:todo/core/services/snack_bar_service.dart';
import 'package:todo/models/provider_model.dart';
import 'package:todo/models/task_model.dart';

class EditTask extends StatefulWidget {
  const EditTask({super.key});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TaskModel task = ModalRoute.of(context)!.settings.arguments as TaskModel;
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);
    var provider = Provider.of<ProviderModel>(context);
    AppLocalizations lang = AppLocalizations.of(context)!;

    return Scaffold(
        body: Stack(children: [
      Container(
        height: mediaQuery.size.height * 0.22,
        width: double.infinity,
        decoration: BoxDecoration(color: theme.primaryColor),
      ),
      Container(
        padding: const EdgeInsets.all(30),
        margin: const EdgeInsets.only(bottom: 60, top: 90, right: 20, left: 20),
        decoration: BoxDecoration(
          color: provider.isDark()?Color(0XFF141922) :Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: theme.primaryColor,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              initialValue: task.title,
              onChanged: (title) {
                setState(() {
                  task.title = title;
                },);
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(
                    color: provider.isDark()
                        ? const Color(0XFFC3C3C3)
                        : Colors.grey),
                hintText: lang.entertasktitle,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              initialValue: task.description,
              onChanged: (desc) {
                setState(() {
                  task.description = desc;
                },);
              },
              maxLines: 3,
              decoration: InputDecoration(
                hintText: lang.entertaskdescription,
                hintStyle: TextStyle(
                    color: provider.isDark()
                        ? const Color(0XFFC3C3C3)
                        : Colors.grey),
              ),
            ),
            const Spacer(),
            Center(
                child: Text(
              lang.selectdate,
              style: theme.textTheme.bodyLarge?.copyWith(
                  color: provider.isDark()
                      ? const Color(0XFFC3C3C3)
                      : Colors.black,
                  fontWeight: FontWeight.w500),
            ),),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: GestureDetector(
                  onTap: () {
                   showDatePicker(context: context,
                       initialDate:task.selectedDate,
                       lastDate: DateTime.now().add(Duration(
                           days: 365
                       )),
                       firstDate: DateTime.now(),

                   ).then((value){
                   task.selectedDate=DateUtils.dateOnly(value!);
                   });
                   setState(() {

                   });
                  },
                  child: Text(
                  task.selectedDate.toString().substring(0,10),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: provider.isDark() ? Colors.white : Colors.black,
                    ),
                  ),),
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    fixedSize: const Size(220, 40),
                  ),
                  onPressed: () {
                    FirebaseUtils.updateTask(task);
                    Navigator.pop(context);
                    SnackBarService.showSuccessMessage(
                        'Task updated Successfully !');
                  },
                  child: Text(
                    lang.update,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),),
            ),
            const Spacer(),
          ],
        ),
      ),
    ],),);
  }
}
