import 'package:flutter/material.dart';
import 'package:list_it_app/app/custom_bottom_nav_bar.dart';
import 'package:list_it_app/app/profile_page.dart';
import 'package:list_it_app/app/tab_item.dart';
import 'package:list_it_app/app/users_page.dart';
import 'package:list_it_app/models/app_user.dart';

class HomePage extends StatefulWidget {
  final AppUser appUser;

  HomePage({
    Key key,
    @required this.appUser,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.Users;

  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.Users: GlobalKey<NavigatorState>(),
    TabItem.Profile: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, Widget> allPages() {
    return {
      TabItem.Users: UsersPage(),
      TabItem.Profile: ProfilePage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: CustomBottomNavBar(
        pageBuilder: allPages(),
        navigatorKeys: navigatorKeys,
        currentTab: _currentTab,
        onSelectedTab: (selectedTab) {
          if (selectedTab == _currentTab) {
            navigatorKeys[selectedTab]
                .currentState
                .popUntil((route) => route.isFirst);
          } else {
            setState(() {
              _currentTab = selectedTab;
            });
          }

          print("Secilen tab item: " + selectedTab.toString());
        },
      ),
    );
  }
}
