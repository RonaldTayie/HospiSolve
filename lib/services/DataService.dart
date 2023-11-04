import 'dart:async';
import 'dart:io';
import 'dart:convert' as convert;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'NotificationManager.dart';

class DataService {
  // plugins
  late SharedPreferences _prefs;
  final NotificationManager _notificationManager = NotificationManager();
  // is Connected variable
  Future<bool> isConnected() async {
    try {
      final response = await InternetAddress.lookup('google.com');
      if (response.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  // Init because the constructor an not be async
  init() async {
    _prefs = await SharedPreferences.getInstance();
    await isConnected() ? pushNewAppended() : null;
  }

  //constructor
  DataService(){
  }

  /*
  *  Coupon Format;
  *  We will search for the coupon using the coupon using its id,
  *  such that the key to every stored coupon is a string and the value is a Map
  *  with the actual coupon data.
  *
  *   Output Example: {
  *     "coupon uid UUID result": {
  *       "CouponObject Map"
  *     }
  *   }
  *   This meant that we will return a Map of coupon which we will index using
  *   the key which corresponds to the id if the coupon
  *
  * */

  Future<List<Map<String, dynamic>>> getCoupons(String type) async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs.getKeys().contains(type)) {
      String storedJsonString = _prefs.getString(type)!;
      Map<String, dynamic> storedJson = convert.jsonDecode(storedJsonString);
      List<Map<String, dynamic>> mapList = [];
      storedJson.forEach((key, value) {
        mapList.add(value);
      });
      return mapList;
    } else {
      return [];
    }
  }

  Future<void> downloadCoupons() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    List<String> types = ["Link", "Pin", "qr_code"];

    Map<String,dynamic> coupons = {};

    types.forEach((type) async {
      Map<String,dynamic> couponMap = {};

      // CollectionReference<Map<String, dynamic>> mapList =
      // _firestore.collection('Coupons').doc(uid).collection(type);
      // QuerySnapshot<Map<String, dynamic>> snaps =
      // await mapList.orderBy('dateAdded', descending: true).get();
      // if (snaps.size > 0) {
      //   Iterable<Map<String, dynamic>> documentSnapshot =
      //   snaps.docs.map((e) => e.data());
      //   for (Map<String, dynamic> element in documentSnapshot) {
      //     couponMap.addAll({element['id']:element});
      //   }
      //   /// Save the coupon Map locally
      //   _prefs.setString(type, convert.jsonEncode(couponMap));
      // }
    });
  }

  Future<bool> saveCouponLocally(Map<String, dynamic> coupon) async {
    _prefs = await SharedPreferences.getInstance();
    Map<String, Map<String, dynamic>> c = {coupon['id']: coupon};
    String? storedJson = _prefs.getString(coupon['type']);
    if (_prefs.getKeys().contains(coupon['type'])) {
      if (storedJson != null) {
        Map<String, dynamic> storedCoupons = convert.jsonDecode(storedJson);
        storedCoupons.addAll(c);
        _prefs.setString(coupon['type'], convert.jsonEncode(storedCoupons));
      }
    } else {
      await _prefs.setString(coupon['type'], convert.jsonEncode(c));
    }
    return true;
  }

  Future<void> localDelete(String type, String id) async {
    _prefs = await SharedPreferences.getInstance();
    String? storedJson = _prefs.getString(type);
    if (storedJson != "") {
      Map<String, dynamic> storedCoupons = convert.jsonDecode(storedJson!);
      if (storedCoupons.containsKey(id)) {
        storedCoupons.remove(id);
        _prefs.setString(type, convert.jsonEncode(storedCoupons));

        /// After the coupon has been Deleted we will need to store the id of the coupon to delete when we sync everything
        await isConnected() ? offlineDeletedCoupons(type, id) : null;
      }
    }
  }

  Future<bool> appendTillOnline(String type, String id) async {
    _prefs = await SharedPreferences.getInstance();
    String? storedJson = _prefs.getString('OfflineAppend');
    if (storedJson != null) {
      Map<String, dynamic> storedAppendList = convert.jsonDecode(storedJson);
      if (storedAppendList.containsKey(type)) {
        List<dynamic> stored = convert.jsonDecode(storedAppendList[type]);
        stored.add(id);
        storedAppendList[type] = convert.jsonEncode(stored);
      } else {
        storedAppendList.addAll({
          type: convert.jsonEncode([id])
        });
      }
      await _prefs.setString(
          'OfflineAppend', convert.jsonEncode(storedAppendList));
    } else {
      await _prefs.setString(
          'OfflineAppend',
          convert.jsonEncode({
            type: convert.jsonEncode([id])
          }));
      return true;
    }
    return false;
  }

  // this method will store the type and ID of the coupon deleted while offline
  Future<void> offlineDeletedCoupons(String type, String id) async {
    _prefs = await SharedPreferences.getInstance();
    String? storedJson = _prefs.getString('offlineDeleted');
    if (storedJson != null) {
      Map<String, dynamic> storedDeleteList = convert.jsonDecode(storedJson);
      if (storedDeleteList.containsKey(type)) {
        List<dynamic> stored = convert.jsonDecode(storedDeleteList[type]);
        stored.add(id);
        storedDeleteList[type] = convert.jsonEncode(stored);
      } else {
        storedDeleteList.addAll({
          type: convert.jsonEncode([id])
        });
      }
      await _prefs.setString(
          'offlineDeleted', convert.jsonEncode(storedDeleteList));
    } else {
      await _prefs.setString(
          'offlineDeleted',
          convert.jsonEncode({
            type: convert.jsonEncode([id])
          }));
    }
  }

  Future<void> pushNewAppended() async {
    _prefs = await SharedPreferences.getInstance();
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String? offlineAppendJsonString = _prefs.getString('OfflineAppend');
    if (offlineAppendJsonString != null) {
      /// Get the offline appended Map
      Map<String, dynamic> offlineAppendJson =
      convert.jsonDecode(offlineAppendJsonString);

      /// Get the coupon types from the keys
      List<String> couponTypes = offlineAppendJson.keys.toList();

      /// For each coupon types Item get the corresponding coupons and search by ID
      couponTypes.forEach((type) async {
        ///Get coupon of a particular type
        List<Map<String, dynamic>> coupons = await getCoupons(type);

        /// Iteration type couponId list
        List<dynamic> couponIds = convert.jsonDecode(offlineAppendJson[type]);

        /// For each coupon if the id is in the offlineAppend ID list, ush the coupon to firebase firestore DB
        coupons.forEach((element) async {
          if (couponIds.contains(element['id'])) {
            // Pull in firebase and write the data
            // await _firestore
            //     .collection('Coupons')
            //     .doc(uid)
            //     .collection(type)
            //     .doc(element['id'])
            //     .set(element);
          }
        });
      });
      // when done delete everything from the OfflineAppend key
      _prefs.remove('OfflineAppend');
    } else {}
  }

  /// Offline Used couponList
  /*
  * Keep a list of coupons used while offline
  * */

  // Updated locally stored coupon to used
  void updateCouponToUsed(String type, String id) async {
    _prefs = await SharedPreferences.getInstance();
    String? storedJson = _prefs.getString(type);
    if (storedJson != "") {
      Map<String, dynamic> storedCoupons = convert.jsonDecode(storedJson!);
      if (storedCoupons.isNotEmpty) {
        if (storedCoupons.containsKey(id)) {
          storedCoupons[id]['used'] = true;
          _prefs.setString(type, convert.jsonEncode(storedCoupons));
        }
      }
    }
  }

  /// Store Coupons used while offline
  void offlineUsedCoupon(String type, String id) async {
    _prefs = await SharedPreferences.getInstance();
    String? storedJson = _prefs.getString('offlineUsed');
    if (storedJson != null) {
      Map<String, dynamic> storedUsedList = convert.jsonDecode(storedJson);
      if (storedUsedList.containsKey(type)) {
        List<dynamic> stored = convert.jsonDecode(storedUsedList[type]);
        stored.contains(id) ? null : stored.add(id);
        storedUsedList[type] = convert.jsonEncode(stored);
      } else {
        storedUsedList.addAll({
          type: convert.jsonEncode([id])
        });
      }
      await _prefs.setString('offlineUsed', convert.jsonEncode(storedUsedList));
    } else {
      await _prefs.setString(
          'offlineUsed',
          convert.jsonEncode({
            type: convert.jsonEncode([id])
          }));
    }
  }

  /// Sync Used Coupons with online coupons
  void syncUsedCoupons() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    _prefs = await SharedPreferences.getInstance();

    /// Get the offline stored coupon json string
    String? storedJson = _prefs.getString('offlineUsed');
    if (storedJson != null) {
      /// Convert the json string to Map
      Map<String, dynamic> stored = convert.jsonDecode(storedJson);
      if (stored.isNotEmpty) {
        /// Get the keys
        Iterable<String> types = stored.keys;

        /// For each coupon type
        types.forEach((type) {
          List<dynamic> couponIds = convert.jsonDecode(stored[type]);

          /// if the type exists or has been stored
          if (couponIds.isNotEmpty) {
            /// For each coupon ID
            // couponIds.forEach((element) async {
            //   /// Update the coupon on firebase Databse
            //   await _firestore
            //       .collection('Coupons')
            //       .doc(uid)
            //       .collection(type)
            //       .doc(element)
            //       .update({'used': true});
            // });
          }
        });
      }
    }
  }

  /// Reschedule notification

  void offlineRescheduledCoupon(String type, String id, DateTime date) async {
    _prefs = await SharedPreferences.getInstance();
    String? storedJson = _prefs.getString('offlineRescheduled');
    if (storedJson != null) {
      Map<String, dynamic> storedUsedList = convert.jsonDecode(storedJson);
      if (storedUsedList.containsKey(type)) {
        List<dynamic> stored = convert.jsonDecode(storedUsedList[type]);
        stored.contains(id)
            ? null
            : stored.add({'id': id, 'notificationDate': date.toString()});
        storedUsedList[type] = convert.jsonEncode(stored);
      } else {
        storedUsedList.addAll({
          type: convert.jsonEncode([
            {'id': id, 'notificationDate': date.toString()}
          ])
        });
      }
      await _prefs.setString(
          'offlineRescheduled', convert.jsonEncode(storedUsedList));
    } else {
      await _prefs.setString(
          'offlineRescheduled',
          convert.jsonEncode({
            type: convert.jsonEncode([
              {'id': id, 'notificationDate': date.toString()}
            ])
          }));
    }
  }

  /// Sync Used Coupons with online coupons
  void syncRescheduledCoupons() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    _prefs = await SharedPreferences.getInstance();

    /// Get the offline stored coupon json string
    String? storedJson = _prefs.getString('offlineRescheduled');
    if (storedJson != null) {
      /// Convert the json string to Map
      Map<String, dynamic> stored = convert.jsonDecode(storedJson);
      if (stored.isNotEmpty) {
        /// Get the keys
        Iterable<String> types = stored.keys;

        /// For each coupon type
        types.forEach((type) {
          List<dynamic> couponIds = convert.jsonDecode(stored[type]);

          /// if the type exists or has been stored
          if (couponIds.isNotEmpty) {
            /// For each coupon ID
            // couponIds.forEach((element) async {
            //   /// Update the coupon on firebase Database
            //   await _firestore
            //       .collection('Coupons')
            //       .doc(uid)
            //       .collection(type)
            //       .doc(element)
            //       .update({'notificationDate': element['notificationDate']});
            // });
          }
        });
      }
    }
  }
  /// Reschedule Notification
  void rescheduleNotification(String type, String id, DateTime date) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    _prefs = await SharedPreferences.getInstance();
    String? storedJson = _prefs.getString(type);
    if (storedJson != null) {
      Map<String, dynamic> json = convert.jsonDecode(storedJson);
      if (json.keys.contains(id)) {
        json[id]['notificationDate'] = date.toString();
        _prefs.setString(type, convert.jsonEncode(json));
        //reschedule the coupon
        if (type != "qr_code") {
          _notificationManager.rescheduleTextCouponNotification(json[id]);
        } else {
          // _notificationManager.rescheduleGraphicCouponNotification(json[id]);
        }
        syncRescheduledCoupons();
        return;
      }
    }
    return;
  }
}