import 'package:flutter/material.dart';

enum TabItem{Assistant, ListIt, Profile }

class TabItemData {
  final String title;
  final IconData icon;


  TabItemData(this.title, this.icon);

  static Map<TabItem, TabItemData> allTabs = {
    TabItem.Assistant : TabItemData("Assistant", Icons.assistant),
    TabItem.ListIt : TabItemData("List-it", Icons.list),
    TabItem.Profile : TabItemData("Profile", Icons.person),




  };
}