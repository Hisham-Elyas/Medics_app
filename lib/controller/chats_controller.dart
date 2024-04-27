import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatsController extends GetxController {
  String massages = "";

  final TextEditingController textEditingCont = TextEditingController();
  List<String> msList = [
    "chapter cow sand last nose youth original below dull branch hearing wind duty",
    "flower dot sun dream important journey blind live castle event path held money",
    "wonder winter sudden planning chart grade move spirit upward root joined post due neighbor sold talk language fed canal world through proper standard identity",
    "it thread became bag highway little rapidly whale ourselves bound cloud spent energy",
    "blanket buried knife verb mean thy soap unknown cream habit applied white visitor tight slipped stairs pan cut circle gift tribe missing blow lunch",
    "too red reader card immediately burst luck mad rise bound bell lunch sight",
    "cave dress length face lose sell reader function knife combination itself due interest",
    "hunt paid fought ahead hungry care identity process page stems whom hunter smooth carry program driving slip generally drove also dangerous everybody game drew",
    "branch moment or airplane setting shaking birds mill got egg graph shine cast",
    "left aside board built pack operation arrangement declared pile everything can forty interest",
    "human learn police seat mind trunk wish dress tired club coal give thus would can ball taste cattle expect planned story settlers plastic angle",
    "remain birth danger skin found bottle guide habit draw cannot adult upper proper",
    "greatly bicycle opinion notice quiet cap fallen red respect tide appropriate mad origin",
    "dinner danger share older measure color tropical paragraph speech price pour aloud buffalo sale constantly map eaten where of learn show control natural object",
    "fast frighten free border hunter brush light distance wooden storm grandmother press century",
    "chemical motion bag produce rice blow scared practice reason feature industry around shorter music frequently sheep couple ants science replied contrast realize rush movie",
    "bar actually double quiet canal life funny course because begun little if step",
  ];

  final List messagelist = [
    {
      "_id": "66241227d543e681347f035c",
      "properties": ["d1", "u1"],
      "sender": "U1",
      "text": "hi dr 1",
      "createdAt": "2024-04-20T19:06:15.632Z",
      "updatedAt": "2024-04-20T19:06:15.632Z"
    },
    {
      "_id": "6624123ed543e681347f035e",
      "properties": ["d1", "u1"],
      "sender": "D1",
      "text": "hi u1  how can h u",
      "createdAt": "2024-04-20T19:06:38.565Z",
      "updatedAt": "2024-04-20T19:06:38.565Z"
    },
    {
      "_id": "66241254d543e681347f0360",
      "properties": ["d1", "u1"],
      "sender": "U1",
      "text": "thx dr 1",
      "createdAt": "2024-04-20T19:07:00.119Z",
      "updatedAt": "2024-04-20T19:07:00.119Z"
    },
    {
      "_id": "66241278d543e681347f0362",
      "properties": ["d2", "u1"],
      "sender": "U1",
      "text": "i mess u dr 2",
      "createdAt": "2024-04-20T19:07:36.732Z",
      "updatedAt": "2024-04-20T19:07:36.732Z"
    },
    {
      "_id": "6624128bd543e681347f0364",
      "properties": ["d2", "u1"],
      "sender": "D2",
      "text": "me to u 1",
      "createdAt": "2024-04-20T19:07:55.978Z",
      "updatedAt": "2024-04-20T19:07:55.978Z"
    }
  ];

  test() {
    final h = messagelist.where((element) {
      element["properties"].contains('u1');

      return element["properties"].contains('u1') &&
          element["properties"].contains('d1');
    });
    print(h.length);
  }

  setMassages(String value) {
    massages = value;
    update();
  }

  sendMassages() {
    test();
    msList.add(massages);
    textEditingCont.clear();
    update();
  }
}
