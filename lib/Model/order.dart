class Order {
  String firebaseId;
  String status; // 0: place,  1: confirm,  2: reject,  3: complete
  String instructions;
  String paymentMethod; // 0: card,  1: cash,  2: paypal
  String totalAmount;
  Order();

  Order.fromMap(Map map) {
    firebaseId = map["firebaseId"] ?? "Error In Loading";
    status = map["status"] ?? "0";
    instructions = map["instructions"] ?? "Not given";
    paymentMethod = map["paymentMethod"] ?? "1";
    totalAmount = map["totalAmount"] ?? "0.0";
  }
}