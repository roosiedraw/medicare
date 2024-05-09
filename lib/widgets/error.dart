import 'package:flutter/material.dart';

class Error404 extends StatefulWidget {
  const Error404({super.key});

  @override
  State<Error404> createState() => _Error404State();
}

class _Error404State extends State<Error404> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.58,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              height: 200,
              width: 200,
              image: AssetImage("assets/images/cancel.png"),
            ),
            Text("Bir Hata Oldu.", style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
    ;
  }
}
