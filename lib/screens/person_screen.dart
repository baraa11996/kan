import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:kan/screens/auth/change_password.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controller/fb_auth_controller.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

import '../controller/fb_storage.dart';
import '../prefs/shared_prefs.dart';

class PersonScreen extends StatefulWidget {
  const PersonScreen({Key? key}) : super(key: key);

  @override
  _PersonScreenState createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  CollectionReference userref = FirebaseFirestore.instance.collection("user");
  late File file;

  // late  String documentId;
  var imagepicker = ImagePicker();

  var url;

  Future<void> uploadFile(
      {required String filePath, required String name}) async {
    File file = File(filePath);
    try {
      await firebase_storage.FirebaseStorage.instance.ref(name).putFile(file);
    } on firebase_core.FirebaseException catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('معلومات الطفل'),
        centerTitle: true,
        toolbarHeight: 80,
      ),
      body: FutureBuilder(
          future: userref.doc(SharedPrefController().getId).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData && !snapshot.data!.exists) {
              return Text("Document does not exist");
            }
            if (snapshot.hasError) {
              return Text('Error');
            }
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/back.jfif'),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                clipBehavior: Clip.hardEdge,
                                // padding: EdgeInsets.all(10),
                                width: 150.w,
                                height: 150.h,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                       data['image'] == '' ? 'https://img.freepik.com/free-photo/little-child-sitting-floor-pretty-smiling-surprised-boy-playing-with-wooden-cubes-home-conceptual-image-with-copy-negative-space_155003-38485.jpg' : "${data['image']}"),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(75),
                                  border: Border.all(
                                      color: Colors.green, width: 3.w),
                                ),
                                // child: Image(
                                //   image:
                                //   fit: BoxFit.contain,
                                // ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      var imagepicked = await imagepicker.pickImage(
                                          source: ImageSource.gallery);

                                      File file = File(imagepicked!.path);
                                      await FbStorageUsersController().uploadImage(
                                        file: file,
                                        context: context,
                                        callBackUrl: ({
                                          required String url,
                                          required bool status,
                                        }) {

                                          print('URL => $url');
                                          print('status => $status');
                                          userref.doc(SharedPrefController().getId).update(
                                            {
                                              'image':url,
                                            },
                                          );
                                          setState(() {

                                          });
                                        },
                                      );
                                    },
                                    child: Text('تغيير الصورة '),
                                  ),
                                  TextButton(
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePassword(),),);
                                    },
                                    child: Text('تغيير كلمة المرور'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Icon(
                            (Icons.person),
                            size: 40,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Container(
                            width: 250.w,
                            height: 55.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                                child: Text(
                              "اسم الطفل : ${data['firstname']} ",
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Icon(
                            (Icons.person),
                            size: 40,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Container(
                            width: 250.w,
                            height: 55.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                                child: Text(
                              "اسم العائلة : ${data['lastname']} ",
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Icon(
                            (Icons.email),
                            size: 40,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Container(
                            width: 250.w,
                            height: 55.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                                child: Text(
                              "${data['email']} ",
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Icon(
                            (Icons.date_range),
                            size: 40,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Container(
                            width: 250.w,
                            height: 55.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                                child: Text(
                                  "${data['date']} ",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Icon(
                            (Icons.logout),
                            size: 40,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 25.w,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await FbAuthController().signOut();
                              Navigator.pushReplacementNamed(
                                  context, '/signin_screen');
                            },
                            child: Text('تسجيل الخروج'),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blueGrey,
                                minimumSize: Size(200.w, 60.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
            return SizedBox();
          }),
    );
  }
}
