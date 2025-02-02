import 'package:dunkingclub/feature/courts/screens/info_fields_screen.dart';
import 'package:dunkingclub/feature/game_planning/screens/gameplan_screen.dart';
import 'package:dunkingclub/feature/info_general/info_general.dart';
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
    const InfoGeneralScreen(),
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
      backgroundColor: const Color.fromARGB(251, 86, 167, 205),
      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(
          indicatorColor: Color.fromARGB(255, 234, 211, 161),
        ),
        child: NavigationBar(
          backgroundColor: const Color.fromARGB(255, 238, 240, 245),
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          destinations: const <NavigationDestination>[
            //__________________________________________________ Homfe

            NavigationDestination(
              icon: SizedBox(
                  width: 64,
                  height: 64,
                  child:
                      Image(image: AssetImage("assets/icons/icon_home.png"))),
              selectedIcon: SizedBox(
                  width: 128,
                  height: 128,
                  child:
                      Image(image: AssetImage("assets/icons/icon_home.png"))),
              label: 'Home',
            ),
            //__________________________________________________ Players

            NavigationDestination(
              icon: SizedBox(
                  width: 64,
                  height: 64,
                  child: Image(
                      image: AssetImage("assets/icons/icon_players.png"))),
              selectedIcon: SizedBox(
                  width: 128,
                  height: 128,
                  child: Image(
                      image: AssetImage("assets/icons/icon_players.png"))),
              label: 'Spieler',
            ),
            //__________________________________________________ Courts

            NavigationDestination(
              icon: SizedBox(
                  width: 64,
                  height: 64,
                  child:
                      Image(image: AssetImage("assets/icons/icon_court.png"))),
              selectedIcon: SizedBox(
                  width: 128,
                  height: 128,
                  child:
                      Image(image: AssetImage("assets/icons/icon_court.png"))),
              label: 'Spielfelder',
            ),
            //__________________________________________________ Spielplanug

            NavigationDestination(
              icon: SizedBox(
                  width: 64,
                  height: 64,
                  child: Image(
                      image: AssetImage("assets/icons/icon_gameplan.png"))),
              selectedIcon: SizedBox(
                  width: 128,
                  height: 128,
                  child: Image(
                      image: AssetImage("assets/icons/icon_gameplan.png"))),
              label: 'Spielplanung',
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
