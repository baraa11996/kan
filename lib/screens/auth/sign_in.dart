import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kan/prefs/shared_prefs.dart';

import '../../controller/fb_auth_controller.dart';
import '../../helpers/helpers.dart';
import '../../widgets/input_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with Helpers {
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextController.dispose();

    _passwordTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF8ad1d5),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200.h,
              width: double.infinity,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'دخول ',
                      style: TextStyle(
                          fontSize: 30.sp,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      'دخول لحساب الطفل الذي تم انشاؤه',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),


            SizedBox(
              height: 25.h,
            ),
            InputTextField(
              controller: _emailTextController,
              lable: 'البريد الالكتروني',
              hintText: 'البريد الالكتروني للأهل ',
              obscure: true,
              hasIcon: false,
              onChanged: (value) {
                setState(() {
                  _emailTextController;
                });
              },
            ),
            SizedBox(height: 25.h),
            InputTextField(
              controller: _passwordTextController,
              lable: 'كلمة المرور',
              hintText: 'كلمة المرور ',
              obscure: true,
              hasIcon: false,
              onChanged: (value) {
                setState(() {
                  _passwordTextController;
                });
              },
            ),
            SizedBox(height: 45.h),
            ElevatedButton(
              onPressed: () async {
                await performLogin();
              },
              child: Text(
                'دخول',
                style: TextStyle(color: Colors.white, fontSize: 18.sp),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                  minimumSize: Size(250.w, 60.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
            ),
            SizedBox(height: 25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('لا يوجد لدي حساب'),
                TextButton(onPressed: (){
                  Navigator.pushReplacementNamed(context, '/signup_screen');
                }, child: Text('سجل الان'))
              ],
            ),
          ],
        ),
      ),
    );
  }
  Future<void> performLogin() async {
    if (checkData()) {
      await login();
    }
  }

  bool checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(
      context: context,
      message: 'Enter required data!',
      error: true,
    );
    return false;
  }

  Future<void> login() async {
    bool status = await FbAuthController().signIn(
        context: context,
        email: _emailTextController.text,
        password: _passwordTextController.text);
    if (status) {
      SharedPrefController().saveLogin();
      Navigator.pushReplacementNamed(context, '/home_screen');
    }
  }
}
