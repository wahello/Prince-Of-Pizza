import 'package:prince_of_pizza/Model/Item.dart';
import 'package:prince_of_pizza/Model/order.dart';
import 'package:prince_of_pizza/Model/user.dart';

class MyGlobals {

  static String logo;
  static User currentUser = new User();

  static Map extrasList = new Map();
  static Order myOrder = new Order();
  static List<Item> iteamsList = new List<Item>();

  static String payKey = "rzp_test_m3uNnpSZoqkaLp";

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
