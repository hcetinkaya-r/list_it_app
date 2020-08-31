import 'package:flutter/material.dart';

enum TabItem{Users, Profile, Assistant}

class TabItemData {
  final String title;
  final IconData icon;


  TabItemData(this.title, this.icon);

  static Map<TabItem, TabItemData> allTabs = {
    TabItem.Users : TabItemData("Users", Icons.supervised_user_circle),

    TabItem.Profile : TabItemData("Profile", Icons.person),
    TabItem.Assistant : TabItemData("Assistant", Icons.assistant),


  };
}