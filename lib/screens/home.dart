import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicare/constants/constants.dart';
import 'package:medicare/localizations/localekeys.dart';
import 'package:medicare/screens/login.dart';
import 'package:medicare/screens/takiplerim.dart';
import 'package:medicare/utils/authentication.dart';
import 'package:medicare/widgets/DoktorEkleKart.dart';
import 'package:medicare/widgets/TakipEkleKart.dart';
import 'package:medicare/widgets/ilaceklekart.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

import 'anasayfa.dart';
import 'doktorum.dart';
import 'ilaclarim.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  bool isLogged = false;
  String displayname = "";
  String photoURL = "";
  Home(
      {required this.displayname,
      required this.photoURL,
      required this.isLogged});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool oturumAcildi = false;
  final _pageController = PageController(initialPage: 1);
  int maxCount = 4;
  final List<Widget> bottomBarPages = [
    Anasayfa(),
    Ilaclarim(),
    Takiplerim(),
    Doktorum(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    oturumAcildi = widget.isLogged;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: 100,
        backgroundColor: Colors.white,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.1,
          height: MediaQuery.of(context).size.height * 0.1,
          child: InkWell(
            child: Text("Çıkış Yap"),
            onTap: () {
              Authentication.signOut(context: context).then((value) =>
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login())));
            },
          ),
        ),
      ),
      body: SafeArea(
        child: NestedScrollView(
          physics: NeverScrollableScrollPhysics(),
          body: PageView(
            controller: _pageController,
            children: List.generate(
                bottomBarPages.length, (index) => bottomBarPages[index]),
          ),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            {
              return <Widget>[
                SliverAppBar(
                    floating: true,
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 56, 5, 32),
                          child: oturumAcildi == true
                              ? Image(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(widget.photoURL))
                              : Icon(Icons.person_2)),
                    ),
                    centerTitle: true,
                    title: Text(widget.displayname.toString()),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            onTap: () {
                              Scaffold.of(context).openDrawer();
                            },
                            child: Icon(Icons.settings)),
                      ),
                    ]),
              ];
            }
          },
        ),
      ),
      extendBody: true,
      floatingActionButton: SpeedDial(
        child: Icon(
          Icons.add,
          color: Constants().appBarColor,
        ),
        closedForegroundColor: Colors.blueGrey,
        openForegroundColor: Colors.white,
        closedBackgroundColor: Colors.white,
        openBackgroundColor: Colors.blueGrey,
        labelsBackgroundColor: Colors.white,
        speedDialChildren: <SpeedDialChild>[
          SpeedDialChild(
            child: FaIcon(FontAwesomeIcons.pills),
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
            label: LocaleKeys.ekleIlac.tr(),
            onPressed: () {
              setState(() {
                oturumAcildi == false
                    ? Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()))
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => IlacEkleKart()));
              });
            },
            closeSpeedDialOnPressed: true,
          ),
          SpeedDialChild(
            child: FaIcon(FontAwesomeIcons.heartPulse),
            foregroundColor: Colors.blueGrey,
            backgroundColor: Colors.yellow,
            label: LocaleKeys.ekleTedavi.tr(),
            onPressed: () {
              setState(() {
                oturumAcildi == false
                    ? Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()))
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TakipEkleKart()));
              });
            },
          ),
          SpeedDialChild(
            child: FaIcon(FontAwesomeIcons.userDoctor),
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            label: LocaleKeys.ekleDoktor.tr(),
            onPressed: () {
              setState(() {
                oturumAcildi == false
                    ? Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()))
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoktorEkleKart()));
              });
            },
          ),
          //  Your other SpeedDialChildren go here.
        ],
      ),
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              showBlurBottomBar: false,
              blurOpacity: 0.9,
              blurFilterX: 5.0,
              blurFilterY: 10.0,
              itemLabelStyle: TextStyle(fontSize: 11),
              pageController: _pageController,
              showLabel: true,
              color: Colors.white,
              notchColor: Constants().primaryColor,
              bottomBarItems: [
                BottomBarItem(
                  inActiveItem: FaIcon(
                    FontAwesomeIcons.houseChimneyWindow,
                    color: Colors.blueGrey,
                  ),
                  activeItem: FaIcon(
                    FontAwesomeIcons.houseChimneyWindow,
                    color: Colors.white,
                  ),
                  itemLabel: LocaleKeys.bottomnavAnasayfa.tr(),
                ),
                BottomBarItem(
                  inActiveItem: FaIcon(
                    FontAwesomeIcons.pills,
                    color: Colors.blueGrey,
                  ),
                  activeItem: FaIcon(
                    FontAwesomeIcons.pills,
                    color: Colors.white,
                  ),
                  itemLabel: LocaleKeys.bottomnavIlaclarim.tr(),
                ),
                BottomBarItem(
                  inActiveItem: FaIcon(
                    FontAwesomeIcons.heartPulse,
                    color: Colors.blueGrey,
                  ),
                  activeItem: FaIcon(
                    FontAwesomeIcons.heartPulse,
                    color: Colors.white,
                  ),
                  itemLabel: LocaleKeys.bottomnavTakiplerim.tr(),
                ),
                BottomBarItem(
                  inActiveItem: FaIcon(
                    FontAwesomeIcons.userDoctor,
                    color: Colors.blueGrey,
                  ),
                  activeItem: FaIcon(
                    FontAwesomeIcons.userDoctor,
                    color: Colors.white,
                  ),
                  itemLabel: LocaleKeys.bottomnavDoktorum.tr(),
                ),
              ],
              onTap: (index) {
                /// control your animation using page controller
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeIn,
                );
              },
            )
          : null,
    );
  }
}
