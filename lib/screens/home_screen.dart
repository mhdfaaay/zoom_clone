import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/screens/history_meeting_screen.dart';
import 'package:zoom_clone/screens/meeting_screen.dart';
import 'package:zoom_clone/utils/colors.dart';
import 'package:zoom_clone/widgets/custom_button.dart';
import 'package:zoom_clone/widgets/home_button.dart';
//import 'package:zoom_clone/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _page = 0;
  onPageChanged(int page){
   setState(() {
     _page = page;
   });
  }
 
  List<Widget> pages = [
    MeetingScreen(),
    HistoryMeetingScreen(),
    CustomButton(text: 'Log Out', onPressed: () => AuthMethods().signOut(),),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
    ),
     body: pages[_page],
     bottomNavigationBar: BottomNavigationBar(
      backgroundColor: footerColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      onTap: onPageChanged,
      currentIndex: _page,
      type: BottomNavigationBarType.fixed,
      unselectedFontSize: 14,
      items: [
          BottomNavigationBarItem(
          icon: Icon(Icons.comment_bank),
          label:'Meet & Chat'),
         
          BottomNavigationBarItem(
          icon: Icon(Icons.lock_clock),
          label:'Meetings'),

          BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label:'Settings'),

        ]),
    );
  }
}

