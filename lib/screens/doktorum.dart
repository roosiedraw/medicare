import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicare/screens/login.dart';
import 'package:medicare/widgets/DoktorEkleKart.dart';
import 'package:medicare/widgets/doktorekle.dart';

import '../widgets/error.dart';
import '../widgets/loading.dart';
import '../widgets/summertime.dart';

class Doktorum extends StatefulWidget {
  Doktorum({Key? key}) : super(key: key);

  @override
  State<Doktorum> createState() => _DoktorumState();
}

class _DoktorumState extends State<Doktorum> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.58,
      child: StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("loading data");
            return Loading();
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            print("no data");
            return Column(
              children: [
                summertime(),
                ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.currentUser == null
                        ? Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()))
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DoktorEkleKart()));
                  },
                  child: Text("Doktor Randevusu Ekle"),
                  style: ElevatedButton.styleFrom(
                      elevation: 10,
                      backgroundColor: Colors.green,
                      shape: StadiumBorder(),
                      textStyle: TextStyle(fontSize: 17),
                      fixedSize: Size(250, 40)),
                )
              ],
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            print("has data");
            return ListView.builder(
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CardDoktor(),
                  );
                });
          } else {
            print("error");
            return Error404();
          }
        },
        stream: null,
      ),
    );
  }
}
