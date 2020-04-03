import 'package:bsadosecalculator/model/ferret.dart';
import 'package:bsadosecalculator/model/rabbit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bsadosecalculator/model/animal.dart';
import 'package:bsadosecalculator/model/cat.dart';
import 'package:bsadosecalculator/model/dog.dart';
import 'package:bsadosecalculator/model/dosage.dart';
import 'package:bsadosecalculator/model/drug.dart';
import 'package:bsadosecalculator/model/horse.dart';

//const double GOLDEN_RATIO = 0.618;
const double ALMOST_GOLDEN_RATIO = 0.59;
const double DOUBLE_85 = 0.85;
double goldenScreenWidth; // Set dynamically based on screen size

double defaultFontSize = 22.0;

double pickerHeightSmall = 32.0;
double pickerWidth = 32.0;
double pickerItemExtent = 32.0;

double pickerHeightLarge = 96.0;
double defaultSpaceBetweenRows = 24.0;

double display1FontSize = 28.0;

double defaultIconSize = 32.0;
double lockIconSize = 24.0;

double screenHeight;
double screenWidth;
double devicePixelRatio;
double deviceLongestSide;
double deviceShortestSide;

Platforms platform;
enum Platforms { android, ios }

TextStyle baseTextStyle = TextStyle(
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
    color: Colors.black,
    fontSize: defaultFontSize);
TextStyle baseTextStyleSmaller =
    baseTextStyle.copyWith(fontSize: defaultFontSizeSmaller);

TextStyle actionTextStyle = baseTextStyle.copyWith(color: primaryColor);

TextStyle titleTextStyle = baseTextStyle.copyWith(fontWeight: FontWeight.bold);
TextStyle titleTextStyleLarger =
    titleTextStyle.copyWith(fontSize: defaultFontSizeLarger);

const appTitle = 'Dose Calculator';
const appTitleFull = 'VetBSA';
const String versionNumber = '1.0';

const double kgToLbFactor = 2.2;
const double cmToInFactor = 0.3937;

const double kPickerSheetHeight = 216.0;

const double defaultFontSizeLarger = 28.0;
const double defaultFontSizeSmaller = 18.0;

const Color primaryColor = Colors.black;
const Color accentColor = Color.fromRGBO(0, 107, 204, 1.0);
const Color inactiveColor = Color.fromRGBO(74, 74, 74, 1.0);
const Color warningColor = Color.fromRGBO(177, 45, 0, 1.0);

const Color inactiveColor2 = Color.fromRGBO(74, 74, 74, 0.40);

const List<int> numbersInt = <int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

const List<String> weightUnits = <String>[
  'kg',
  'lb',
];

const List<String> lengthUnits = <String>[
  'cm',
  'in',
];

const List<String> schedulesAll = <String>[
  "Select...",
  "MTD",
  "Metronomic"
];

const List<String> schedulesMTD = <String>[
  //"Select...",
  "MTD",
];

const List<String> schedulesNone = <String>[
  "User Specified",
];

const List<String> dosageUnits1 = <String>['mg', 'IU', 'g'];
const List<String> dosageUnits2 = <String>['m' + '\u00B2', 'kg', 'lb'];

const List<String> dosageUnits = <String>[
  "mg/" + "m" + "\u00B2",
  "mg/kg",
  "IU/" + "m" + "\u00B2",
  "IU/kg",
  "g/" + "m" + "\u00B2",
  "g/kg",
  "mg/lb"
];

const List<String> bsaTypes = <String>[
  'Select...',
  'BSA (Standard)',
  'BSA (New)',
];

const List<String> dialogTitles = <String>[
  'BSA Calculation Type Citations' + '\n',
  'Drug Calculation Citation' + '\n',
  'Length Measurement' + '\n',
  'BSA Results Calculation' + '\n',
];

List<String> dialogContent = <String>[
  bsaTypes[1] +
      ': JVIM (1998) 12:267-71 and Small Animal Clinical Oncology 5th ed (2013) pg 164.' +
      '\n\n' +
      bsaTypes[2] +
      ': JVIM (2019) 33:792-9',
  '', // Moved to individual drug entry
  'Manubrium to ishium',
  'Commonly used charts might round numbers and results might differ from the precise calculation here.',
];

String trusteeCopyright =
    '\u00A9' + '2019 University of Illinois Board of Trustees';
String versionString = 'Version: ' + versionNumber;

final List<Animal> animals = <Animal>[
  Animal('Select...'),
  Cat(),
  Dog(),
  Horse(),
  //Ferret(),
  //Rabbit()
];


Dosage emptyDosage = Dosage.explicit("","?",0.0,0.0,"N/A","","N/A");

List<Dosage> EmptyDosages = <Dosage>[
  emptyDosage
];

List<Dosage> CarboplatinDosages = <Dosage>[
  Dosage.explicit('Cat', "MTD", 240.0, 240.0, "Every 3-4 weeks", "", "Kisseberth WC, et al. J Vet Intern Med. 2008 Jan-Feb;22(1):83-8."),
  Dosage.explicit('Dog', "MTD", 240.0, 300.0, "Every 3 weeks", "", "Bergman PJ, et al. J Vet Intern Med. 1996 Mar-Apr;10(2):76-81." + "\n\n" + "Page RL, et al. J Vet Intern Med. 1993 Jul-Aug;7(4):235-40."),
  Dosage.explicit('Horse', "MTD", 180.0, 300.0, "", "", ""),
];

List<Dosage> CCNUDosages = <Dosage>[
  Dosage.explicit('Cat', "MTD", 30.0, 60.0, "Every 3-6 weeks", "", "Rassnick KM, et al. J Vet Intern Med. 2001 May-Jun;15(3):196-9." + "\n\n" + "Fan TM, et al. J Am Anim Hosp Assoc. 2002 Jul-Aug;38(4):357-63."),
  Dosage.explicit('Dog', "MTD", 60.0, 90.0, "Every 3 weeks", "", "Moore AS, et al. J Vet Intern Med. 1999 Sep-Oct;13(5):395-8." + "\n\n" + "Risbon RE, et al. J Vet Intern Med. 2006 Nov-Dec;20(6):1389-97"),
  Dosage.explicit('Horse', "MTD", 30.0, 90.0, "", "", ""),
  Dosage.explicit('Dog', "Metronomic", 2.84, 2.84, "Everyday", "", "Tripp CD, et al. J Vet Intern Med. 2011 Mar-Apr;25(2):278-84."),
];

List<Dosage> ChlorambucilDosages = <Dosage>[
  Dosage.explicit('Cat', "MTD", 20.0, 20.0, "Every 2-3 weeks", "", "Stein TJ, et al. J Am Anim Hosp Assoc 2010;46:413-417."),
  Dosage.explicit('Dog', "MTD", 10.0, 40.0, "Every 2 weeks", "", "Elliott JW, et al. Vet Comp Oncol 2013;11:185-198." + "\n\n" + "Siedlecki CT, et al. Can Vet J 2006;47:52-59." + "\n\n" + "Kleiter M, et al. Aust Vet J 2001;79:335-338."),
  Dosage.explicit('Cat', "Metronomic", 2.0, 2.0, "Every 48-72 hours", "2.0 mg per cat or use dog calculation", "Pope KV, et al. Vet Med Sci 2015;1:51-62."),
  Dosage.explicit('Dog', "Metronomic", 4.0, 4.0, "Everyday", "", "Custead MR, et al. Vet Comp Oncol. 2017;15(3):808-819"),
];

List<Dosage> CisplatinDosages = <Dosage>[
  Dosage.explicit('Dog', "MTD", 50.0, 70.0, "Every 3 weeks", "", "Ogilvie GK, et al. Am J Vet Res. 1988 Jul;49(7):1076-8." + "\n\n" + "Boria PA, et al. J Am Vet Med Assoc. 2004;224(3):388-394"),
];

List<Dosage> CyclophosphamideDosages = <Dosage>[
  Dosage.explicit('Cat', "MTD", 200.0, 460.0, "Every 3 weeks", "", "Moore AS, et al. Vet J. 2018 Dec;242:39-43."),
  Dosage.explicit('Dog', "MTD", 200.0, 250.0, "Every 2-3 weeks", "", "Garrett LD, et al. J Vet Intern Med. 2002 Nov-Dec;16(6):704-9."),
  Dosage.explicit('Dog', "Metronomic", 10.0, 15.0, "Everyday", "", "Burton JH, et al. J Vet Intern Med. 2011 Jul-Aug;25(4):920-6." + "\n\n" + "Elmslie R, et al. J Vet Intern Med. 2008 Nov-Dec;22(6):1373-9."),
];

List<Dosage> CytosarDosages = <Dosage>[
  Dosage.explicit("Dog", "MTD", 400.0, 600.0, "Total dose over 2-4 days", "", "Ruslander D, et al. J Vet Intern Med. 1994 Jul-Aug;8(4):299-301."),
];

List<Dosage> DoxorubicinDosages = <Dosage>[
  Dosage.withWeight('Cat', "MTD", 25.0, 25.0, 1.0, 1.0, "Every 3 weeks", "", "Mauldin GE, et al. J Feline Med Surg. 2008 Aug;10(4):324-31."),
  Dosage.withWeight('Dog', "MTD", 30.0, 30.0, 1.0, 1.0, "Every 2-3 weeks", "30 mg/" + dosageUnits2[0] + " or 1 mg/kg if 10 kg or less", "Arrington K, et al. Am J Vet Res. 1994 Nov;55(11):1587-92."),
  Dosage.explicit('Horse', "MTD", 75.0, 75.0, "Every 3 weeks", "", "Theon AP, et al. J Vet Intern Med. 2013 Sep-Oct; 27(5):1209-17."),
];

List<Dosage> MelphalanDosages = <Dosage>[
  Dosage.explicit("Dog", "MTD", 7.0, 7.0, "Every 3 weeks", "7 mg/" + dosageUnits2[0] + "/d for 5 days (35 mg/" + dosageUnits2[0] + " total dose divided)", "Fernandez R, et al. J Vet Intern Med. May 2018;32(3):1060-1069."),
  Dosage.withWeight("Dog", "Metronomic", 0.0, 0.0, 0.05, 0.1, "Everyday", "0.1 mg/kg/d for 10 days then 0.05 mg/kg/d", "Fernandez R, et al. J Vet Intern Med. May 2018;32(3):1060-1069."),
];

List<Dosage> MitoxantroneDosages = <Dosage>[
  Dosage.explicit('Cat', "MTD", 5.0, 6.5, "Every 3 weeks", "", "Ogilvie GK, et al. J Am Vet Med Assoc. 1993 Jun 1;202(11):1839-44."),
  Dosage.explicit('Dog', "MTD", 5.0, 6.5, "Every 3 weeks", "", "Hauck ML, et al. Int J Hyperthermia. 1996 May-Jun;12(3):309-20."),
];

List<Dosage> SatraplatinDosages = <Dosage>[
  Dosage.explicit('Dog', "MTD", 35.0, 35.0, "Every 3-4 weeks", "35 mg/" + dosageUnits2[0] + "/d for 5 days (175 mg/" + dosageUnits2[0] + " total)", "Selting KA, et al. J Vet Intern Med. 2011 Jul-Aug;25(4):909-15."),
  Dosage.explicit('Dog', "Metronomic", 5.0, 5.0, "Everyday", "", "Selting KA, et al. unpublished. Veterinary Cancer Society proceedings 2010."),
];

List<Dosage> VinblastineDosages = <Dosage>[
  Dosage.explicit('Cat', "MTD", 1.5, 2.0, "Every week", "", "Krick E, et al. J Vet Intern Med. 2013 Jan-Feb;27(1):134-40."),
  Dosage.explicit('Dog', "MTD", 2.0, 3.5, "Every 1-2 weeks", "", "Bailey DB, et al. J Vet Intern Med. 2008 Nov-Dec;22(6):1397-402."),
];

List<Dosage> VincristineDosages = <Dosage>[
  Dosage.explicit('Cat', "MTD", 0.5, 0.5, "Every week", "", "Krick E, et al. J Vet Intern Med. 2013 Jan-Feb;27(1):134-40."),
  Dosage.withWeight('Dog', "MTD", 0.5, 0.7, 0.025, 0.025, "Every week", "", "Madewell BR, et al. Anticancer Drugs 1995;6:327-330." + "\n\n" + "Chun R, et al. J Vet Intern Med. 2000 Mar-Apr;14(2):120-4."),
];

List<Dosage> VinorelbineDosages = <Dosage>[
  Dosage.explicit('Cat', "MTD", 11.5, 11.5, "Every week", "", "Pierro J, et al. J Vet Intern Med. 2013 Jul-Aug;27(4):943-8."),
  Dosage.explicit('Dog', "MTD", 15.0, 18.0, "Every week", "", "Poirier VJ, et al. J Vet Intern Med. 2004 Jul-Aug;18(4):536-9."),
];

List<Dosage> OtherOverrideDosages = <Dosage>[
  Dosage.withWeight('Cat', "User Specified", 0.0, 999999, 0.0, 999999, "User Specified", "", "N/A"),
  Dosage.withWeight('Dog', "User Specified", 0.0, 999999, 0.0, 999999, "User Specified", "", "N/A"),
  Dosage.withWeight('Horse', "User Specified", 0.0, 999999, 0.0, 999999, "User Specified", "", "N/A"),
];

final List<Drug> drugs = <Drug>[
  // Name, mtdMetronmic, lowDosageMgM2, highDosageMgM2, lowDosageMgKg, highDosageMgKg, frequency, notes, citation
  Drug.withDosageList("Select...", EmptyDosages),
  Drug.withDosageList("Carboplatin", CarboplatinDosages),
  Drug.withDosageList("CCNU (Lomustine)", CCNUDosages),
  Drug.withDosageList("Chlorambucil", ChlorambucilDosages),
  Drug.withDosageList("Cisplatin", CisplatinDosages),
  Drug.withDosageList("Cyclophosphamide", CyclophosphamideDosages),
  Drug.withDosageList("Cytosar", CytosarDosages),
  Drug.withDosageList("Doxorubicin", DoxorubicinDosages),
  Drug.withDosageList("Melphalan", MelphalanDosages),
  Drug.withDosageList("Mitoxantrone", MitoxantroneDosages),
  Drug.withDosageList("Satraplatin", SatraplatinDosages),
  Drug.withDosageList("Vinblastine", VinblastineDosages),
  Drug.withDosageList("Vincristine", VincristineDosages),
  Drug.withDosageList("Vinorelbine", VinorelbineDosages),
  Drug.withDosageList("Other/Override...", OtherOverrideDosages)
];

RichText legalDisclaimerRichText = RichText(
  text: TextSpan(
    text: 'Not intended as medical advice. ',
    style: TextStyle(
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: Colors.black,
        fontSize: defaultFontSizeSmaller),
    children: <TextSpan>[
      TextSpan(
          text:
              'You acknowledge that the Application and incorporated Materials are to facilitate calculations only, and the decision of what drug to use and at what dosage is the sole responsibility of the treating clinician including monitoring for and treating any adverse effects that result from chemotherapy at any time. Illinois disclaims responsibility or liability for any loss or injury that may be incurred as a result of the use of the Application. You should always consult a veterinary oncologist or related specialist if diagnosis, treatment and/or advice is needed. Do not disregard professional advice or delay in seeking it due to your use of the Application.',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
          )),
    ],
  ),
);

Diagnosticable getThemeData(BuildContext context) {
  Diagnosticable theme;

  switch (platform) {
    case Platforms.android:
      theme = Theme.of(context)
          .copyWith(primaryColor: Colors.black, accentColor: primaryColor);

      break;
    case Platforms.ios:
      theme = CupertinoThemeData(
          primaryColor: CupertinoColors.white,
          primaryContrastingColor: primaryColor,
          barBackgroundColor: CupertinoColors.white,
          scaffoldBackgroundColor: CupertinoColors.white,
          textTheme: CupertinoTextThemeData(
            textStyle: baseTextStyle,
            actionTextStyle: actionTextStyle,
            navTitleTextStyle: titleTextStyle,
            navLargeTitleTextStyle: titleTextStyleLarger,
          ));

      break;
  }

  return theme;
}
