import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/provider_model.dart';
import 'settings/setting_screen.dart';
import 'tasks/tasks_screen.dart';
import 'tasks/widgets/add_task_bottom_sheet_widget.dart';



class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  List<Widget>screensList=const[
    TasksScreen(),
    SettingScreen(),
  ];

  int currentIndex=0;


  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    var mediaQuery=MediaQuery.of(context);
    var provider=Provider.of<ProviderModel>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
       backgroundColor:Colors.white,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(40),
       ),
       elevation: 2,
          onPressed: (){
         showModalBottomSheet(context: context, builder: (context)=>const AddTaskBottomSheetWidget());
          },
          child: CircleAvatar(
            backgroundColor: theme.primaryColor,
            radius: 30,
            child: const Icon(Icons.add,color: Colors.white,size: 30,),
          ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: provider.isDark()?Color(0XFF141922):Colors.white,
        shape: const CircularNotchedRectangle(),
        height: 90,
        padding: EdgeInsets.zero,
        notchMargin: 12,
        child: BottomNavigationBar(
          unselectedItemColor:provider.isDark()?Colors.white:Color(0XFFC8C9CB),
          backgroundColor: Colors.transparent,
          elevation: 0,
          onTap: (value){
            setState(() {
              currentIndex=value;
            });
          },
          currentIndex: currentIndex,
            items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/tasks_icn.png'),
            ),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/Icon feather-settings.png'),
            ),
            label: 'Settings',
          ),
        ]),
      ),
      body:screensList[currentIndex],
    );
  }
}
/*
Expanded(
  child: FutureBuilder<List<TaskModel>>(future: FirebaseUtils.getOneTimeReadFromFireStore(_focusDate), builder: (context,snapShot){
    print(snapShot.error);
    if(snapShot.hasError){
      return  Text(snapShot.error.toString()) ;
    }
    else if (snapShot.connectionState==ConnectionState.waiting){
      return Center(child: CircularProgressIndicator(
      color: theme.primaryColor,
      ));

      }
    List<TaskModel>taskList= snapShot.data??[];
      return ListView.builder(
        padding: EdgeInsets.zero,
          itemCount: taskList.length,
          itemBuilder: (context,index)=>TaskItemWidget(task: taskList[index],),);

  }),
),

 */