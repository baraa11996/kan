import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kan/prefs/shared_prefs.dart';

import '../controller/fb_auth_controller.dart';

class LunchScreen extends StatefulWidget {
  const LunchScreen({Key? key}) : super(key: key);

  @override
  _LunchScreenState createState() => _LunchScreenState();
}


class _LunchScreenState extends State<LunchScreen> {
  late StreamSubscription _streamSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3),(){
      String route = SharedPrefController().logged ? '/home_screen' : '/signin_screen';
      Navigator.pushReplacementNamed(context, route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF8ad1d5),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image(
              image: AssetImage('images/ecd619e7-9c20-4cd5-ac9d-babcc3c472b3.jfif'),
            ),
          ),
          SizedBox(height: 150.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('جميع الحقوق محفوظة : 2022',style: TextStyle(color: Colors.grey),)
            ],
          ),
        ],
      ),
    );
  }
}
