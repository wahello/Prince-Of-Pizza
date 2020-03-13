import 'package:prince_of_pizza/Model/Item.dart';
import 'package:prince_of_pizza/Model/user.dart';

class MyGlobals {
  static User currentUser = new User();

  static Map extrasList = new Map();
  static List<Item> iteamsList = new List<Item>();

  static String clientNonce = " GET YOUR CLIENT NONCE FROM YOUR SERVER";

  static double countMoney() {
    double count = 0.0;
    for (Item i in MyGlobals.iteamsList) {
      count = count + i.price;
    }
    MyGlobals.extrasList.forEach((k, v) => count =
        count + double.parse(v.toString().substring(1, v.toString().length)));
    return count;
  }
}
