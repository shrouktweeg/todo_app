import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/firebase_utils.dart';
import 'package:todo/core/pages_routes_name.dart';
import 'package:todo/models/provider_model.dart';
import 'package:todo/models/task_model.dart';


class TaskItemWidget extends StatelessWidget {
  final TaskModel task;
  const TaskItemWidget({super.key,required this.task});

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    var provider=Provider.of<ProviderModel>(context);
    return  Container(
      margin: const EdgeInsets.symmetric(horizontal: 15,vertical:7 ),
      decoration: BoxDecoration(
        color: provider.isDark()?Color(0XFF141922):Colors.white ,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const BehindMotion(),
          extentRatio: 0.5,
          children:  [
            SlidableAction(

              padding: EdgeInsets.zero,
              onPressed: (context){
                EasyLoading.show();
                FirebaseUtils.deleteTask(task).then((value)=>EasyLoading.dismiss());
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
            ),
            SlidableAction(
              padding: EdgeInsets.zero,
              onPressed: (context){
                EasyLoading.show();
                Navigator.pushNamed(context, PageRouteName.edit,arguments: task);
                EasyLoading.dismiss();
               // FirebaseUtils.updateTask(task).then((value)=>EasyLoading.dismiss());
              },
              backgroundColor: const Color(0XFF61E757),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),

          ],
        ),
        child: Container(
          decoration: BoxDecoration(color: provider.isDark()?Color(0XFF141922):Colors.white ),
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical:15 ),
          child: ListTile(
            leading: VerticalDivider(color: task.isDone?const Color(0Xff61E757): theme.primaryColor,thickness: 4,),
            title: Text(task.title,style: theme.textTheme.titleLarge?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color:task.isDone?const Color(0Xff61E757): theme.primaryColor,
            )),
            subtitle:
                Row(
                  children: [
                   Icon(Icons.alarm,size: 23,color:provider.isDark()?Colors.white: Colors.black,),
                    const SizedBox(width: 8,),
                    Text(DateFormat('dd MMM yy').format(task.selectedDate),style: theme.textTheme.titleLarge?.copyWith(
                      color:provider.isDark()?Colors.white: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    )),
                ],),

            trailing: task.isDone?Text('Done!',style: theme.textTheme.titleLarge?.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0Xff61E757),
            )):
             InkWell(
               onTap: (){
                 EasyLoading.show();
                 FirebaseUtils.updateIsDone(task).then((value)=>EasyLoading.dismiss());
               },
               child: Container(
                  width: 60,
                  height: 30,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child :const Icon(Icons.check_outlined,color: Colors.white,size: 28,),
               
                ),
             ),
            ),


          ),
        ),
      );
    
  }
}
