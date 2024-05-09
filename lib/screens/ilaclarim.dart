import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicare/localizations/localekeys.dart';
import 'package:medicare/screens/login.dart';
import 'package:medicare/widgets/cardilaclar.dart';
import 'package:medicare/widgets/ilaceklekart.dart';

import '../widgets/error.dart';
import '../widgets/loading.dart';
import '../widgets/summertime.dart';

class Ilaclarim extends StatefulWidget {
  const Ilaclarim({super.key});

  @override
  State<Ilaclarim> createState() => _IlaclarimState();
}

class _IlaclarimState extends State<Ilaclarim> {
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
                                builder: (context) => IlacEkleKart()));
                  },
                  child: Text(LocaleKeys.IlacTakibiEkle.tr()),
                  style: ElevatedButton.styleFrom(
                      elevation: 10,
                      backgroundColor: Colors.blue,
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
                    child: CardIlaclar(),
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
