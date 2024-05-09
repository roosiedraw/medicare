import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicare/widgets/adekleWidget.dart';

import '../constants/constants.dart';

class TakipEkleKart extends StatefulWidget {
  const TakipEkleKart({super.key});

  @override
  State<TakipEkleKart> createState() => _TakipEkleKartState();
}

class _TakipEkleKartState extends State<TakipEkleKart> {
  TextEditingController takipAdiController = TextEditingController();
  String dropdownValue = "";
  String dropdownValue2 = "";
  DateTime selectedDate = DateTime.now();
  bool selection = false;
  int selectedFreq = 0;
  TextEditingController gunSayisiController = TextEditingController();
  List<String> saatler = [];
  Time _time = Time(hour: 11, minute: 30, second: 20);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //AD EKLE
            adekleWidget(
                ilacAdiController: takipAdiController, labelText: "Takip Adı"),
            //BAŞLANGIÇ TARİHİ
            Container(
              height: MediaQuery.of(context).size.height * 0.09,
              width: MediaQuery.of(context).size.width * 0.8,
              child: DropdownSearch<String>(
                popupProps: PopupProps.modalBottomSheet(
                  constraints: const BoxConstraints.expand(height: 200),
                  showSelectedItems: true,
                ),
                items: [
                  "Bugün",
                  "Tarih Seç",
                ],
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelStyle: TextStyle(color: Constants().appBarColor),
                    suffixIconColor: Constants().appBarColor,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      width: 3,
                      color: Constants().appBarColor,
                    )),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Constants().appBarColor)),
                    labelText: "Takip Başlangıç Tarihi",
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    value == "Bugün"
                        ? dropdownValue =
                            DateFormat('dd-MM-yyyy').format(DateTime.now())
                        : _selectDate(context, true);
                  });
                },
                selectedItem: dropdownValue,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Lütfen Boş Bırakmayın";
                  }
                  return null;
                },
              ),
            ),
            //TAKİP BİTİŞ TARİHİ
            Container(
              height: MediaQuery.of(context).size.height * 0.09,
              width: MediaQuery.of(context).size.width * 0.8,
              child: DropdownSearch<String>(
                popupProps: PopupProps.modalBottomSheet(
                  constraints: const BoxConstraints.expand(height: 200),
                  showSelectedItems: true,
                ),
                items: [
                  "Bugün",
                  "Tarih Seç",
                ],
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelStyle: TextStyle(color: Constants().appBarColor),
                    suffixIconColor: Constants().appBarColor,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      width: 3,
                      color: Constants().appBarColor,
                    )),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Constants().appBarColor)),
                    labelText: "Takip Bitiş Tarihi",
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    value == "Bugün"
                        ? dropdownValue2 =
                            DateFormat('dd-MM-yyyy').format(DateTime.now())
                        : _selectDate(context, false);
                  });
                },
                selectedItem: dropdownValue2,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Lütfen Boş Bırakmayın";
                  }
                  return null;
                },
              ),
            ),
            //PERİYOTLAR
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, fixedSize: Size(316, 40)),
              onPressed: () {
                showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 400,
                        color: Constants().scaffoldBackgroundColor,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              InkWell(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Hergün',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Icon(
                                              Icons.add_task_rounded,
                                              color: Constants().appBarColor,
                                            ),
                                          ]),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    selection = true;
                                    selectedFreq = 1;
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                              InkWell(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'İki Günde Bir',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Icon(
                                              Icons.add_task_rounded,
                                              color: Constants().appBarColor,
                                            ),
                                          ]),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    selection = true;
                                    selectedFreq = 2;
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                              InkWell(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Üç Günde Bir',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Icon(
                                              Icons.add_task_rounded,
                                              color: Constants().appBarColor,
                                            ),
                                          ]),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    selection = true;
                                    selectedFreq = 3;
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                              InkWell(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Haftada Bir',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Icon(
                                              Icons.add_task_rounded,
                                              color: Constants().appBarColor,
                                            ),
                                          ]),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    selection = true;
                                    selectedFreq = 7;
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: TextField(
                                    controller: gunSayisiController,
                                    maxLength: 3,
                                    keyboardType: TextInputType.number,
                                    cursorColor: Constants().appBarColor,
                                    decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                          width: 3,
                                          color: Constants().appBarColor,
                                        )),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                          color: Constants().appBarColor,
                                        )),
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                          color: Constants().appBarColor,
                                        )),
                                        labelText: "Gün Sayısı Belirleyin",
                                        labelStyle: TextStyle(
                                            color: Constants().appBarColor)),
                                    onChanged: (v) {
                                      setState(() {
                                        selectedFreq = int.parse(v);
                                      });
                                    },
                                    onEditingComplete: () {
                                      gunSayisiController.clear();
                                      Navigator.pop(context);
                                    },
                                  )),
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Takip Periyodu",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text("${selectedFreq.toString()} gün",
                          style: TextStyle(color: Colors.black)),
                      FaIcon(
                        FontAwesomeIcons.arrowRight,
                        color: Constants().appBarColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
            //SAATLER
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.11,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Constants().appBarColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text("Saat Seç")),
                      onTap: () {
                        Navigator.of(context).push(showPicker(
                          is24HrFormat: true,
                          value: _time,
                          context: context,
                          onChange: (date) {
                            setState(() {
                              saatler.add(date.format(context).toString());
                            });
                          },
                          minHour: 01,
                          minMinute: 01,
                        ));
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Takip Saatleri",
                          style: TextStyle(color: Constants().appBarColor),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: saatler.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ChoiceChip(
                                    labelStyle: TextStyle(color: Colors.white),
                                    selectedColor: Colors.green,
                                    label: Text(
                                      " ${saatler[index].toString()}",
                                    ),
                                    selected: true,
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            Container(
              child: ElevatedButton(
                  onPressed: () {
                    //Veritabanına kaydet
                    Navigator.pop(context);
                  },
                  child: Text("Kaydet")),
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.07,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool drop) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        drop == true
            ? dropdownValue =
                DateFormat('dd-MM-yyyy').format(selectedDate).toString()
            : dropdownValue2 =
                DateFormat('dd-MM-yyyy').format(selectedDate).toString();
      });
    }
  }
}
