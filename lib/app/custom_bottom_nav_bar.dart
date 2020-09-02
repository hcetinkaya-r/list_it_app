import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_it_app/app/tab_item.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar(
      {Key key,
      @required this.currentTab,
      @required this.onSelectedTab,
      @required this.pageBuilder,
      @required this.navigatorKeys})
      : super(key: key);

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectedTab;
  final Map<TabItem, Widget> pageBuilder;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(

      tabBar: CupertinoTabBar(
        iconSize: 40,
        border: Border(top: BorderSide(color: Theme.of(context).primaryColor),),

        backgroundColor: Colors.white,
        activeColor: Theme.of(context).primaryColor,
        items: [
          _createNavItem(TabItem.Assistant),
          _createNavItem(TabItem.ListIt),
          _createNavItem(TabItem.Profile),





        ],
        onTap: (index) => onSelectedTab(TabItem.values[index]),
      ),
      tabBuilder: (context, index) {
        final showItem = TabItem.values[index];
        return CupertinoTabView(
            navigatorKey: navigatorKeys[showItem],
            builder: (context) => pageBuilder[showItem]);
      },
    );
  }

  BottomNavigationBarItem _createNavItem(TabItem tabItem) {
    final tabToCreate = TabItemData.allTabs[tabItem];
    return BottomNavigationBarItem(
      icon: Icon(tabToCreate.icon),
      title: Text(tabToCreate.title),
    );
  }
}
