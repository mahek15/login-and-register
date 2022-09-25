import 'package:login_register/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}
// void main () => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'login_register',
      theme: ThemeData(
        primarySwatch: Colors.yellow
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}