import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicare/constants/constants.dart';
import 'package:medicare/screens/home.dart';
import '../utils/authentication.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants().appBarColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage("assets/images/Adsız.png")),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(250, 50), backgroundColor: Colors.white),
                onPressed: () {
                  Authentication.signInWithGoogle(
                    context: context,
                  ).then((value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Home(
                              isLogged:
                                  FirebaseAuth.instance.currentUser?.uid == null
                                      ? false
                                      : true,
                              photoURL: FirebaseAuth
                                          .instance.currentUser?.uid ==
                                      null
                                  ? "https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png"
                                  : FirebaseAuth.instance.currentUser!.photoURL
                                      .toString(),
                              displayname:
                                  FirebaseAuth.instance.currentUser?.uid == null
                                      ? ""
                                      : FirebaseAuth
                                          .instance.currentUser!.displayName
                                          .toString()))));

                  //Google ile bağlan
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image(
                        height: 30,
                        image: AssetImage("assets/images/google.png")),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Google ile Giriş",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(250, 50), backgroundColor: Colors.blue),
                  onPressed: () async {
                    Authentication.signInWithFacebook(context: context).then(
                        (value) => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home(
                                    isLogged:
                                        FacebookAuthProvider.PROVIDER_ID == null
                                            ? false
                                            : true,
                                    photoURL: FacebookAuthProvider
                                                .PROVIDER_ID ==
                                            null
                                        ? "https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png"
                                        : "https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png",
                                    displayname:
                                        FacebookAuthProvider.PROVIDER_ID == null
                                            ? ""
                                            : FirebaseAuth.instance.currentUser!
                                                    .displayName ??
                                                "".toString()))));

                    print("facebook");
                    //Google ile bağlan
                    //Facebook ile bağlan
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image(
                          height: 30,
                          image: AssetImage("assets/images/facebook.png")),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Facebook ile Giriş",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
