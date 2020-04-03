import 'package:flutter/cupertino.dart';

const double _kDefaultDiameterRatio = 1.35;
const Color _kDefaultBackground = Color(0xFFD2D4DB);

class MyCupertinoPicker extends CupertinoPicker{
  final FocusNode focusNode;

  MyCupertinoPicker(
      {Key key,
      double diameterRatio = _kDefaultDiameterRatio,
      Color backgroundColor = _kDefaultBackground,
      double offAxisFraction = 0.0,
      bool useMagnifier = false,
      double magnification = 1.0,
      FixedExtentScrollController scrollController,
      double itemExtent,
      ValueChanged<int> onSelectedItemChanged,
      List<Widget> children,
      bool looping,
      this.focusNode})
      : super(
          key: key,
          diameterRatio: diameterRatio,
          backgroundColor: backgroundColor,
          offAxisFraction: offAxisFraction,
          useMagnifier: useMagnifier,
          magnification: magnification,
          scrollController: scrollController,
          itemExtent: itemExtent,
          onSelectedItemChanged: onSelectedItemChanged,
          children: children,
          looping: looping,
        ) {
      print("[MyCupertinoPicker] Constructor");

  }
}
