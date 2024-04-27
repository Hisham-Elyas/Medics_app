import 'dart:convert';
import 'dart:math';

import 'package:cuer_city/core/functions/show_coustom_snackbar.dart';
import 'package:cuer_city/core/services/services.dart';
import 'package:cuer_city/data/model/drugs_model.dart';
import 'package:get/get.dart';

import '../core/class/enums.dart';
import '../data/model/drugs_model/product.dart';
import '../data/repositories/drugs_repo.dart';

class DrugsController extends GetxController {
  final DrugsRepoImpHttp drugsRepo = Get.find();
  final MyServices myServ = Get.find();

  DrugsModel? drigsData2;
  List<Product> cartDrigs = [];

  final List<Product> randDrugsList = [];
  Map<String, Product> favoriteDrug = {};

  late StatusRequest statusReq;
  @override
  void onInit() async {
    super.onInit();

    await getAllDrougs();
    final cachedCart = myServ.sharedPreferences.getString('MY_CART');
    final cachedFavDrug = myServ.sharedPreferences.getString('MY_FAV_DRUGS');
    if (cachedCart != null) {
      final List cart = jsonDecode(cachedCart);
      cartDrigs = cart.map((e) => Product.fromJson(e)).toList();
    }
    if (cachedFavDrug != null) {
      final Map favDrug = jsonDecode(cachedFavDrug);
      favoriteDrug = favDrug.map((key, value) {
        return MapEntry(key, Product.fromJson(value));
      });
    }
    // print('onReady');
  }

  Future<void> getAllDrougs() async {
    statusReq = StatusRequest.loading;
    update();
    final dataD = await drugsRepo.getAllData();
    dataD.fold((l) {
      statusReq = l;
      update();
    }, (r) {
      drigsData2 = null;
      drigsData2 = r.$1;
      statusReq = r.$2;
      randDrugs(10);
      update();
    });
  }

  addTofavorite(Product drug) {
    if (favoriteDrug.containsKey(drug.id)) {
      favoriteDrug.removeWhere((key, value) => key == drug.id);
      myServ.sharedPreferences
          .setString('MY_FAV_DRUGS', jsonEncode(favoriteDrug));

      update();
    } else {
      favoriteDrug.addAll({drug.id!: drug});
      myServ.sharedPreferences
          .setString('MY_FAV_DRUGS', jsonEncode(favoriteDrug));
      // print(favoriteDrug.values.toList().length);
      update();
    }
  }

  isFavorite(Product drug) {
    if (favoriteDrug.containsKey(drug.id)) {
      return true;
    } else {
      return false;
    }
  }

  List<Product> randDrugs(int count) {
    for (var i = 0; i < count; i++) {
      randDrugsList
          .add(drigsData2!.product![Random().nextInt(drigsData2!.count!)]);
    }
    // print(drugsList.length);
    update();
    return randDrugsList;
  }

  List<Product> filter(String query) {
    List<Product> filter = [];
    // print(query);
    if (query == "") {
      // update();
      // print('1');
      return drigsData2!.product!;
    } else {
      // print('2');
      filter = drigsData2!.product!.where((element) {
        return element.name!.toUpperCase().startsWith(query.toUpperCase());
      }).toList();
      // update();
      return filter;
    }
  }

  addToCart(Product drigsinfo) {
    // cartDrigs.clear();
    if (cartDrigs.contains(drigsinfo)) {
      // print('finded');
      // print(cartDrigs.length);
      showCustomSnackBar(
          title: 'Drugs Item  💊',
          message: " Item have been added to cart! ❗",
          isError: true);
    } else {
      showCustomSnackBar(title: 'Drugs Item  💊', message: 'add to cart! ✅');
      // print('new');
      // print(cartDrigs.length);
      cartDrigs.add(drigsinfo);
      myServ.sharedPreferences.setString('MY_CART', jsonEncode(cartDrigs));
    }
  }

  deleteFromCart(drigsinfo) {
    if (cartDrigs.contains(drigsinfo)) {
      cartDrigs.removeWhere((element) => element == drigsinfo);
      myServ.sharedPreferences.setString('MY_CART', jsonEncode(cartDrigs));

      update();
      print('delet');
    } else {
      print('no');
    }
  }

  deleteAllCart() {
    cartDrigs.clear();
    myServ.sharedPreferences.remove('MY_CART');

    update();
  }

  deleteAllFav() {
    favoriteDrug.clear();
    myServ.sharedPreferences.remove('MY_FAV_DRUGS');

    update();
  }
}
