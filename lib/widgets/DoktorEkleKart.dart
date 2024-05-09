import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medicare/widgets/adekleWidget.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../constants/constants.dart';

class DoktorEkleKart extends StatefulWidget {
  const DoktorEkleKart({super.key});

  @override
  State<DoktorEkleKart> createState() => _DoktorEkleKartState();
}

class _DoktorEkleKartState extends State<DoktorEkleKart> {
  TextEditingController doktorAdiController = TextEditingController();
  TextEditingController bolumAdiController = TextEditingController();
  TextEditingController hastaneAdiController = TextEditingController();
  String dropdownValue = "";
  DateTime selectedDate = DateTime.now();
  DateTime pickTime = DateTime.now();
  TimeOfDay timeValue = TimeOfDay(hour: 11, minute: 11);
  String timeValues = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            adekleWidget(
                ilacAdiController: doktorAdiController,
                labelText: "Doktor Adı"),
            adekleWidget(
                ilacAdiController: bolumAdiController,
                labelText: "Tıbbi Bölüm Adı"),
            adekleWidget(
                ilacAdiController: hastaneAdiController,
                labelText: "Hastane Adı"),
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownSearch<String>(
                    popupProps: PopupProps.modalBottomSheet(
                      constraints: const BoxConstraints.expand(height: 200),
                      showSelectedItems: true,
                    ),
                    items: [
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
                            borderSide:
                                BorderSide(color: Constants().appBarColor)),
                        labelText: "Randevu Tarihi",
                      ),
                    ),
                    onChanged: (value) {
                      setState(() async {
                        DateTime? dateTime = await showOmniDateTimePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1600)
                              .subtract(const Duration(days: 3652)),
                          lastDate: DateTime.now().add(
                            const Duration(days: 3652),
                          ),
                          is24HourMode: true,
                          isShowSeconds: false,
                          minutesInterval: 1,
                          secondsInterval: 1,
                          isForce2Digits: true,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          constraints: const BoxConstraints(
                            maxWidth: 350,
                            maxHeight: 650,
                          ),
                          transitionBuilder: (context, anim1, anim2, child) {
                            return FadeTransition(
                              opacity: anim1.drive(
                                Tween(
                                  begin: 0,
                                  end: 1,
                                ),
                              ),
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 200),
                          barrierDismissible: true,
                          selectableDayPredicate: (dateTime) {
                            // Disable 25th Feb 2023
                            if (dateTime == DateTime(2023, 2, 25)) {
                              return false;
                            } else {
                              return true;
                            }
                          },
                        );
                        setState(() {
                          timeValues = DateFormat('dd-MM-yy   HH-mm')
                              .format(dateTime!)
                              .toString()
                              .toString();
                        });

                        print("dateTime: $dateTime");
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Randevu Saati : $timeValues",
                      style: TextStyle(
                          color: Constants().appBarColor, fontSize: 16),
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

  Future<void> _selectDate(
    BuildContext context,
  ) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;

        dropdownValue =
            DateFormat('dd-MM-yyyy').format(selectedDate).toString();
      });
    }
  }
}
