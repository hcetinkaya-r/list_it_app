import 'package:flutter/material.dart';
import 'package:list_it_app/app/app_pages/assistant_page.dart';
import 'package:list_it_app/app/custom_bottom_nav_bar.dart';
import 'package:list_it_app/app/app_pages/profile_page.dart';
import 'package:list_it_app/app/tab_item.dart';
import 'package:list_it_app/app/listit_page.dart';
import 'package:list_it_app/models/app_user.dart';

class AppHomePage extends StatefulWidget {
  final AppUser appUser;

  AppHomePage({
    Key key,
    @required this.appUser,
  }) : super(key: key);

  @override
  _AppHomePageState createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  TabItem _currentTab = TabItem.ListIt;

  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.ListIt: GlobalKey<NavigatorState>(),
    TabItem.Profile: GlobalKey<NavigatorState>(),
    TabItem.Assistant: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, Widget> allPages() {
    return {
      TabItem.Assistant : AssistantPage(),
      TabItem.ListIt: ListItPage(),
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
