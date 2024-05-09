import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';

import 'package:medicare/constants/constants.dart';
import 'package:medicare/widgets/cardelement.dart';
import 'package:medicare/widgets/error.dart';

import '../widgets/loading.dart';
import '../widgets/summertime.dart';

class Anasayfa extends StatefulWidget {
  Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  late DateTime _selectedDate;
  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now().add(const Duration(days: 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.15,
            color: Constants().appBarColor,
            child: CalendarTimeline(
              shrink: false,
              showYears: false,
              initialDate: _selectedDate,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
              onDateSelected: (date) => setState(() => _selectedDate = date),
              leftMargin: 10,
              monthColor: Colors.white70,
              dayColor: Colors.teal[200],
              dayNameColor: const Color(0xFF333A47),
              activeDayColor: Colors.white,
              activeBackgroundDayColor: Colors.redAccent[100],
              dotsColor: const Color(0xFF333A47),
              locale: 'tr',
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.58,
            child: StreamBuilder(
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print("loading data");
                  return Loading();
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  print("no data");
                  return summertime();
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  print("has data");
                  return ListView.builder(
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: cardElement(),
                        );
                      });
                } else {
                  print("error");
                  return Error404();
                }
              },
              stream: null,
            ),
          ),
        ],
      ),
    );
  }
}
