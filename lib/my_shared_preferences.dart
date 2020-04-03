import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  String primaryWeightUnitIndex = "primaryWeightUnitIndex";
  String secondaryWeightUnitIndex = "secondaryWeightUnitIndex";

  String primaryLengthUnitIndex = "primaryLengthUnitIndex";
  String secondaryLengthUnitIndex = "secondaryLengthUnitIndex";

  String dosageUnit1Index = "dosageUnit1Index";
  String dosageUnit2Index = "dosageUnit2Index";

  String dosageUnitsIndex = "dosageUnitsIndex";

  Future<int> getPrimaryWeightUnitIndex() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(primaryWeightUnitIndex) ?? 0;
  }

  Future<bool> setPrimaryWeightUnitIndex(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(primaryWeightUnitIndex, value);
  }

  Future<int> getSecondaryWeightUnitIndex() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(secondaryWeightUnitIndex) ?? 1;
  }

  Future<bool> setSecondaryWeightUnitIndex(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(secondaryWeightUnitIndex, value);
  }



  Future<int> getPrimaryLengthUnitIndex() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(primaryLengthUnitIndex) ?? 0;
  }

  Future<bool> setPrimaryLengthUnitIndex(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(primaryLengthUnitIndex, value);
  }

  Future<int> getSecondaryLengthUnitIndex() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(secondaryLengthUnitIndex) ?? 1;
  }

  Future<bool> setSecondaryLengthUnitIndex(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(secondaryLengthUnitIndex, value);
  }



  Future<int> getDosageUnit1Index() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(dosageUnit1Index) ?? 0;
  }

  Future<bool> setDosageUnit1Index(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(dosageUnit1Index, value);
  }

  Future<int> getDosageUnit2Index() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(dosageUnit2Index) ?? 0;
  }

  Future<bool> setDosageUnit2Index(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(dosageUnit2Index, value);
  }


  Future<int> getDosageUnitsIndex() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(dosageUnitsIndex) ?? 0;
  }

  Future<bool> setDosageUnitsIndex(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(dosageUnitsIndex, value);
  }


}
