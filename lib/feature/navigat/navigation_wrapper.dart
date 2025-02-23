import 'package:dunkingclub/feature/courts/screens/info_fields_screen.dart';
import 'package:dunkingclub/feature/game_planning/screens/gameplan_screen.dart';
import 'package:dunkingclub/feature/review/review.dart';
import 'package:dunkingclub/feature/navigat/navigation_app_bar.dart';
import 'package:dunkingclub/feature/players/screens/info_players_screen.dart';
import 'package:flutter/material.dart';

class NavigationWrapper extends StatefulWidget {
  const NavigationWrapper({super.key});

  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  int _selectedIndex = 0;

  // InfoGeneralScreen -> screens[_selectedIndex] -> InfoGeneralScreen -> screens[_selectedIndex] ->

  final List<Widget> screens = [
    const ReviewScreen(),
    const InfoPlayersScreen(),
    const InfoFieldsScreen(),
    const GamePlanningScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///

      appBar: const NavigationAppBar(),
      backgroundColor: const Color.fromARGB(255, 46, 46, 46),
      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(
          indicatorColor: Color.fromARGB(255, 46, 46, 46),
        ),
        child: NavigationBar(
          backgroundColor: const Color.fromARGB(255, 46, 46, 46),
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          destinations: const <NavigationDestination>[
            //__________________________________________________ Review

            NavigationDestination(
              icon: SizedBox(
                  width: 64,
                  height: 64,
                  child:
                      Image(image: AssetImage("assets/icons/icon_review.png"))),
              selectedIcon: SizedBox(
                  width: 72,
                  height: 72,
                  child:
                      Image(image: AssetImage("assets/icons/icon_review.png"))),
              label: '',
            ),
            //__________________________________________________ Players

            NavigationDestination(
              icon: SizedBox(
                  width: 64,
                  height: 64,
                  child:
                      Image(image: AssetImage("assets/icons/icon_game.png"))),
              selectedIcon: SizedBox(
                  width: 72,
                  height: 72,
                  child:
                      Image(image: AssetImage("assets/icons/icon_game.png"))),
              label: '',
            ),
            //__________________________________________________ Courts

            NavigationDestination(
              icon: SizedBox(
                  width: 64,
                  height: 64,
                  child:
                      Image(image: AssetImage("assets/icons/icon_courts.png"))),
              selectedIcon: SizedBox(
                  width: 72,
                  height: 72,
                  child:
                      Image(image: AssetImage("assets/icons/icon_courts.png"))),
              label: '',
            ),
            //__________________________________________________ Spielplanug

            NavigationDestination(
              icon: SizedBox(
                  width: 64,
                  height: 64,
                  child: Image(
                      image: AssetImage("assets/icons/icon_settings.png"))),
              selectedIcon: SizedBox(
                  width: 72,
                  height: 72,
                  child: Image(
                      image: AssetImage("assets/icons/icon_settings.png"))),
              label: '',
            ),
          ],
        ),
      ),
      body: Center(
        child: screens[_selectedIndex],
      ),
    );
  }
}
