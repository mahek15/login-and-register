// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_register/models/user_model.dart';
import 'package:login_register/screens/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        centerTitle: true),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 150,
                  child: Image.asset("assets/logo.png", fit: BoxFit.contain),
                ),
                Text(
                  "Welcome Back",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${loggedInUser.firstName} ${loggedInUser.lastName}",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.w500,
                    ),
                ),
                Text(
                  "${loggedInUser.email}",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.w500,
                    ),
                ),
                SizedBox(
                  height: 15,
                ),
                ActionChip(label: Text("Logout"),
                onPressed: () {
                    logout(context);                
                },)
              ],
            ),
            )
          ),
    );
  }
  Future<void> logout(BuildContext context) async {

    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
