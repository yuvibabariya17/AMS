// import 'dart:io';
// import 'package:animated_theme_switcher/animated_theme_switcher.dart';
// import 'package:booking_app/Screens/SplashScreen/SplashScreen.dart';
// import 'package:booking_app/core/Common/Common.dart';
// import 'package:booking_app/core/utils/log.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:hive/hive.dart';
// import 'package:sizer/sizer.dart';
// import 'controllers/internet_controller.dart';
// import 'controllers/theme_controller.dart';
// import 'core/constants/get_storage_key.dart';
// import 'core/constants/strings.dart';
// import 'core/themes/app_theme.dart';
// import 'package:path_provider/path_provider.dart' as path_provider;

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
//   Hive.init(appDocumentDir.path);
//   final storageBox = Hive.openBox<int>(Strings.storeDarkMode);
//   Get.lazyPut(() => storageBox);
//   Get.lazyPut(() => ThemeController(storageBox: Get.find()));
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final intenetController = Get.put(InternetController(), permanent: true);

//   // Future<void> initHive() async {
//   //   isDarkMode = Get.find<ThemeController>().isDarkMode!.value;
//   //   setState(() {
//   //   });
//   //   logcat("SELECTED_MODE", isDarkMode!.toString());
//   // }

//   @override
//   void initState() {
//     //initHive();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Get.lazyPut<InternetController>(() => InternetController());

//     // Get.lazyPut<ThemeController>(() => ThemeController());
//     // int isDarkMode = Get.find<ThemeController>().isDarkMode!.value;
//     int isDarkMode = 1;
//     logcat("isDarkModeMain", isDarkMode.toString());
//     Common().trasparent_statusbar();
//     return FutureBuilder(
//       future: _init(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           return Sizer(
//             builder: (context, orientation, deviceType) {
//               return ThemeProvider(
//                 initTheme:
//                     isDarkMode == 1 ? AppTheme.lightTheme : AppTheme.darkTheme,
//                 child: Builder(builder: (context) {
//                   return GetBuilder<ThemeController>(
//                     init: ThemeController(),
//                     builder: (ctr) {
//                       return GetMaterialApp(
//                         title: CommonConstant.ams,
//                         theme: isDarkMode == 1
//                             ? ThemeData.light(useMaterial3: true)
//                             : ThemeData.dark(useMaterial3: true),
//                         debugShowCheckedModeBanner: false,
//                         home: Splashscreen(),
//                         defaultTransition: Transition.rightToLeftWithFade,
//                       );
//                     },
//                   );
//                 }),
//               );
//             },
//           );
//         } else {
//           return CircularProgressIndicator();
//         }
//       },
//     );
//   }

//   Future<void> _init() async {
//     await GetStorage.init();
//   }
// }

import 'dart:io';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:booking_app/Screens/SplashScreen/SplashScreen.dart';
import 'package:booking_app/core/Common/Common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'controllers/internet_controller.dart';
import 'controllers/theme_controller.dart';
import 'core/constants/get_storage_key.dart';
import 'core/constants/strings.dart';
import 'core/themes/app_theme.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final intenetController = Get.put(InternetController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    Get.lazyPut<InternetController>(() => InternetController());
    Get.lazyPut<ThemeController>(() => ThemeController());
    final getStorage = GetStorage();
    int isDarkMode = getStorage.read(GetStorageKey.IS_DARK_MODE) ?? 1;
    getStorage.write(GetStorageKey.IS_DARK_MODE, isDarkMode);
    Common().trasparent_statusbar();
    return FutureBuilder(
      future: _init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Sizer(
            builder: (context, orientation, deviceType) {
              return ThemeProvider(
                initTheme:
                    isDarkMode == 1 ? AppTheme.lightTheme : AppTheme.darkTheme,
                child: Builder(builder: (context) {
                  return GetBuilder<ThemeController>(
                    init: ThemeController(),
                    builder: (ctr) {
                      return GetMaterialApp(
                        title: CommonConstant.ams,
                        theme: !ctr.isDark.value
                            ? ThemeData.light()
                            : ThemeData.dark(),
                        debugShowCheckedModeBanner: false,
                        home: Splashscreen(),
                        defaultTransition: Transition.rightToLeftWithFade,
                      );
                    },
                  );
                }),
              );
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<void> _init() async {
    await GetStorage.init();
  }
}
