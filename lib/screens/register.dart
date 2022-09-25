// ignore_for_file: prefer_const_constructors, unnecessary_new, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_register/models/user_model.dart';
import 'package:login_register/screens/home.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _auth = FirebaseAuth.instance;

  //form key
  final _formKey = GlobalKey<FormState>();

  //editing controller
  final firstNameEditingController= new TextEditingController();
  final lastNameEditingController= new TextEditingController();
  final emailEditingController= new TextEditingController();
  final passwordEditingController= new TextEditingController();
  final confirmPasswordEditingController= new TextEditingController();

  @override
  Widget build(BuildContext context) {

    //first name field
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("First name cannot be empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Your Name(min 3 letters)");
          }
          return null;
      },
      onSaved: (value)
      {
          firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "First Name",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
      ),
    );
    //end of first name field

    //last name field
    final lastNameField = TextFormField(
      autofocus: false,
      controller: lastNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("First Last name cannot be empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Your Last Name(min 3 letters)");
          }
          return null;
      },
      onSaved: (value)
      {
          lastNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Last Name",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
      ),
    );
    //end of last name field

    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if(value!.isEmpty){
          return("Please enter your email");
        }
        //regExp for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]") .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
        return null;
      },
      onSaved: (value)
      {
          emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
      ),
    );
    //end of email field

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min 6 Character)");
          }
          return null;
      },
      onSaved: (value)
      {
          passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "First Name",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
      ),
    );
    //end of password field

    //confirm password field
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,
      validator: (value) {
          if ( confirmPasswordEditingController.text != passwordEditingController.text) 
          {
            return "Password don't match";
          }
          return null;
        },
      onSaved: (value)
      {
          confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm Password",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
      ),
    );
    //end of confirm password field

    //signup button
     final signupButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.red,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        onPressed: (() {
          signUp(emailEditingController.text, passwordEditingController.text);
        }),
        child: Text(
          "Sign Up",
          textAlign: TextAlign.center,
          style: TextStyle(
          fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
    //end of signup button


    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.yellow),
          onPressed: (() {
            Navigator.of(context).pop();
            }
         ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 180,
                        child: Image.asset(
                          "assets/logo.png",
                          fit: BoxFit.contain,
                    )),
                    SizedBox(height: 45),
                    firstNameField,
                    SizedBox(height: 20),
                    lastNameField,
                    SizedBox(height: 20),
                    emailField,
                    SizedBox(height: 20),
                    passwordField,
                    SizedBox(height: 20),
                    confirmPasswordField,
                    SizedBox(height: 20),
                    signupButton,
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
  void signUp(String email, String password) async{
  if(_formKey.currentState!.validate()){
    await _auth.createUserWithEmailAndPassword(email: email, password: password)
      .then((value) => 
        {postDetailsToFirestore()
        }).catchError((e)
      {
        Fluttertoast.showToast(msg: e!.message);
      });
  }
  }
  postDetailsToFirestore() async{
  // calling our firestore
  // calling our user model
  // sending these values
  
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = _auth.currentUser;

  UserModel userModel = UserModel();

  userModel.email = user!.email;
  userModel.uid = user.uid;
  userModel.firstName = firstNameEditingController.text;
  userModel.lastName = lastNameEditingController.text;

  await firebaseFirestore
    .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully =) ");

  Navigator.pushAndRemoveUntil(
  (context),
    MaterialPageRoute(
      builder: (context) => HomeScreen()), 
      (route) => false);
  }
}