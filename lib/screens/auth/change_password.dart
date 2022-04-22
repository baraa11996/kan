import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kan/prefs/shared_prefs.dart';

import '../../controller/fb_auth_controller.dart';
import '../../helpers/helpers.dart';
import '../../widgets/input_text_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> with Helpers {
  late TextEditingController _currentPasswordTextController;
  late TextEditingController _newPasswordTextController;

  @override
  void initState() {
    super.initState();
    _currentPasswordTextController = TextEditingController();
    _newPasswordTextController = TextEditingController();
  }

  @override
  void dispose() {
    _currentPasswordTextController.dispose();
    _newPasswordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('تغيير كلمة المرور'),
        centerTitle: true,
        toolbarHeight: 80,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InputTextField(
                  controller: _currentPasswordTextController,
                  textInputType: TextInputType.emailAddress,
                  lable: 'كلمة المرور الحالية',
                  hintText: 'كلمة المرور الحالية',
                  obscure: true,
                  hasIcon: false,
                  onChanged: (value) {
                    setState(() {
                      _currentPasswordTextController;
                    });
                  },
                ),
                SizedBox(height: 25.h),
                InputTextField(
                  controller: _newPasswordTextController,
                  lable: 'كلمة المرور الجديدة',
                  hintText: 'كلمة المرور الجديدة',
                  obscure: true,
                  hasIcon: false,
                  onChanged: (value) {
                    setState(() {
                      _newPasswordTextController;
                    });
                  },
                ),
                SizedBox(height: 45.h),
                ElevatedButton(
                  onPressed: () async {
                    await performChange();
                  },
                  child: Text(
                    'تغيير',
                    style: TextStyle(color: Colors.white, fontSize: 18.sp),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey,
                    minimumSize: Size(250.w, 60.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> performChange() async {
    if (checkData()) {
      await change();
    }
  }

  bool checkData() {
    if (_currentPasswordTextController.text.isNotEmpty &&
        _currentPasswordTextController.text !=
            SharedPrefController().password) {
      showSnackBar(
        context: context,
        message: 'Current Password wrong!',
        error: true,
      );
      return false;
    } else if (_currentPasswordTextController.text.isEmpty ||
        _newPasswordTextController.text.isEmpty) {
      showSnackBar(
        context: context,
        message: 'Enter required data!',
        error: true,
      );
      return false;
    }
    return true;
  }

  Future<void> change() async {
    await FbAuthController().changePassword(
      context,
      currentPassword: _currentPasswordTextController.text.toString(),
      newPassword: _newPasswordTextController.text.toString(),
    );
    SharedPrefController()
        .savePassword(password: _newPasswordTextController.text.toString());
    Navigator.pop(context);
  }
}
