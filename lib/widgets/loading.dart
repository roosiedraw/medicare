import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medicare/constants/constants.dart';

import '../localizations/localekeys.dart';

class Loading extends StatelessWidget {
  const Loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.58,
      child: Center(
          child: CircularProgressIndicator(
        color: Constants().appBarColor,
        backgroundColor: Colors.white,
        semanticsLabel: LocaleKeys.veriBekle.tr(),
      )),
    );
  }
}
