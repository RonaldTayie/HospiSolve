import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hospisolve/config/config.dart';
import 'package:hospisolve/firebase_options.dart';
import 'package:hospisolve/providers/QueueProvider.dart';
import 'package:hospisolve/views/LandingView.dart';
import 'package:hospisolve/views/pages/HomeView.dart';
import 'package:provider/provider.dart';

import 'RouteGenerator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Awesome notification initialization
  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
    'resource://drawable/notif_icon',
    [
      NotificationChannel(
        channelKey: NotificationChannelKey,
        channelName: NotificationChannelName,
        channelDescription: CounterNotification,
        defaultColor: AppTheme.primaryColorDark,
        ledColor: AppTheme.cardTheme.surfaceTintColor,
      )
    ],
  );
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp(
      title: 'Hospisolve',
    ));
  });
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return  SafeArea(
//         child:MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'Hospisolve',
//           theme: AppTheme,
//           themeMode: ThemeMode.dark,
//           home: const LoginView(),
//         )
//     );
//   }
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final StreamSubscription<ReceivedAction> action = AwesomeNotifications()
      .actionStream
      .listen((receivedNotification) => receivedNotification);

  Future isLoggedIn() async {
    return _auth.currentUser != null;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => QueueProvider())],
        child: MaterialApp(
          title: 'CouponKeep',
          debugShowCheckedModeBanner: false,
          initialRoute: "/",
          onGenerateRoute: RouteGenerator.generateRoute,
          theme: AppTheme,
          home: SafeArea(
            child: Scaffold(
              body: FutureBuilder(
                  future: isLoggedIn(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LandingView();
                    } else if (snapshot.connectionState == ConnectionState.done) {
                      bool result = snapshot.data as bool;
                      if (result == true) {
                        action.onData((receivedNotification) => {
                          if (Navigator.of(context).isCurrent("/notification")) {
                            // print("Replacing route");
                            Navigator.pushReplacementNamed(context, "/notification",
                                arguments: receivedNotification.payload)
                          } else {
                            if (Navigator.of(context).isCurrent("/")) {
                              // print("Push new route");
                              Navigator.pushNamed(context, "/notification",
                                  arguments: receivedNotification.payload)
                            } else {
                              // print("Replace current route.");
                              Navigator.pushReplacementNamed(
                                  context, "/notification",
                                  arguments: receivedNotification.payload)
                            }
                          }});
                        return const HomeView();
                      } else {
                        return const LandingView();
                      }
                    } else {
                      return const LandingView();
                    }
                  }),
            ),
          ),
        ));
  }
}
