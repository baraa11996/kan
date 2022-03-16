import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/fb_auth_controller.dart';
import '../../helpers/helpers.dart';
import '../../widgets/input_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with Helpers {
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _firstNameTextController;
  late TextEditingController _lastNameTextController;

  DateTime date = DateTime.now();
  CollectionReference userref = FirebaseFirestore.instance.collection("user");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTextController = TextEditingController();
    _firstNameTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _lastNameTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextController.dispose();
    _firstNameTextController.dispose();
    _passwordTextController.dispose();
    _lastNameTextController.dispose();
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
          children: [
            Container(
              height: 200.h,
              width: double.infinity,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'تسجيل ',
                      style: TextStyle(
                          fontSize: 30.sp,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      'انشاء حساب لطفل جديد',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            InputTextField(
              controller: _firstNameTextController,
              lable: 'أسم الطفل',
              hintText: 'أسم الطفل ',
              obscure: true,
              hasIcon: false,
              onChanged: (value) {
                setState(() {
                  _firstNameTextController;
                });
              },
            ),
            SizedBox(
              height: 25.h,
            ),
            InputTextField(
              controller: _lastNameTextController,
              lable: 'أسم العائلة',
              hintText: 'أسم العائلة ',
              obscure: true,
              hasIcon: false,
              onChanged: (value) {
                setState(() {
                  _lastNameTextController;
                });
              },
            ),
            SizedBox(
              height: 25.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'تاريخ الميلاد ',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () async {
                    DateTime? newdate = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2022 - 03 - 02),
                      firstDate: DateTime(1995),
                      lastDate: DateTime(2022),
                    );
                    if (newdate == null) return;
                    setState(() {
                      date = newdate;
                    });
                  },
                  child: Text(
                    'اختر التاريخ',
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${date.day}-${date.month}-${date.year}',
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
              ],
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
              await  performRegister();
              },
              child: Text(
                'تسجيل الحساب',
                style: TextStyle(color: Colors.white, fontSize: 18.sp),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                  minimumSize: Size(250.w, 60.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> performRegister() async {
    if (checkData()) {
      await register();
    }
  }

  bool checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty &&
        _firstNameTextController.text.isNotEmpty &&
        _lastNameTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(
      context: context,
      message: 'Enter required data!',
      error: true,
    );
    return false;
  }

  Future<void> register() async {
    bool status = await FbAuthController().createAccount(
      context: context,
      email: _emailTextController.text,
      firstname: _firstNameTextController.text,
      lastname: _lastNameTextController.text,
      password: _passwordTextController.text, date: date.year.toString() +'/' + date.month.toString() + '/' + date.day.toString(),
    );
    Navigator.pushReplacementNamed(context, '/signin_screen');
  }
}
