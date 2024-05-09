import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicare/widgets/TakipEkleKart.dart';

import '../widgets/cardelement.dart';
import '../widgets/cardtakipler.dart';
import '../widgets/error.dart';
import '../widgets/loading.dart';
import '../widgets/summertime.dart';
import 'login.dart';

class Takiplerim extends StatefulWidget {
  const Takiplerim({super.key});

  @override
  State<Takiplerim> createState() => _TakiplerimState();
}

class _TakiplerimState extends State<Takiplerim> {
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
                                builder: (context) => TakipEkleKart()));
                  },
                  child: Text("Sağlık Takibi Ekle"),
                  style: ElevatedButton.styleFrom(
                      elevation: 10,
                      backgroundColor: Colors.amber,
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
                    child: CardTakipler(),
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
