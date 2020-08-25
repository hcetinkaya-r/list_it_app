import 'package:flutter/material.dart';
import 'package:list_it_app/landing_page.dart';
import 'package:list_it_app/locator.dart';
import 'package:list_it_app/view_models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "List-it App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Color(0xFFA30003),
        accentColor: Color(0xFFA30003),
        focusColor: Color(0xFFA30003),
        fontFamily: 'Futura',
      ),
      home: ChangeNotifierProvider(
        create: (context)=>UserModel(),
        child: LandingPage(),
      ),
    );
  }
}

