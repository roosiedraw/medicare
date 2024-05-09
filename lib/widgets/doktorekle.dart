import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/constants.dart';

class CardDoktor extends StatefulWidget {
  const CardDoktor({super.key});

  @override
  State<CardDoktor> createState() => _CardDoktorState();
}

class _CardDoktorState extends State<CardDoktor> {
  bool isAlarm = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        child: Column(
                      children: [
                        Image(
                            width: MediaQuery.of(context).size.width * 0.11,
                            height: MediaQuery.of(context).size.height * 0.11,
                            image: AssetImage("assets/images/doctor.png")),
                        Text(
                          "Doktor Adı",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Randevu Yeri",
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey.shade800)),
                      ],
                    )),
                    VerticalDivider(
                      thickness: 2,
                      endIndent: 5,
                      indent: 5,
                      width: 0,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Randevu Adı",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Text("Randevu tarihi",
                              style: TextStyle(
                                  fontSize: 13, color: Colors.grey.shade800)),
                          Text("Randevu bölümü",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade800)),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              //alarm kurma
                              setState(() {
                                isAlarm = !isAlarm;
                              });
                            },
                            child: isAlarm == true
                                ? FaIcon(
                                    FontAwesomeIcons.bell,
                                    color: Colors.green,
                                  )
                                : FaIcon(
                                    FontAwesomeIcons.bellSlash,
                                    color: Colors.red,
                                  ),
                          ),
                          InkWell(
                            onTap: () {
                              //Düzenleme işlemi için alertdialog açılacak
                            },
                            child: FaIcon(
                              FontAwesomeIcons.penToSquare,
                              color: Constants().appBarColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
    ;
  }
}
