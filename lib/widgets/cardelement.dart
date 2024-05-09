import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class cardElement extends StatefulWidget {
  const cardElement({
    super.key,
  });

  @override
  State<cardElement> createState() => _cardElementState();
}

class _cardElementState extends State<cardElement> {
  bool isPill = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Pop up ayar sayfası
        print("eser");
      },
      child: Card(
        child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.13,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: isPill == true
                        ? Image(
                            width: MediaQuery.of(context).size.width * 0.11,
                            height: MediaQuery.of(context).size.height * 0.11,
                            image: AssetImage("assets/images/pills.png"))
                        : Image(
                            width: MediaQuery.of(context).size.width * 0.11,
                            height: MediaQuery.of(context).size.height * 0.11,
                            image: AssetImage("assets/images/monitoring.png")),
                  ),
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
                          "İlaç Adı",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Text("İlaç bilgisi",
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey.shade800)),
                        Text("Alındı alınmadı bilgisi",
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey.shade800))
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("8:00",
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  )
                ],
              ),
            )),
      ),
    );
  }
}
