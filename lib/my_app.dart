import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homez/core/helpers/cache_helper.dart';
import 'package:homez/features/splash/view.dart';

import 'core/helpers/navigator.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _requestPermission();
    _getDeviceToken();
    checkPlatform();
  }

  void _requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void _getDeviceToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    CacheHelper.put(key: 'deviceToken', value: token);
    print("Device Token: $token");
  }

  void checkPlatform() {
    if (Platform.isAndroid) {
      CacheHelper.put(key: 'deviceType', value: 'android');
    } else if (Platform.isIOS) {
      CacheHelper.put(key: 'deviceType', value: 'ios');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
          child: MaterialApp(
            title: "Home Z",
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            home: child,
          ),
        );
      },
      child: const SplashView(),
    );
  }
}
