// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuer_city/d/d.dart';
import 'package:dartz/dartz_unsafe.dart';

import 'alldata.dart';
import 'd/drug_information_ar.dart';
import 'd/drug_information_en.dart';
import 'package:get/get.dart';

import 'data/model/drugs_model.dart';

final List<D> drugstest = drugs2.map((e) => D.fromJson(e)).toList();
final List<D> drugstestNew = [];
String? artradeName;
String? arstrength;
String? argenericName;
String? ardosageForm;
String? arrouteOfAdministration;
String? arsfdaCode;
String? arpacakgeSize;

String? entradeName;
String? enstrength;
String? engenericName;
String? endosageForm;
String? enrouteOfAdministration;
String? ensfdaCode;
String? enpacakgeSize;

String? images;
String? pdf;

class ApiClent extends GetConnect {
  ApiClent();

  Future<Response> PosData(String uri, dynamic body) async {
    try {
      Response response = await post(uri, body);
      // print('========================response===========================');
      // print(response.statusText);
      // print(response.statusCode);
      // print(response.toString());
      // print('========================response===========================');
      return response;
    } catch (e) {
      // print('========================errror===========================');
      // print(e.toString());
      // print('========================errror===========================');
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> GetData(String uri, {Map<String, String>? headers}) async {
    try {
      Response response = await get(uri);
      // print('========================response===========================');
      // print(response.statusText);
      // print(response.statusCode);
      // print(response.toString());
      // print('========================response===========================');
      return response;
    } catch (e) {
      // print('========================errror===========================');
      // print(e);
      // print('========================errror===========================');
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}

drugslistF() async {
  // print(drugs1Test.length);
  // drugstestNew.clear();

  var prod = 0;
/** 
  allDrags.forEach((element) {
    prod++;
    var cont = 1;
    element.forEach((key, value) {
      if (cont == 1) {
        cont++;
        // print(
        //     '========================Start-AR${cont++}==========================');
        final h = jsonDecode(jsonEncode(value));
        var hAR = h['معلومات الدواء'];
        artradeName = hAR["الاسم التجاري"];
        arstrength = hAR["التركيز"];
        argenericName = hAR["الاسم العلمي"];
        ardosageForm = hAR["الشكل الصيدلاني"];
        arrouteOfAdministration = hAR["طريقة أخذ الدواء"];
        arsfdaCode = hAR["رقم التسجيل"];
        arpacakgeSize = hAR["حجم العبوة"];
        // print('+++++++++++');
        // print(h['معلومات الدواء']["الاسم التجاري"]);
        // print('+++++++++++');
        // h.forEach((key, value) {
        // print('==$key==');
        // var no = 0;

        // value.forEach((key, value) {
        // no++;
        // print(no);
        // print('${key}  :  ' + value);
        // });
        // });

        // print('==========================end=========================');
      } else if (cont == 2) {
        cont++;
        // print(
        // '========================Start-EN${cont++}==========================');

        final h = jsonDecode(jsonEncode(value));
        // var hEN = h['Drug Information'];
        // print(h);

        entradeName = h['Trade Name'];
        enstrength = h["Strength"];
        engenericName = h["Generic Name"];
        endosageForm = h["Dosage Form"];
        enrouteOfAdministration = h["Route of Administration"];
        ensfdaCode = h["SFDA Code"];
        enpacakgeSize = h["Pacakge Size"];

        // print('==$key==');

        // h.forEach((key, value) {
        // print(key + '  :  ' + value);
        // });
        // print('==========================end=========================');
      } else {
        // print(key + ':' + value.toString());

        if (key == 'images') {
          images = value.toString();
        } else if (key == 'pdf') {
          pdf = value.toString();
        }
      }
      // cont++;
    });

    // print(artradeName);
    // print(entradeName);
    drugstestNew.add(D(
        drugInformationAr: DrugInformationAr(
          tradeName: artradeName,
          dosageForm: ardosageForm,
          genericName: ardosageForm,
          pacakgeSize: arpacakgeSize,
          routeOfAdministration: arrouteOfAdministration,
          sfdaCode: arsfdaCode,
          strength: arstrength,
        ),
        drugInformationEn: DrugInformationEn(
          tradeName: entradeName,
          dosageForm: endosageForm,
          genericName: endosageForm,
          pacakgeSize: enpacakgeSize,
          routeOfAdministration: enrouteOfAdministration,
          sfdaCode: ensfdaCode,
          strength: enstrength,
        ),
        images: images,
        pdf: pdf));
    print('+++++++++++');
    print('$prod   drugs Add  ');
    print(drugstestNew[prod - 1].drugInformationAr!.tradeName);
    print(drugstestNew[prod - 1].drugInformationEn!.tradeName);
    // print('+++++++++++');
  });
*/
  try {
    // drugstestNew.forEach((element) async {
    // print(element.drugInformationAr!.tradeName);
    final h = await ApiClent().GetData('http://192.168.3.227:3000/drugs');

    ///192.168.3.227
    print('+++++++++++');
    // print('#   ${element.drugInformationEn!.tradeName} drugs Add  ');
    final dataD = DrugsModel.fromJson(h.body);

    print(dataD.count);
    print(h.statusCode);
    print('ok');
    // print(h.body);
    print('+++++++++++');
    // });
  } catch (e) {
    print(e.toString());
  }

  // print(drugstestNew.length);
  // print(drugstestNew[100].drugInformationEn!.tradeName);

  // drugstestNew.clear();
}

final drugs1Test = [
  {
    "ACC": {
      "معلومات الدواء": {
        "الاسم التجاري": "إيه سي سي",
        "التركيز": "600 مليجرام",
        "الاسم العلمي": "أسيتيل سيستين",
        "الشكل الصيدلاني": "أقراص فوّار",
        "طريقة أخذ الدواء": "عن طريق الفم",
        "رقم التسجيل": "7-349-09",
        "حجم العبوة": "10"
      }
    },
    "Drug Information": {
      "Trade Name": "ACC",
      "Strength": "600 MG",
      "Generic Name": "acetylcysteine",
      "Dosage Form": "EFFERVESCENT TABLETS",
      "Route of Administration": "ORAL",
      "SFDA Code": "7-349-09",
      "Pacakge Size": "10’S"
    },
    "images": "https://wasfaty.sa/wp-content/uploads/2021/12/nondrugimg.jpg",
    "pdf": ""
  },
  {
    "ACCU-CHEK INSTANT": {
      "معلومات الدواء": {
        "الاسم التجاري": "أكيو-تشيك إنستانت",
        "التركيز": "Strength",
        "جهاز قياس مستوى السكر الاسلكي": "GLUCOMETER IT INTEGRATED",
        "DEVICE": "Dosage Form",
        "رقم التسجيل": "7819340078",
        "حجم العبوة": "1",
        "معلومات الدواء": "Drug Information"
      }
    },
    "Drug Information": {
      "Trade Name": "ACCU-CHEK INSTANT",
      "جهاز قياس مستوى السكر الاسلكي": "الاسم العلمي",
      "جهاز": "الشكل الصيدلاني",
      "Route of Administration": "طريقة أخذ الدواء",
      "SFDA Code": "7819340078",
      "Package Size": "1’S",
      "Pacakge Size": "الاسم التجاري"
    },
    "images":
        "https://wasfaty.sa/wp-content/uploads/2023/10/07819340078_ACCU-CHECKDEVICE_PIC_ANGLE_EN_OCT.jpg",
    "pdf": ""
  },
];

final drugs2 = [
  {
    "drugInformationAr": {
      "Trade Name": "1 إيه سي سي",
      "Strength": "600 مليجرام",
      "Generic Name": "أسيتيل سيستين",
      "Dosage Form": "أقراص فوّار",
      "Route of Administration": "عن طريق الفم",
      "SFDA Code": "7-349-09",
      "Pacakge Size": "10"
    },
    "drugInformationEn": {
      "Trade Name": "1ACC",
      "Strength": "600 MG",
      "Generic Name": "acetylcysteine",
      "Dosage Form": "EFFERVESCENT TABLETS",
      "Route of Administration": "ORAL",
      "SFDA Code": "7-349-09",
      "Pacakge Size": "10’S"
    },
    "images": "https://wasfaty.sa/wp-content/uploads/2021/12/nondrugimg.jpg",
    "pdf": ""
  },
  {
    "drugInformationAr": {
      "Trade Name": "أسيتاب",
      "Strength": "25 مليجرام",
      "Generic Name": "كابتوبريل",
      "Dosage Form": "أقراص",
      "Route of Administration": "عن طريق الفم",
      "SFDA Code": "7-349-09",
      "Pacakge Size": "30"
    },
    "drugInformationEn": {
      "Trade Name": "ACETAB",
      "Strength": "25 MG",
      "Generic Name": "caPTOPRil",
      "Dosage Form": "TABLETS",
      "Route of Administration": "ORAL",
      "SFDA Code": "50-352-04",
      "Pacakge Size": "30"
    },
    "images":
        "https://wasfaty.sa/wp-content/uploads/2023/10/50-352-04_ACETAB_PIC_ANGLE_EN_OCT.jpg",
    "pdf":
        "https://wasfaty.sa/wp-content/uploads/2023/10/50-352-04_ACETAB_PIL_AR_OCT.pdf"
  },
  {
    "drugInformationAr": {
      "Trade Name": "أسيلوك",
      "Strength": "20 مليجرام",
      "Generic Name": "أوميبرازول",
      "Dosage Form": "كبسولات",
      "Route of Administration": "عن طريق الفم",
      "SFDA Code": "7-349-09",
      "Pacakge Size": "14"
    },
    "drugInformationEn": {
      "Trade Name": "ACILOC",
      "Strength": "20 MG",
      "Generic Name": "omeprazole",
      "Dosage Form": "CAPSULES",
      "Route of Administration": "ORAL",
      "SFDA Code": "61-368-04",
      "Pacakge Size": "14"
    },
    "images":
        "https://wasfaty.sa/wp-content/uploads/2023/10/61-368-04_ACILOC_PIC_ANGLE_AR_OCT.jpg",
    "pdf": ""
  },
  {
    "drugInformationAr": {
      "Trade Name": "أسيلوك",
      "Strength": "20 مليجرام",
      "Generic Name": "أوميبرازول",
      "Dosage Form": "كبسولات",
      "Route of Administration": "عن طريق الفم",
      "SFDA Code": "7-349-09",
      "Pacakge Size": "7"
    },
    "drugInformationEn": {
      "Trade Name": "ACILOC",
      "Strength": "20 MG",
      "Generic Name": "omeprazole",
      "Dosage Form": "CAPSULES",
      "Route of Administration": "ORAL",
      "SFDA Code": "61-368-04",
      "Pacakge Size": "7"
    },
    "images":
        "https://wasfaty.sa/wp-content/uploads/2023/10/62-368-04_ACILOC_PIC_FRONT_EN_OCT.jpg",
    "pdf": ""
  },
  {
    "drugInformationAr": {
      "Trade Name": "أكنيزول",
      "Strength": "5%",
      "Generic Name": "بنزويل بيروكسايد",
      "Dosage Form": "جل",
      "Route of Administration": "للإستخدام الخارجي",
      "SFDA Code": "7-349-09",
      "Pacakge Size": "30 جرام"
    },
    "drugInformationEn": {
      "Trade Name": "ACNEZOYL",
      "Strength": "5%",
      "Generic Name": "benzoyl peroxide",
      "Dosage Form": "GEL",
      "Route of Administration": "TOPICAL",
      "SFDA Code": "36-368-02",
      "Pacakge Size": "30G"
    },
    "images":
        "https://wasfaty.sa/wp-content/uploads/2023/10/36-368-02_ACNEZOYL_PIC_ANGLE_AR_OCT.jpg",
    "pdf": ""
  },
  {
    "drugInformationAr": {
      "Trade Name": "أكرتين",
      "Strength": "0.05%",
      "Generic Name": "تريتينوين",
      "Dosage Form": "كريم",
      "Route of Administration": "للإستخدام الخارجي",
      "SFDA Code": "7-349-09",
      "Pacakge Size": "30 جرام"
    },
    "drugInformationEn": {
      "Trade Name": "ACRETIN",
      "Strength": "0.05%",
      "Generic Name": "tretinoin",
      "Dosage Form": "CREAM",
      "Route of Administration": "TOPICAL",
      "SFDA Code": "8-368-00",
      "Pacakge Size": "30G"
    },
    "images":
        "https://wasfaty.sa/wp-content/uploads/2023/10/8-368-00_ACRETIN_PIC_ANGLE_AR_OCT.jpg",
    "pdf": ""
  },
  {
    "drugInformationAr": {
      "Trade Name": "أكرتين",
      "Strength": "0.03%",
      "Generic Name": "تريتينوين",
      "Dosage Form": "كريم",
      "Route of Administration": "للإستخدام الخارجي",
      "SFDA Code": "7-349-09",
      "Pacakge Size": "30 جرام"
    },
    "drugInformationEn": {
      "Trade Name": "ACRETIN",
      "Strength": "0.03%",
      "Generic Name": "tretinoin",
      "Dosage Form": "CREAM",
      "Route of Administration": "TOPICAL",
      "SFDA Code": "8-368-00",
      "Pacakge Size": "30G"
    },
    "images":
        "https://wasfaty.sa/wp-content/uploads/2023/10/9-368-00_ACRETIN_PIC_ANGLE_AR_OCT.jpg",
    "pdf": ""
  },
  {
    "drugInformationAr": {
      "Trade Name": "أكتوس",
      "Strength": "15 مليجرام",
      "Generic Name": "بيوجليتازون",
      "Dosage Form": "أقراص",
      "Route of Administration": "عن طريق الفم",
      "SFDA Code": "7-349-09",
      "Pacakge Size": "30 "
    },
    "drugInformationEn": {
      "Trade Name": "ACTOS",
      "Strength": "15 MG",
      "Generic Name": "pioglitazone (as hcl)",
      "Dosage Form": "TABLETS",
      "Route of Administration": "ORAL",
      "SFDA Code": "117-119-04",
      "Pacakge Size": "30"
    },
    "images":
        "https://wasfaty.sa/wp-content/uploads/2023/10/117-119-04_ACTOS_PIC_ANGLE_AR_OCT.jpg",
    "pdf": ""
  },
  {
    "drugInformationAr": {
      "Trade Name": "اكترابيد",
      "Strength": "100 وحدة لكل مليلتر",
      "Generic Name": "إنسولين بشري",
      "Dosage Form": "قارورة",
      "Route of Administration": "حقنة تحت الجلد",
      "SFDA Code": "7-349-09",
      "Pacakge Size": "10مل"
    },
    "drugInformationEn": {
      "Trade Name": "ACTRAPID",
      "Strength": "100 U/ML",
      "Generic Name": "insulin – soluble (human)",
      "Dosage Form": "VIAL",
      "Route of Administration": "SUBCUTANEOUS",
      "SFDA Code": "9-100-89",
      "Pacakge Size": "10ML"
    },
    "images":
        "https://wasfaty.sa/wp-content/uploads/2023/10/9-100-89_ACTRAPID_PIC_Front_AR_OCT.jpg",
    "pdf":
        "https://wasfaty.sa/wp-content/uploads/2023/10/9-100-89_ACTRAPID_PIL_AR_OCT.pdf"
  },
];
