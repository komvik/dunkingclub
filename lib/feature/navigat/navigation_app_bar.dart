import 'package:dunkingclub/feature/chat/screens/chat_screen.dart';
import 'package:dunkingclub/feature/registr/screen/auth_screen.dart';
import 'package:flutter/material.dart';

class NavigationAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NavigationAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        //___________________________________________________CHAT
        IconButton(
          icon: Image.asset(
            'assets/icons/icon_groupchat.png',
            width: 44,
            height: 44,
            fit: BoxFit.cover,
          ),
          tooltip: 'Go to the next page',
          onPressed: () {
            Navigator.push(context, MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return const ChatScreen();
              },
            ));
          },
        ),
        //_____________________________________________ ONLINE
        Expanded(
          flex: 3,
          child: IconButton(
            icon: Image.asset(
              'assets/icons/icon_player_online.png',
              width: 44,
              height: 44,
              fit: BoxFit.cover,
            ),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  margin: EdgeInsets.only(
                    left: 120.0,
                    right: 120.0,
                    bottom:
                        600.0, // Задает отступ от нижнего края (например, высота BottomNavigationBar)
                  ),
                  content: Text('   10 Spieler online')));
            },
          ),
        ),
        //______________________________________________ EXIT
        IconButton(
          icon: Image.asset(
            'assets/icons/icon_exit.png',
            width: 44,
            height: 44,
            fit: BoxFit.cover,
          ),
          tooltip: 'Show Snackbar',
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AuthScreen()));
          },
        ),
        //
      ],
    );
  }
}
