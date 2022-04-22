import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kan/prefs/shared_prefs.dart';
import 'package:kan/screens/auth/sgin_up.dart';
import 'package:kan/screens/auth/sign_in.dart';
import 'package:kan/screens/fahras_story.dart';
import 'package:kan/screens/favorite_screen.dart';
import 'package:kan/screens/features_screen.dart';
import 'package:kan/screens/home_screen.dart';
import 'package:kan/screens/lunch_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kan/screens/person_screen.dart';
import 'package:get/get.dart';
import 'package:kan/screens/who_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPrefController().initSharedPref();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        textDirection: TextDirection.rtl,
        theme: ThemeData(
          fontFamily: 'Noto',
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar'),
        ],
        initialRoute: ('/lunch_screen'),
        routes: {
          '/lunch_screen': (context) => const LunchScreen(),
          '/signup_screen': (context) => const SignUpScreen(),
          '/signin_screen': (context) => const SignInScreen(),
          '/home_screen': (context) => const HomeScreen(),
          '/person_screen': (context) => const PersonScreen(),
          '/fahras_screen': (context) => const FahrasStoryScreen(),
          '/favorite_screen': (context) => FavoriteScreen(),
          '/who_screen': (context) => const WhoScreen(),
          '/features_screen': (context) => const FeaturesScreen(),
        },
      ),
    );
  }
}
