import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/core/firebase_utils.dart';
import 'package:todo/models/provider_model.dart';
import 'package:todo/models/task_model.dart';

import 'widgets/task_item_widget.dart';


class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {

  var _focusDate=DateTime.now();
  final EasyInfiniteDateTimelineController  identifierController=EasyInfiniteDateTimelineController();
  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    var mediaQuery=MediaQuery.of(context);
    var provider=Provider.of<ProviderModel>(context);
    AppLocalizations lang=AppLocalizations.of(context)!;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: mediaQuery.size.height*0.22,
                width:mediaQuery.size.width,
                color: theme.primaryColor,

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 48),
                  child: Text(lang.title,style: theme.textTheme.bodyLarge?.copyWith(color:provider.isDark()? Color(0XFF060E1E): Colors.white,fontSize: 22,fontWeight: FontWeight.w700),),
                ),
              ),
              Positioned(
                top: 115,
                child: SizedBox(
                  width: mediaQuery.size.width,
                  child: EasyInfiniteDateTimeLine(

                      dayProps: EasyDayProps(
                        // borderColor: provider.isDark()?theme.primaryColorDark:theme.primaryColor,
                        activeDayStyle: DayStyle(

                          decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(12),
                            color:provider.isDark()?Color(0XFF141922):theme.primaryColor,
                          ),
                          monthStrStyle: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700,fontSize: 18,color: provider.isDark()?Colors.white:Colors.black),
                          dayStrStyle: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700,fontSize: 18,color: provider.isDark()?Colors.white:Colors.black),
                          dayNumStyle: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700,fontSize: 18,color: provider.isDark()?Colors.white:Colors.black),
                        ),
                        inactiveDayStyle: DayStyle(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color:provider.isDark()?Color(0XFF141922): Colors.white.withOpacity(0.8),
                          ),
                          monthStrStyle: theme.textTheme.bodyMedium?.copyWith(fontSize: 18,fontWeight: FontWeight.w700,color: provider.isDark()?Colors.white70:Color(0XFF363636),),
                          dayStrStyle: theme.textTheme.bodyMedium?.copyWith(fontSize: 18,fontWeight: FontWeight.w700,color: provider.isDark()?Colors.white70:Color(0XFF363636),),
                          dayNumStyle: theme.textTheme.bodyMedium?.copyWith(fontSize: 18,fontWeight: FontWeight.w700,color: provider.isDark()?Colors.white70:Color(0XFF363636),),
                        ),
                        todayStyle: DayStyle(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white.withOpacity(0.8),
                          ),
                          monthStrStyle: theme.textTheme.bodyMedium?.copyWith(fontSize: 18,fontWeight: FontWeight.w700,color: const Color(0XFF363636),),
                          dayStrStyle: theme.textTheme.bodyMedium?.copyWith(fontSize: 18,fontWeight: FontWeight.w700,color: const Color(0XFF363636),),
                          dayNumStyle: theme.textTheme.bodyMedium?.copyWith(fontSize: 18,fontWeight: FontWeight.w700,color: const Color(0XFF363636),),
                        ),
                      ),
                      timeLineProps: const EasyTimeLineProps(
                        separatorPadding: 12,
                      ),
                      onDateChange: (selectedDate){
                        setState(() {
                          _focusDate = selectedDate;
                        });
                      },
                      controller: identifierController,
                      showTimelineHeader: false,
                      firstDate: DateTime(2024), focusDate: _focusDate, lastDate: DateTime.now().add(const Duration(days: 365))),
                ),
              )
            ],
          ),
        ),

        Expanded(
          child: StreamBuilder <QuerySnapshot<TaskModel>>(
              stream: FirebaseUtils.getOneTimeReadFromFireStore(_focusDate), builder: (context,snapShot){
            print(snapShot.error);
            if(snapShot.hasError){
              return  Text(snapShot.error.toString()) ;
            }
            else if (snapShot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(
                color: theme.primaryColor,
              ));

            }
            List<TaskModel>taskList= snapShot.data?.docs.map((e)=>e.data()).toList()??[];
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: taskList.length,
              itemBuilder: (context,index)=>TaskItemWidget(task: taskList[index],),);

          }),
        ),

      ],
    );
  }
}
