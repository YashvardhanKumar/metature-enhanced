import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/bottom_navigation.dart';
import 'bottom navigation routes/Feed.dart';
import 'bottom navigation routes/Notification.dart';
import 'bottom navigation routes/Settings.dart';
import 'bottom navigation routes/UserProfile.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CurIndex>(
      create: (_) => CurIndex(),
      builder: (_, child) {
        CurIndex index = Provider.of<CurIndex>(_);
        return Scaffold(
          bottomNavigationBar: BottomNavigation(),
          body: [
            const FeedPage(),
            const NotificationPage(),
            const ProfilePage(),
            const SettingsPage()
          ][index.curIndex],
        );
      },
    );
  }
}

class CurIndex extends ChangeNotifier {
  int curIndex = 0;
  void changeTo(int i) {
    curIndex = i;
    notifyListeners();
  }
}
