import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicare/constants/constants.dart';
import 'package:medicare/widgets/adekleWidget.dart';

class IlacEkleKart extends StatefulWidget {
  const IlacEkleKart({super.key});

  @override
  State<IlacEkleKart> createState() => _IlacEkleKartState();
}

class _IlacEkleKartState extends State<IlacEkleKart> {
  String ilacSekli = "";
  List<String> saatler = [];
  DateTime _dateTime = DateTime.now();
  TextEditingController ilacAdiController = TextEditingController();
  TextEditingController gunSayisiController = TextEditingController();
  bool selection = false;
  Color unselectedColor = Colors.grey.shade400;
  Color selectedColor = Constants().appBarColor;
  DateTime selectedDate = DateTime.now();
  double sliderValue = 0;
  int selectedFreq = 0;
  String dropdownValue = "Seç";
  Time _time = Time(hour: 11, minute: 30, second: 20);
  bool iosStyle = true;

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
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

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: 350.0,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: new Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: new Center(
                  child: new Text("This is a modal sheet"),
                )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //AD EKLEME
              adekleWidget(
                  ilacAdiController: ilacAdiController, labelText: "İlaç Adı"),

              //TARİH EKLEME
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
                          borderSide:
                              BorderSide(color: Constants().appBarColor)),
                      labelText: "İlaç Başlangıç Tarihi",
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      value == "Bugün"
                          ? dropdownValue =
                              DateFormat('dd-MM-yyyy').format(DateTime.now())
                          : _selectDate(context);
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

              //İLAÇ SAYISI
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.12,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "      Toplam İlaç Sayısı  ",
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 30,
                            height: 30,
                            color: Colors.white,
                            child: Text(
                              sliderValue.toInt().toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                      SliderTheme(
                        data: SliderThemeData(
                            thumbColor: Constants().appBarColor,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 10)),
                        child: Slider(
                          inactiveColor: Colors.grey.shade500,
                          activeColor: Constants().appBarColor,
                          min: 0,
                          max: 100,
                          value: sliderValue,
                          onChanged: (val) {
                            sliderValue = val;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //PERİYOT EKLE
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
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
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
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
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
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
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
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
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
                          "İlaç Alım Sıklığı",
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

              //SAAT EKLE
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
                            "İlaç Saatleri",
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
                                      labelStyle:
                                          TextStyle(color: Colors.white),
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

              //İLAÇ TİPİ
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.09,
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: DropdownSearch<String>(
                        popupProps: PopupProps.modalBottomSheet(
                          constraints: const BoxConstraints.expand(height: 500),
                          showSelectedItems: true,
                        ),
                        items: [
                          "Hap",
                          "Enjeksiyon",
                          "Çözelti(Sıvı)",
                          "Damla",
                          "İnhaler",
                          "Toz",
                          "Diğer"
                        ],
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelStyle:
                                TextStyle(color: Constants().appBarColor),
                            suffixIconColor: Constants().appBarColor,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              width: 3,
                              color: Constants().appBarColor,
                            )),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants().appBarColor)),
                            labelText: "İlaç Şekli",
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            ilacSekli = value.toString();
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
                    Container(
                      height: MediaQuery.of(context).size.height * 0.09,
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: DropdownSearch<String>(
                        popupProps: PopupProps.modalBottomSheet(
                          constraints: const BoxConstraints.expand(height: 500),
                          showSelectedItems: true,
                        ),
                        items: ["1", "2", "3", "4", "5", "6", "7"],
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelStyle:
                                TextStyle(color: Constants().appBarColor),
                            suffixIconColor: Constants().appBarColor,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              width: 3,
                              color: Constants().appBarColor,
                            )),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants().appBarColor)),
                            labelText: "Doz Sayısı",
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            ilacSekli = value.toString();
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
      ),
    );
  }

  Widget hourMinute12H() {
    return new TimePickerSpinner(
      time: DateTime.now(),
      is24HourMode: true,
      onTimeChange: (time) {
        setState(() {
          _dateTime = time;
          saatler.add(DateFormat('HH-mm').format(_dateTime).toString());
        });
      },
    );
  }
}
