import 'package:flutter_local_notifications/flutter_local_notifications.dart';

showMyNotification() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
  var iOS = new IOSInitializationSettings();
  var initSetting = new InitializationSettings(android, iOS);
  flutterLocalNotificationsPlugin.initialize(initSetting,
      onSelectNotification: onselected);

  var dAndroid = new AndroidNotificationDetails(
      'M24', 'Siman', 'for the notification',
      playSound: false, importance: Importance.Max, priority: Priority.High);

  var dIos = new IOSNotificationDetails();
  var platform = new NotificationDetails(dAndroid, dIos);
  await flutterLocalNotificationsPlugin.show(
      5, "New Order!", "Tab and Accept the Order", platform,
      payload: "Open App and check it");
}

Future onselected(String payload) {
  // Navigator.of(context)
  //     .push(PageRouteBuilder(pageBuilder: (_, __, ___) => new MyOrders()));
}
