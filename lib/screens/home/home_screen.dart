import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/my_theme.dart';
import 'package:todo/screens/settings/settings_tab.dart';
import 'package:todo/screens/tasks/Add_task_bottom_sheet.dart';
import 'package:todo/screens/tasks/task_list.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home screen";
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  List<Widget> tabs = [TaskList(), SettingsTab()];

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(local.app_title)),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: '',
              )
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddBottomSheet();
        },
        child: Icon(
          Icons.add,
          size: 35,
          color:MyTheme.whiteColor,
        ),
      ),
      body: tabs[selectedIndex],
    );
  }
  void showAddBottomSheet(){
    showModalBottomSheet(context: context, builder: (context)=>AddTaskBottomSheet());
  }
}
