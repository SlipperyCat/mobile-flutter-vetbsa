import 'package:flutter/cupertino.dart';
import 'package:bsadosecalculator/constants.dart';

class About extends StatelessWidget {
  final Function _displayLegalDialogAbout;

  About(this._displayLegalDialogAbout) {
    print("[About] Constructor");
  }

  @override
  Widget build(BuildContext context) {
    print('[About] build()');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: defaultSpaceBetweenRows),
          child: Text(
            appTitleFull,
            style: titleTextStyleLarger,
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: defaultSpaceBetweenRows),
          child: Text(
            versionString,
            style: baseTextStyle,
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: defaultSpaceBetweenRows, bottom: defaultSpaceBetweenRows/2),
          child: Image.asset(
            "assets/Illinois-Wordmark-Horizontal-Full-Color-RGB.png", scale: 3,
          ),
        ),

        Container(
          padding: EdgeInsets.only(top: defaultSpaceBetweenRows/2, bottom: defaultSpaceBetweenRows),
          child: Image.asset(
            "assets/logo-policy-1.png",
            scale: 2.2,
          ),
        ),

        Container(
            padding: EdgeInsets.only(top: defaultSpaceBetweenRows * 2),
            child: GestureDetector(
              child: Text(
                "Legal Disclaimer",
                style: baseTextStyle.copyWith(
                    decoration: TextDecoration.underline,
                    color: inactiveColor),
              ),
              onTap: () {
                _displayLegalDialogAbout();
              },
            )),
        Container(
          padding: EdgeInsets.symmetric(vertical: defaultSpaceBetweenRows),
          child: Text(
            trusteeCopyright,
            style: baseTextStyle,
          ),
        ),


      ],
    );
  }
}
