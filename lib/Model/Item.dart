
import 'package:random_string/random_string.dart';

class Item {

  String subCatagory;
  Map<String,Map<String,String>> optional;
  String requirments;
  int quantity;
  double price;
  String catagory;

  Item({
    this.catagory,
    this.subCatagory,
    this.quantity,
    this.price,
    this.optional,
    this.requirments
  });

  static Map convert(List<Item> list)
  {
    Map<String, Object> alldata = Map<String, Object>();
    for (Item item in list) {
      Map<String, Object> data = Map<String, Object>();
      data["catagory"] = item.catagory;
      data["subCatagory"] = item.subCatagory;
      data["quantity"] = item.quantity;
      data["price"] = item.price;
      data["optional"] = item.optional;
      data["requirments"] = item.requirments;
      alldata[randomAlpha(5)] = data;
    }
    return alldata;
  }

}
