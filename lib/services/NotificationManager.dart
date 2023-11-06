import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
class NotificationManager {

  final String _couponChannel = "CouponKeep Notification Channel";

  //Notification IDs
  void updateNotificationId({int value=0})async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setInt("NotificationId", value<1?1:value);
  }
  Future<int> getNewNotificationId()async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int? id = _prefs.getInt("NotificationId");
    if(id==null){
      updateNotificationId();
      id = 1;
    }
    if(_prefs.getInt("NotificationId")!=null){
      id = _prefs.getInt("NotificationId");
    }
    return id!;
  }

  void createTextCouponNotification()async{
    int notificationId = await getNewNotificationId().then((value) => value);
    // Map<String,dynamic> c = coupon.toMap();
    // c.addAll({'notification':notificationId});
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationId,
        channelKey: _couponChannel,
        title: ' Coupon',
        body: 'R is about to Expire',
        notificationLayout: NotificationLayout.Default,
        payload: {'"coupon"': ""},
      ),
      schedule: NotificationCalendar.fromDate(date: DateTime.now(), allowWhileIdle: true),
    ).then((value) => updateNotificationId(value: notificationId+1));
  }

  /// Reschedule a notification
  void rescheduleTextCouponNotification(Map<String,dynamic> coupon)async{
    DateTime d = DateTime.parse(coupon['notificationDate']);
    int notificationId = await getNewNotificationId().then((value) => value);
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationId,
        channelKey: _couponChannel,
        title: '${coupon['retailer']} Coupon (Rescheduled)',
        body: 'R${coupon['value'].toString()} is about to Expire',
        notificationLayout: NotificationLayout.Default,
        payload: {'"coupon"': convert.jsonEncode(coupon)},
      ),
      schedule: NotificationCalendar.fromDate(date: d, allowWhileIdle: true),
    ).then((value) => updateNotificationId(value: notificationId+1));
  }

  /// Create GraphicCoupon Notification
  // void createGraphicCouponNotification(GraphicCoupon coupon)async{
  //   int notificationId = await getNewNotificationId().then((value) => value);
  //   await AwesomeNotifications().createNotification(
  //     content: NotificationContent(
  //       id: AwesomeNotifications.maxID,
  //       channelKey: _couponChannel,
  //       title: '${coupon.retailer} Coupon',
  //       body: 'R${coupon.value.toString()} is about to Expire',
  //       notificationLayout: NotificationLayout.BigPicture,
  //       bigPicture: coupon.mediaLink,
  //       payload: {
  //         '"coupon"': convert.jsonEncode(coupon.toMap())
  //       },
  //     ),
  //     schedule: NotificationCalendar.fromDate(
  //         date: coupon.notificationDate, allowWhileIdle: true),
  //   ).then((value) => updateNotificationId(value: notificationId+1));
  // }
  //
  // void rescheduleGraphicCouponNotification(Map<String,dynamic> c)async{
  //   GraphicCoupon coupon = GraphicCoupon.fromMap(c);
  //   int notificationId = await getNewNotificationId().then((value) => value);
  //   await AwesomeNotifications().createNotification(
  //     content: NotificationContent(
  //       id: notificationId,
  //       channelKey: _couponChannel,
  //       title: '${coupon.retailer} Coupon',
  //       body: 'R${coupon.value.toString()} is about to Expire',
  //       notificationLayout: NotificationLayout.BigPicture,
  //       bigPicture: coupon.mediaLink,
  //       payload: {
  //         '"coupon"': convert.jsonEncode(coupon.toMap())
  //       },
  //     ),
  //     schedule: NotificationCalendar.fromDate(
  //         date: coupon.notificationDate, allowWhileIdle: true),
  //   ).then((value) => updateNotificationId(value: notificationId+1));
  // }
  // Future<bool> clearAllNotifcations() async {
  //   await AwesomeNotifications().cancelAll();
  //   await AwesomeNotifications().cancelAllSchedules();
  //   return true;
  // }

}