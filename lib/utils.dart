import 'dart:io';
import 'package:bsadosecalculator/my_cupertino_picker.dart';
import 'package:bsadosecalculator/my_flutter_app_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bsadosecalculator/model/drug.dart';
import 'package:bsadosecalculator/model/animal.dart';
import 'package:bsadosecalculator/constants.dart';

void setPlatformInfo() {
  switch (Platform.operatingSystem) {
    case "android":
      platform = Platforms.android;
      break;
    case "ios":
      platform = Platforms.ios;
      break;
  }
}

Widget getLockIcon(String type, bool isDisabled) {
  Color iconColor = accentColor;
  //IconData iconData = Icons.lock_outline;
  IconData iconData = MyFlutterApp.locked;

  if (isDisabled) {
    iconColor = inactiveColor;
  }

  if (type == 'open') {
    //iconData = Icons.lock_open;
    iconData = MyFlutterApp.unlocked;
  }

  return Container(
    child: Icon(iconData, size: defaultIconSize, color: iconColor),
  );
}

BoxDecoration getDefaultBoxDecoration(bool isDisabled) {
  Color color = primaryColor;

  if (isDisabled) {
    color = inactiveColor;
  }

  return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(7.5)),
      border: Border.all(width: 2.0, color: color));
}

Container closeWidget = Container(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Text(
      "Done",
      style: baseTextStyle.copyWith(color: accentColor),
    ));

String getPickerDisplayText(List displayList, int index) {
  String result = '';
  if (displayList[index] is Drug) {
    result = (displayList[index] as Drug).name;
  } else if (displayList[index] is Animal) {
    result = (displayList[index] as Animal).species;
  } else {
    result = displayList[index].toString();
  }

  return result;
}

Widget buildPicker(int itemIndex, FocusNode focusNode, Function setIndexState,
    List displayList) {
  final FixedExtentScrollController scrollController =
      FixedExtentScrollController(initialItem: itemIndex);

  return Container(
    height: kPickerSheetHeight,
    child: DefaultTextStyle(
      style: TextStyle(
        color: Colors.black,
        fontSize: defaultFontSizeLarger,
      ),
      child: MyCupertinoPicker(
        focusNode: focusNode,
        scrollController: scrollController,
        itemExtent: pickerItemExtent + 16.0,
        looping: false,
        backgroundColor: Colors.white,
        onSelectedItemChanged: (int index) {
          setIndexState(index);
        },
        children: List<Widget>.generate(displayList.length, (int index) {
          return Center(
            child: Text(
              getPickerDisplayText(displayList, index),
            ),
          );
        }),
      ),
    ),
  );
}

Widget buildPickerDropDown(BuildContext context, List displayList,
    int itemIndex, FocusNode focusNode, bool isEnabled) {
  // Todo If !isenabled Grey out colors and disable gesturedetector
  if (!isEnabled) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: getDefaultBoxDecoration(false).copyWith(
          color: inactiveColor2,
        ),
        padding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                getPickerDisplayText(displayList, itemIndex),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: actionTextStyle,
              ),
            ),
            Icon(Icons.arrow_drop_down,
                color: Colors.transparent, size: defaultIconSize),
          ],
        ),
      ),
    );
  }

  return GestureDetector(
    onTap: () {
      focusNode.attach(context).reparent(parent: FocusScope.of(context));
      FocusScope.of(context).requestFocus(focusNode);
    },
    child: Container(
      decoration: getDefaultBoxDecoration(false),
      //height: 96.0,
      padding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              getPickerDisplayText(displayList, itemIndex),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: actionTextStyle,
            ),
          ),
          Icon(Icons.arrow_drop_down,
              color: Colors.black, size: defaultIconSize),
        ],
      ),
    ),
  );
}

Widget buildLabel(BuildContext context, String label) {
  return Container(
    child: Text(
      label,
      textAlign: TextAlign.left,
      style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
    ),
  );
}

void setGoldenMeasurements(MediaQueryData mediaQueryData) {
  goldenScreenWidth = mediaQueryData.size.width * ALMOST_GOLDEN_RATIO;
}

void setDevice(MediaQueryData mediaQueryData) {
  devicePixelRatio = mediaQueryData.devicePixelRatio;
  deviceLongestSide = mediaQueryData.size.longestSide;
  deviceShortestSide = mediaQueryData.size.shortestSide;

  if (deviceShortestSide >= 415.0) {
    // Measured in points. iPad mini and above
    defaultFontSize = 14.0 * devicePixelRatio;
    defaultIconSize = 16.0 * devicePixelRatio;
    lockIconSize = 18.0 * devicePixelRatio;

    display1FontSize = 24.0 * devicePixelRatio;

    defaultSpaceBetweenRows = 12.0 * 1.5;

    pickerWidth = 32.0 * 1.5;
    //pickerHeightSmall = 32.0 * 1.5;
    //pickerHeightLarge = 96.0 * 1.5;
    pickerItemExtent = 32.0 * 1.5;

    if (deviceShortestSide >= 1245) {
      defaultFontSize = 24.0 * devicePixelRatio;
      defaultIconSize = 26.0 * devicePixelRatio;
      lockIconSize = 28.0 * devicePixelRatio;

      display1FontSize = 24.0 * devicePixelRatio;

      defaultSpaceBetweenRows = 12.0 * devicePixelRatio;
      pickerWidth = 32.0 * devicePixelRatio;
      //pickerHeightSmall = 32.0 * devicePixelRatio;
      //pickerHeightLarge = (pickerHeightSmall * 3) * devicePixelRatio;
      pickerItemExtent = 32.0 * devicePixelRatio;
    }
  }

  print('Device longest side: ' + deviceLongestSide.toString());
  print('Device shortest side: ' + deviceShortestSide.toString());
  print('Device pixel ratio: ' + devicePixelRatio.toString());
}

Widget buildTextField(
    TextEditingController controller,
    String placeholder,
    Function onChanged,
    bool isEnabled,
    Color borderColor,
    FocusNode focusNode) {
  BoxDecoration boxDecoration = BoxDecoration(
    border: Border.all(
      width: 2.0,
      color: borderColor,
    ),
    borderRadius: BorderRadius.circular(7.5),
  );

  Container suffix = Container(
    padding: const EdgeInsets.symmetric(horizontal: 4.0),
    child: CupertinoButton(
      color: inactiveColor,
      minSize: 0.0,
      child: Icon(
        CupertinoIcons.clear,
        size: defaultFontSize,
        color: CupertinoColors.white,
      ),
      padding: const EdgeInsets.all(2.0),
      borderRadius: BorderRadius.circular(15.0),
      onPressed: () {
        controller.clear();
        onChanged("0.0");
      },
    ),
  );

  TextStyle placeholderStyle = baseTextStyle.copyWith(color: inactiveColor2);

  if (!isEnabled) {
    suffix = null;
    boxDecoration = boxDecoration.copyWith(color: inactiveColor2);
    placeholderStyle = placeholderStyle.copyWith(color: Colors.black87);
  }

  switch (platform) {
    case Platforms.android:
      return Material(
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
              labelText: placeholder, labelStyle: baseTextStyle),
          validator: (value) {
            if (value.isEmpty) {
              //return appStrings.validationErrorEmailBlank;
              return null;
            }
            if (!value.contains("@") ||
                !value.contains(".") ||
                value.endsWith("@") ||
                value.endsWith(".")) {
              //return appStrings.validationErrorEmailFormat;
              return null;
            }
            return null;
          },
        ),
      );
      break;
    case Platforms.ios:
      return Container(
        child: CupertinoTextField(
          placeholderStyle: placeholderStyle,
          focusNode: focusNode,
          enabled: isEnabled,
          controller: controller,
          textCapitalization: TextCapitalization.none,
          placeholder: placeholder,
          decoration: boxDecoration,
          maxLines: 1,
          textInputAction: TextInputAction.done,
          keyboardType:
              TextInputType.numberWithOptions(signed: false, decimal: true),
          maxLength: 6,
          prefix: Container(padding: EdgeInsets.symmetric(horizontal: 4.0)),
          suffix: suffix,
          autofocus: false,
          suffixMode: OverlayVisibilityMode.editing,
          onChanged: ((string) {
            if (controller.text.length != 0) {
              onChanged(string);
            } else {
              onChanged("0.0");
            }
          }),
        ),
      );
      break;
  }
  return null;
}

Widget buildPlatformScaffold(BuildContext context, String title, Widget body) {
  Widget scaffold;

  switch (platform) {
    case Platforms.android:
      scaffold = Scaffold(
        body: Container(
            padding: EdgeInsets.only(left: 24.0, right: 24.0), child: body),
      );
      break;
    case Platforms.ios:
      scaffold = CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(title, style: titleTextStyleLarger),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.0),
                        child: Image.asset(
                          "assets/Illinois-Logo-Full-Color-RGB.png",
                          scale: 9,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.0),
                        child: Image.asset(
                          "assets/MU_2-4-1-color-logo.png",
                          scale: 8.45,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SliverPadding(
              padding: MediaQuery.of(context)
                  .removePadding(
                      removeTop: true, removeLeft: true, removeRight: true)
                  .padding,
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Container(
                      padding: EdgeInsets.only(left: 24.0, right: 24.0),
                      child: body);
                }, childCount: 1),
              ),
            )
          ],
        ),
      );

      break;
  }

  return SafeArea(top: true, bottom: false, child: scaffold);
}


