import 'package:bsadosecalculator/app.dart';
import 'package:bsadosecalculator/app_state_interactor.dart';
import 'package:bsadosecalculator/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  // Make Platform Specific adjustments
  setPlatformInfo();

  // Load any persistent data needed

  runApp(AppStateInteractor(child: AppRoot()));
}
